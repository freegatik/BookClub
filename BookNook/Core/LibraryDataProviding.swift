//
//  LibraryDataProviding.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation

struct LibraryCatalog: Sendable {
    let books: [Book]
}

protocol LibraryDataProviding: Sendable {
    func makeLibraryCatalog() -> LibraryCatalog
}

struct MockLibraryDataProvider: LibraryDataProviding {
    func makeLibraryCatalog() -> LibraryCatalog {
        LibraryCatalog(books: MockLibraryDataProvider.sampleBooks)
    }

    /// Shared catalog used by the default library screen (matches prior `LibraryViewModel.SampleData`).
    static let sampleBooks: [Book] = [
        Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
        Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
        Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский"),
        Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
        Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
        Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский"),
        Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
        Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
        Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский"),
        Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
        Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
        Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский"),
        Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
        Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
        Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский")
    ]
}
