//
//  UITestSession.swift
//  BookNookUITests
//
//  Created by Anton Solovev on 11.05.2026.
//

import XCTest

enum UITestSession {
    static func resetHostBeforeAppLaunch() {
        XCUIDevice.shared.press(.home)
        Thread.sleep(forTimeInterval: 0.5)
    }
}
