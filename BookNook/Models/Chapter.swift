//
//  Chapter.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation

struct Chapter: Identifiable {
    let id = UUID()
    let title: String
    let isRead: Bool
    let isReading: Bool
}
