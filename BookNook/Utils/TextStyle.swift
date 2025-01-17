//
//  TextStyle.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

enum TextStyle {
    case title
    case h1
    case h2
    case h3
    case body
    case bodyBold
    case bodySmall
    case bodySmallBold
    case footnote
    case text
    case quote
    
    var font: Font {
        switch self {
        case .title:
            return .custom("AlumniSans-Bold", size: 96)
        case .h1:
            return .custom("AlumniSans-Bold", size: 48)
        case .h2:
            return .custom("AlumniSans-Bold", size: 24)
        case .h3:
            return .custom("AlumniSans-Bold", size: 14)
        case .body:
            return .custom("VelaSans-Regular", size: 16)
        case .bodyBold:
            return .custom("VelaSans-Bold", size: 16)
        case .bodySmall:
            return .custom("VelaSans-Regular", size: 14)
        case .bodySmallBold:
            return .custom("VelaSans-Bold", size: 14)
        case .footnote:
            return .custom("VelaSans-Regular", size: 10)
        case .text:
            return .custom("Georgia", size: 14)
        case .quote:
            return .custom("Georgia-Italic", size: 16)
        }
    }
    
    var lineSpacing: CGFloat {
        switch self {
        case .title:
            return 0
        case .h1, .h2, .h3:
            return 0
        case .body, .bodyBold, .bodySmall, .bodySmallBold, .footnote, .quote:
            return 0
        case .text:
            return 0
        }
    }
    
    var isUppercased: Bool {
        switch self {
        case .title, .h1, .h2, .h3:
            return true
        default:
            return false
        }
    }
}
