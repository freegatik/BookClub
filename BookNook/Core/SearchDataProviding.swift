//
//  SearchDataProviding.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation

struct SearchCatalog: Sendable {
    var searchResults: [SearchResult]
    var requests: [Request]
    var genres: [Genre]
    var authors: [Author]
}

protocol SearchDataProviding: Sendable {
    func makeInitialCatalog() -> SearchCatalog
}

struct MockSearchDataProvider: SearchDataProviding {
    func makeInitialCatalog() -> SearchCatalog {
        SearchCatalog(
            searchResults: [
                SearchResult(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
                SearchResult(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
                SearchResult(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
                SearchResult(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
                SearchResult(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
                SearchResult(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
                SearchResult(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
                SearchResult(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист")
            ],
            requests: [
                Request(title: "iOS"),
                Request(title: "Swift"),
                Request(title: "Как достать соседа"),
                Request(title: "Чистый код: создание, анализ и рефакторинг")
            ],
            genres: [
                Genre(title: "Классика"),
                Genre(title: "Фэнтези"),
                Genre(title: "Фантастика"),
                Genre(title: "Детектив"),
                Genre(title: "Триллер"),
                Genre(title: "Исторический роман"),
                Genre(title: "Любовный роман"),
                Genre(title: "Приключения"),
                Genre(title: "Поэзия"),
                Genre(title: "Биография"),
                Genre(title: "Для подростков"),
                Genre(title: "Для детей")
            ],
            authors: [
                Author(imageName: "TestAuthor", title: "Братья Стругацкие"),
                Author(imageName: "TestAuthor", title: "Братья Стругацкие"),
                Author(imageName: "TestAuthor", title: "Братья Стругацкие"),
                Author(imageName: "TestAuthor", title: "Братья Стругацкие"),
                Author(imageName: "TestAuthor", title: "Братья Стругацкие"),
                Author(imageName: "TestAuthor", title: "Братья Стругацкие"),
                Author(imageName: "TestAuthor", title: "Братья Стругацкие")
            ]
        )
    }
}
