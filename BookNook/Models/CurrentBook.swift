//
//  CurrentBook.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

struct CurrentBook: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let chapter: String
    let progress: Double
}
