//
//  BookDetailsViewModel.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation
import SwiftUI

@MainActor
final class BookDetailsViewModel: ObservableObject {
    // MARK: - Public Properties
    @Published var book: BookDetails
    @Published var formattedDescription: String
    
    // MARK: - Init
    init(book: BookDetails) {
        self.book = book
        self.formattedDescription = Self.formatDescription(book.description)
    }
    
    // MARK: - Public Methods
    func loadData() {
        self.formattedDescription = Self.formatDescription(book.description)
    }
    
    // MARK: - Private Methods
    private static func formatDescription(_ text: String) -> String {
        text.components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
            .joined(separator: "\n\n")
    }
}

// MARK: - Sample Data
extension BookDetailsViewModel {
    enum SampleData {
        static let book = BookDetails(
            coverImageName: "TestBookBackground",
            title: "Код да Винчи",
            author: "Дэн Браун",
            description:
"""
Секретный код скрыт в работах Леонардо да Винчи...
Только он поможет найти христианские святыни, дающие немыслимые власть и могущество...
Ключ к величайшей тайне, над которой человечество билось веками, наконец может быть найден... 
""",
            progress: 0.7,
            chapters: [
                Chapter(title: "Пролог", isRead: true, isReading: false),
                Chapter(title: "Глава 1", isRead: true, isReading: false),
                Chapter(title: "Глава 2", isRead: true, isReading: false),
                Chapter(title: "Глава 3", isRead: false, isReading: true),
                Chapter(title: "Глава 4", isRead: false, isReading: false),
                Chapter(title: "Глава 5", isRead: false, isReading: false),
                Chapter(title: "Глава 6", isRead: false, isReading: false),
                Chapter(title: "Глава 7", isRead: false, isReading: false)
            ]
        )
    }
}
