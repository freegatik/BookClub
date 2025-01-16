//
//  Quote.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation

struct Quote: Identifiable {
    let id = UUID()
    let text: String
    let title: String
    let author: String
}
