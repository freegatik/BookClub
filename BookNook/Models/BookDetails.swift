//
//  BookDetails.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation

struct BookDetails: Identifiable {
    let id = UUID()
    let coverImageName: String
    let title: String
    let author: String
    let description: String
    let progress: Double
    let chapters: [Chapter]
}
