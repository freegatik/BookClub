//
//  LibraryView.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

struct LibraryView: View {
    // MARK: - Private Properties
    @StateObject private var viewModel = LibraryViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                header
                newBooksSection
                if !viewModel.books.isEmpty {
                    popularBooksSection
                }
            }
            .padding()
            .padding(.bottom, Metrics.bottomPadding)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .accessibilityIdentifier("libraryRoot")
        .scrollIndicators(.hidden)
        .background(Color.background)
        .onAppear {
            viewModel.loadBooks()
        }
        .fullScreenCover(isPresented: $viewModel.isBookDetailsPresented) {
            if let selectedBook = viewModel.selectedBook {
                BookDetailsView(
                    isPresented: $viewModel.isBookDetailsPresented,
                    book: selectedBook
                )
            }
        }
    }
}

// MARK: - View Components
private extension LibraryView {
    @ViewBuilder
    var header: some View {
        Text(LocalizedKey.Library.title)
            .textStyle(.h1)
            .foregroundStyle(.customSecondary)
            .padding(.bottom, Metrics.sectionSpacing)
    }
    
    @ViewBuilder
    var newBooksSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedKey.Library.newBooks)
                .textStyle(.h2)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.titleSpacing)
            
            SlideCarouselView()
            
            Spacer(minLength: Metrics.sectionSpacing)
        }
    }
    
    @ViewBuilder
    var popularBooksSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedKey.Library.popularBooks)
                .textStyle(.h2)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.titleSpacing)
            
            bookGrid
        }
    }
    
    @ViewBuilder
    var bookGrid: some View {
        if UIScreen.isSmallDevice {
            smallDeviceGrid
        } else {
            largeDeviceGrid
        }
    }
    
    @ViewBuilder
    var smallDeviceGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: Metrics.gridSpacing) {
            ForEach(viewModel.books) { book in
                smallDeviceBookItem(book: book)
            }
        }
    }
    
    @ViewBuilder
    var largeDeviceGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: Metrics.gridSpacing),
                GridItem(.flexible(), spacing: Metrics.gridSpacing),
                GridItem(.flexible(), spacing: Metrics.gridSpacing)
            ],
            spacing: Metrics.gridSpacing
        ) {
            ForEach(viewModel.books) { book in
                largeDeviceBookItem(book: book)
            }
        }
    }
    
    @ViewBuilder
    func smallDeviceBookItem(book: Book) -> some View {
        Button(action: {
            viewModel.showBookDetails(for: book)
        }) {
            HStack(alignment: .center, spacing: Metrics.bookItemSpacing) {
                Image(book.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Metrics.smallImageWidth, height: Metrics.smallImageHeight)
                    .clipShape(.rect(cornerRadius: Metrics.bookSmallImageCornerRadius))
                    .clipped()
                
                VStack(alignment: .leading, spacing: Metrics.textSpacing) {
                    Text(book.title.uppercased())
                        .textStyle(.h2)
                        .lineLimit(Metrics.titleLineLimit)
                        .foregroundStyle(.accentDark)
                    
                    Text(book.author)
                        .textStyle(.bodySmall)
                        .lineLimit(Metrics.authorLineLimit)
                        .foregroundStyle(.accentDark)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    func largeDeviceBookItem(book: Book) -> some View {
        Button(action: {
            viewModel.showBookDetails(for: book)
        }) {
            VStack(alignment: .leading, spacing: Metrics.textSpacing) {
                Image(book.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: Metrics.largeImageHeight)
                    .clipShape(.rect(cornerRadius: Metrics.bookLargeImageCornerRadius))
                    .clipped()
                
                Spacer()
                    .frame(height: Metrics.textSpacing)
                
                Text(book.title.uppercased())
                    .textStyle(.h3)
                    .lineLimit(Metrics.titleLineLimit)
                    .foregroundStyle(.accentDark)
                
                Text(book.author)
                    .textStyle(.footnote)
                    .lineLimit(Metrics.authorLineLimit)
                    .foregroundStyle(.accentDark)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Constants
private extension LibraryView {
    enum Metrics {
        static let bottomPadding: CGFloat = 80
        static let sectionSpacing: CGFloat = 24
        static let titleSpacing: CGFloat = 16
        static let gridSpacing: CGFloat = UIScreen.isSmallDevice ? 8 : 16
        static let textSpacing: CGFloat = 4
        static let bookItemSpacing: CGFloat = 16
        static let bookSmallImageCornerRadius: CGFloat = smallImageHeight * 0.036
        static let bookLargeImageCornerRadius: CGFloat = largeImageHeight * 0.036
        static let titleLineLimit: Int? = nil
        static let authorLineLimit: Int? = nil
        static let smallImageWidth: CGFloat = 80
        static let smallImageHeight: CGFloat = 126
        static let largeImageHeight: CGFloat = UIScreen.main.bounds.height * 0.204
    }
}
