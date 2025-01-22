//
//  LocalizedKey.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation

struct LocalizedKey: RawRepresentable {
    let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }

    var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }
}

extension LocalizedKey {
    enum SignIn {
        static let titleMessage = LocalizedKey(rawValue: "sign_in_title_message").localized
        static let title = LocalizedKey(rawValue: "sign_in_title").localized
        static let buttonTitle = LocalizedKey(rawValue: "sign_in_button_title").localized
        static let emailPlaceholder = LocalizedKey(rawValue: "sign_in_email_placeholder").localized
        static let passwordPlaceholder = LocalizedKey(rawValue: "sign_in_password_placeholder").localized
    }
    
    enum Library {
        static let title = LocalizedKey(rawValue: "library_title").localized
        static let newBooks = LocalizedKey(rawValue: "library_new_books").localized
        static let popularBooks = LocalizedKey(rawValue: "library_popular_books").localized
    }
    
    enum Search {
        static let searchPrompt = LocalizedKey(rawValue: "search_prompt").localized
        static let recentRequests = LocalizedKey(rawValue: "search_recent_requests").localized
        static let genres = LocalizedKey(rawValue: "search_genres").localized
        static let authors = LocalizedKey(rawValue: "search_authors").localized
    }
    
    enum Bookmarks {
        static let title = LocalizedKey(rawValue: "bookmarks_title").localized
        static let currentlyReading = LocalizedKey(rawValue: "bookmarks_currently_reading").localized
        static let favoriteBooks = LocalizedKey(rawValue: "bookmarks_favorite_books").localized
        static let quotes = LocalizedKey(rawValue: "bookmarks_quotes").localized
    }
    
    enum BookDetails {
        static let progress = LocalizedKey(rawValue: "book_details_progress").localized
        static let chapters = LocalizedKey(rawValue: "book_details_chapters").localized
        static let read = LocalizedKey(rawValue: "book_details_read").localized
        static let addToFavorites = LocalizedKey(rawValue: "book_details_add_to_favorites").localized
        static let back = LocalizedKey(rawValue: "book_details_back").localized
    }

    enum Accessibility {
        static let tabLibrary = LocalizedKey(rawValue: "a11y_tab_library").localized
        static let tabSearch = LocalizedKey(rawValue: "a11y_tab_search").localized
        static let tabBookmarks = LocalizedKey(rawValue: "a11y_tab_bookmarks").localized
        static let tabLogout = LocalizedKey(rawValue: "a11y_tab_logout").localized
        static let tabCurrentBook = LocalizedKey(rawValue: "a11y_tab_current_book").localized
    }
}
