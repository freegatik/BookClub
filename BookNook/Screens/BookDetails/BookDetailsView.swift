//
//  BookDetailsView.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

struct BookDetailsView: View {
    // MARK: - Public Properties
    @Binding var isPresented: Bool
    let book: BookDetails
    
    // MARK: - Private Properties
    @StateObject private var viewModel: BookDetailsViewModel
    
    // MARK: - Init
    init(isPresented: Binding<Bool>, book: BookDetails) {
        self._isPresented = isPresented
        self.book = book
        self._viewModel = StateObject(wrappedValue: BookDetailsViewModel(book: book))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading, spacing: 0) {
                        coverImage
                        content
                    }
                    
                    backButton
                }
            }
            .background(Color.background)
            .scrollIndicators(.hidden)
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            viewModel.loadData()
        }
    }
}

// MARK: - View Components
private extension BookDetailsView {
    @ViewBuilder
    var coverImage: some View {
        ZStack(alignment: .bottom) {
            Image(viewModel.book.coverImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: Metrics.coverHeight)
                .clipped()
            
            LinearGradient(
                gradient: Gradient(colors: [
                    .clear,
                    .background
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: Metrics.gradientHeight)
        }
        .frame(maxWidth: .infinity, maxHeight: Metrics.coverHeight)
    }
    
    @ViewBuilder
    var content: some View {
        VStack(alignment: .leading) {
            actionButtons
            bookInfo
            if viewModel.book.progress != 0 {
                progressSection
            }
            chaptersSection
        }
        .padding()
    }
    
    @ViewBuilder
    var actionButtons: some View {
        HStack(spacing: Metrics.buttonSpacing) {
            readButton
                .frame(maxWidth: .infinity)
            
            favoriteButton
                .fixedSize()
        }
        .padding(.top, Metrics.buttonTopOffset)
    }
    
    @ViewBuilder
    var bookInfo: some View {
        Group {
            Spacer(minLength: Metrics.sectionSpacing)
            
            Text(viewModel.book.title.uppercased())
                .textStyle(.h1)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.titleSpacing)
            
            Text(viewModel.book.author)
                .textStyle(.body)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.sectionSpacing)
            
            Text(viewModel.formattedDescription)
                .textStyle(.body)
                .foregroundStyle(.accentDark)
                .multilineTextAlignment(.leading)
                .lineSpacing(Metrics.descriptionLineSpacing)
        }
    }
    
    @ViewBuilder
    var progressSection: some View {
        Group {
            Spacer(minLength: Metrics.sectionSpacing)
            
            Text(LocalizedKey.BookDetails.progress)
                .textStyle(.h2)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.progressSpacing)
            
            ProgressView(value: viewModel.book.progress)
                .background(Color.accentMedium)
                .tint(Color.accentDark)
                .clipShape(.rect(cornerRadius: Metrics.progressCornerRadius))
        }
    }
    
    @ViewBuilder
    var chaptersSection: some View {
        Group {
            Spacer(minLength: Metrics.sectionSpacing)
            
            Text(LocalizedKey.BookDetails.chapters)
                .textStyle(.h2)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.chaptersSpacing)
            
            chaptersGrid
        }
    }
    
    @ViewBuilder
    var readButton: some View {
        Button(action: {}) {
            HStack(alignment: .center, spacing: Metrics.buttonIconSpacing) {
                Spacer()
                
                Image(ImageAssets.play)
                    .resizable()
                    .frame(width: Metrics.buttonIconSize, height: Metrics.buttonIconSize)
                    .foregroundStyle(.customWhite)
                
                Text(LocalizedKey.BookDetails.read)
                    .textStyle(.bodyBold)
                    .foregroundStyle(.customWhite)
                
                Spacer()
            }
        }
        .padding()
        .background(Color.accentDark)
        .frame(height: Metrics.buttonHeight)
        .clipShape(.rect(cornerRadius: Metrics.buttonCornerRadius))
    }
    
    @ViewBuilder
    var favoriteButton: some View {
        Button(action: {}) {
            HStack(alignment: .center, spacing: Metrics.buttonIconSpacing) {
                Image(ImageAssets.bookmarks)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: Metrics.buttonIconSize, height: Metrics.buttonIconSize)
                    .foregroundStyle(.accentDark)
                
                Text(LocalizedKey.BookDetails.addToFavorites)
                    .textStyle(.bodyBold)
                    .foregroundStyle(.accentDark)
            }
        }
        .padding()
        .background(Color.accentLight)
        .frame(height: Metrics.buttonHeight)
        .clipShape(.rect(cornerRadius: Metrics.buttonCornerRadius))
    }
    
    @ViewBuilder
    var chaptersGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 0) {
            ForEach(viewModel.book.chapters, id: \.id) { chapter in
                chapterItem(chapter: chapter)
                    .frame(maxHeight: .infinity)
            }
        }
    }
    
    @ViewBuilder
    func chapterItem(chapter: Chapter) -> some View {
        HStack(alignment: .center) {
            Text(chapter.title)
                .textStyle(chapter.isReading ? .bodyBold : .body)
                .foregroundStyle(.accentDark)
                .lineLimit(1)
            
            Spacer()
            
            if chapter.isRead {
                Image(ImageAssets.read)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(.accentMedium)
                    .frame(width: Metrics.chapterIconSize, height: Metrics.chapterIconSize)
            } else if chapter.isReading {
                Button(action: {}) {
                    Image(ImageAssets.readingNow)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(.accentDark)
                        .frame(width: Metrics.chapterIconSize, height: Metrics.chapterIconSize)
                }
            }
        }
        .padding(.vertical)
        .frame(maxHeight: .infinity)
    }
    
    @ViewBuilder
    var backButton: some View {
        Button(action: {
            isPresented = false
        }) {
            HStack {
                Image(ImageAssets.arrowLeft)
                    .foregroundColor(.customWhite)
                Text(LocalizedKey.BookDetails.back)
                    .textStyle(.body)
                    .foregroundColor(.customWhite)
            }
            .padding()
            .padding(.top, Metrics.backButtonTopPadding)
        }
    }
}

// MARK: - Metrics & Image Assets
private extension BookDetailsView {
    enum Metrics {
        static let coverHeight = UIScreen.main.bounds.height * 0.435
        static let gradientHeight = coverHeight / 2
        static let buttonTopOffset: CGFloat = -50
        static let buttonSpacing: CGFloat = 8
        static let buttonHeight: CGFloat = 50
        static let buttonCornerRadius: CGFloat = 12
        static let buttonIconSize: CGFloat = 18
        static let buttonIconSpacing: CGFloat = 8
        static let sectionSpacing: CGFloat = 24
        static let titleSpacing: CGFloat = 8
        static let progressSpacing: CGFloat = 16
        static let progressCornerRadius: CGFloat = 4
        static let chaptersSpacing: CGFloat = 8
        static let chapterIconSize: CGFloat = 24
        static let backButtonTopPadding: CGFloat = UIScreen.main.bounds.height * 0.055
        static let descriptionLineSpacing: CGFloat = 4
    }
    
    enum ImageAssets {
        static let play = "Play"
        static let bookmarks = "Bookmarks"
        static let read = "Read"
        static let readingNow = "ReadingNow"
        static let arrowLeft = "ArrowLeft"
    }
}
