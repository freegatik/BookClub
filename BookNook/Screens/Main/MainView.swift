//
//  MainView.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

struct MainView: View {
    // MARK: - Private Properties
    @StateObject private var viewModel = MainViewModel()
    @State private var selectedTab: CustomTabBar.Tab = .library
    @State private var isLoggedIn: Bool = false
    @State private var searchText: String = ""
    @State private var isBookDetailsPresented: Bool = false
    
    var body: some View {
        ZStack {
            contentView
            if shouldShowTabBar {
                tabBarView
            }
        }
        .onChange(of: selectedTab) { _, newTab in
            handleTabChange(newTab)
        }
        .fullScreenCover(isPresented: $isBookDetailsPresented) {
            BookDetailsView(isPresented: $isBookDetailsPresented, book: viewModel.currentBook)
        }
    }
}

// MARK: - View Components
private extension MainView {
    @ViewBuilder
    var contentView: some View {
        if !isLoggedIn {
            SignInView(isLoggedIn: $isLoggedIn, selectedTab: $selectedTab)
        } else {
            tabContent
        }
    }
    
    @ViewBuilder
    var tabContent: some View {
        switch selectedTab {
        case .library:
            LibraryView()
        case .search:
            SearchView(searchText: $searchText)
        case .bookmarks:
            BookmarksView()
        case .logout:
            SignInView(isLoggedIn: $isLoggedIn, selectedTab: $selectedTab)
        }
    }
    
    @ViewBuilder
    var tabBarView: some View {
        VStack {
            Spacer()
            CustomTabBar(
                selectedTab: $selectedTab,
                isBookDetailsPresented: $isBookDetailsPresented,
                currentBook: viewModel.currentBook
            )
        }
    }
    
    var shouldShowTabBar: Bool {
        isLoggedIn && searchText.isEmpty && !isBookDetailsPresented
    }
}

// MARK: - Actions
private extension MainView {
    func handleTabChange(_ newTab: CustomTabBar.Tab) {
        if newTab == .logout {
            isLoggedIn = false
        }
        if newTab == .search {
            searchText = ""
        }
    }
}
