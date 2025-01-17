//
//  Text+Extensions.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

extension Text {
    func textStyle(_ style: TextStyle) -> some View {
        self
            .font(style.font)
            .lineSpacing(style.lineSpacing)
            .textCase(style.isUppercased ? .uppercase : .none)
    }
}
