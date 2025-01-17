//
//  UIScreen+Extensions.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import UIKit

extension UIScreen {
    static var isSmallDevice: Bool {
        main.bounds.height < 700
    }
}
