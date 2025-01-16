//
//  SearchResult.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

struct SearchResult: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let author: String
}
