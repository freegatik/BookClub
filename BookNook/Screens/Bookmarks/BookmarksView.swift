//
//  BookmarksView.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

struct BookmarksView: View {
    // MARK: - Private Properties
    @StateObject private var viewModel = BookmarksViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                header
                currentReadingSection
                favoriteBookSection
                quotesSection
            }
            .padding()
            .padding(.bottom, Metrics.bottomPadding)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .scrollIndicators(.hidden)
        .background(Color.background)
        .onAppear {
            viewModel.loadData()
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
private extension BookmarksView {
    @ViewBuilder
    var header: some View {
        Text(LocalizedKey.Bookmarks.title)
            .textStyle(.h1)
            .foregroundStyle(.customSecondary)
            .padding(.bottom, Metrics.sectionSpacing)
    }
    
    @ViewBuilder
    var currentReadingSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(LocalizedKey.Bookmarks.currentlyReading)
                    .textStyle(.h2)
                    .foregroundStyle(.accentDark)
                
                Spacer()
                
                playButton
            }
            .frame(height: Metrics.headerHeight)
            
            Spacer(minLength: Metrics.itemSpacing)
            
            currentBookView
            
            Spacer(minLength: Metrics.sectionSpacing)
        }
    }
    
    @ViewBuilder
    var favoriteBookSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedKey.Bookmarks.favoriteBooks)
                .textStyle(.h2)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.titleSpacing)
            
            favoriteBookGrid
            
            Spacer(minLength: Metrics.sectionSpacing)
        }
    }
    
    @ViewBuilder
    var quotesSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedKey.Bookmarks.quotes)
                .textStyle(.h2)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.titleSpacing)
            
            quotesGrid
        }
    }
    
    @ViewBuilder
    var playButton: some View {
        Button(action: {
            viewModel.showCurrentBookDetails()
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.accentDark)
                    .frame(width: Metrics.playButtonSize, height: Metrics.playButtonSize)
                
                Image(ImageAssets.play)
                    .foregroundColor(.customWhite)
            }
        }
    }
    
    @ViewBuilder
    var currentBookView: some View {
        Button(action: {
            viewModel.showCurrentBookDetails()
        }) {
            HStack(alignment: .center, spacing: Metrics.bookItemSpacing) {
                Image(viewModel.currentBook.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Metrics.bookImageWidth, height: Metrics.bookImageHeight)
                    .clipShape(.rect(cornerRadius: Metrics.bookImageCornerRadius))
                    .clipped()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.currentBook.title.uppercased())
                        .textStyle(.h2)
                        .foregroundStyle(.accentDark)
                    
                    Spacer()
                        .frame(height: Metrics.titleSpacing)
                    
                    Text(viewModel.currentBook.chapter)
                        .textStyle(.bodySmallBold)
                        .foregroundStyle(.accentDark)
                    
                    Spacer()
                        .frame(height: Metrics.progressSpacing)
                    
                    ProgressView(value: viewModel.currentBook.progress)
                        .background(Color.accentMedium)
                        .tint(.accentDark)
                        .frame(height: Metrics.progressHeight)
                        .clipShape(.rect(cornerRadius: Metrics.progressCornerRadius))
                }
                
                Spacer()
            }
            .frame(height: Metrics.bookImageHeight)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    var favoriteBookGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: Metrics.gridSpacing) {
            ForEach(viewModel.favoriteBooks, id: \.id) { book in
                favoriteBookItem(book: book)
                    .frame(maxHeight: .infinity)
            }
        }
    }
    
    @ViewBuilder
    func favoriteBookItem(book: FavoriteBook) -> some View {
        Button(action: {
            viewModel.showBookDetails(for: book)
        }) {
            HStack(alignment: .center, spacing: Metrics.bookItemSpacing) {
                Image(book.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Metrics.bookImageWidth, height: Metrics.bookImageHeight)
                    .clipShape(.rect(cornerRadius: Metrics.bookImageCornerRadius))
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
    }
    
    @ViewBuilder
    var quotesGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: Metrics.quoteGridSpacing) {
            ForEach(viewModel.quotes, id: \.id) { quote in
                quoteItem(quote: quote)
                    .frame(maxHeight: .infinity)
            }
        }
    }
    
    @ViewBuilder
    func quoteItem(quote: Quote) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(quote.text)
                    .textStyle(.quote)
                    .foregroundStyle(.customBlack)
                    .lineLimit(nil)
                
                Spacer(minLength: Metrics.quoteTextSpacing)
                
                Text("\(quote.title) • \(quote.author)")
                    .textStyle(.footnote)
                    .foregroundStyle(.accentDark)
                    .lineLimit(Metrics.quoteAuthorLineLimit)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.accentLight)
        .clipShape(.rect(cornerRadius: Metrics.itemCornerRadius))
        .frame(maxHeight: .infinity)
    }
}

// MARK: - Metrics & Image Assets
private extension BookmarksView {
    enum Metrics {
        static let bottomPadding: CGFloat = 80
        static let sectionSpacing: CGFloat = 24
        static let titleSpacing: CGFloat = 16
        static let itemSpacing: CGFloat = 8
        static let headerHeight: CGFloat = 48
        static let gridSpacing: CGFloat = 8
        static let quoteGridSpacing: CGFloat = 16
        static let quoteTextSpacing: CGFloat = 8
        static let currentBookNegativeTopPadding: CGFloat = -8
        
        static let playButtonSize: CGFloat = 40
        static let bookImageWidth: CGFloat = 80
        static let bookImageHeight: CGFloat = 126
        static let bookImageCornerRadius: CGFloat = 4
        static let bookItemSpacing: CGFloat = 16
        static let progressHeight: CGFloat = 4
        static let progressCornerRadius: CGFloat = 4
        static let progressSpacing: CGFloat = 16
        static let textSpacing: CGFloat = 4
        static let titleLineLimit: Int = 2
        static let authorLineLimit: Int = 2
        static let quoteAuthorLineLimit: Int = 2
        static let itemCornerRadius: CGFloat = 8
    }
    
    enum ImageAssets {
        static let play = "Play"
    }
}
