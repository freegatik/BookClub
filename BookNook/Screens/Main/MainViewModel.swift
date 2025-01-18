//
//  MainViewModel.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation
import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    // MARK: - Public Properties
    @Published var currentBook: BookDetails
    
    // MARK: - Init
    init() {
        self.currentBook = BookDetailsViewModel.SampleData.book
    }
}
