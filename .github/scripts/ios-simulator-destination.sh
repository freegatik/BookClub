#!/usr/bin/env bash
set -euo pipefail

PROJECT="${1:?project}"
SCHEME="${2:?scheme}"
MIN_IOS="${IPHONEOS_DEPLOYMENT_TARGET:-18.2}"

OUT="$(mktemp)"
trap 'rm -f "$OUT"' EXIT

refresh_destinations() {
  xcodebuild -project "$PROJECT" -scheme "$SCHEME" -sdk iphonesimulator -showdestinations >"$OUT" 2>&1 || true
  if ! grep -q "platform:iOS Simulator" "$OUT" || ! grep -qi "iPhone" "$OUT"; then
    xcodebuild -project "$PROJECT" -scheme "$SCHEME" -showdestinations >"$OUT" 2>&1 || true
  fi
}

for _ in $(seq 1 18); do
  refresh_destinations
  if grep -q "platform:iOS Simulator" "$OUT" && grep -qi "iPhone" "$OUT"; then
    break
  fi
  sleep 5
done

python3 - "$OUT" "$MIN_IOS" <<'PY'
import re
import sys
from itertools import zip_longest

path, min_s = sys.argv[1], sys.argv[2]


def vp(s):
    return [int(x) for x in s.replace(" ", "").split(".") if x.isdigit()]


def ge_os(version: str, minimum: str) -> bool:
    for x, y in zip_longest(vp(version), vp(minimum), fillvalue=0):
        if x != y:
            return x >= y
    return True


def pick_from_showdestinations(text: str):
    good, weak = [], []
    for block in re.findall(r"\{[^}]*platform:iOS Simulator[^}]*\}", text):
        bl = block.lower()
        if "iphonesimulator:placeholder" in bl.replace(" ", ""):
            continue
        if "error:" in bl:
            continue
        if "iphone" not in bl:
            continue
        m_os = re.search(r"OS:\s*([^,}]+)", block)
        m_name = re.search(r"name:\s*([^,}]+)", block)
        if not m_os or not m_name:
            continue
        os_ver = m_os.group(1).strip()
        if os_ver.lower() in ("undefined", ""):
            continue
        name = m_name.group(1).strip()
        spec = f"platform=iOS Simulator,name={name},OS={os_ver}"
        row = (tuple(vp(os_ver)), spec)
        if ge_os(os_ver, min_s):
            good.append(row)
        else:
            weak.append(row)

    def best(rows):
        if not rows:
            return None
        rows.sort(key=lambda t: t[0], reverse=True)
        return rows[0][1]

    return best(good) or best(weak)


text = open(path, encoding="utf-8", errors="replace").read()
chosen = pick_from_showdestinations(text)
if chosen:
    print(chosen)
    raise SystemExit(0)

sys.stderr.write("--- xcodebuild -showdestinations (tail) ---\n")
sys.stderr.write("\n".join(text.splitlines()[-60:]))
sys.stderr.write("\n---\n")
sys.stderr.write(
    "error: no usable iPhone Simulator in showdestinations "
    "(install runtime: xcodebuild -downloadPlatform iOS)\n"
)
raise SystemExit(1)
PY
