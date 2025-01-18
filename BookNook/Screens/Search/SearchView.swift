//
//  SearchView.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

struct SearchView: View {
    // MARK: - Public Properties
    @Binding var searchText: String

    // MARK: - Private Properties
    @StateObject private var viewModel: SearchViewModel

    init(searchText: Binding<String>) {
        _searchText = searchText
        _viewModel = StateObject(wrappedValue: SearchViewModel())
    }

    init(searchText: Binding<String>, viewModel: SearchViewModel) {
        _searchText = searchText
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if searchText.isEmpty {
                        emptySearchContent
                    } else {
                        searchResults
                    }
                }
                .padding()
                .padding(.bottom, Metrics.bottomPadding)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .scrollIndicators(.hidden)
            .background(Color.background)
            .navigationTitle("")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: LocalizedKey.Search.searchPrompt
            )
            .toolbarBackground(Color.background, for: .navigationBar)
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
}

// MARK: - View Components
private extension SearchView {
    @ViewBuilder
    var emptySearchContent: some View {
        VStack(alignment: .leading, spacing: Metrics.sectionSpacing) {
            if !viewModel.requests.isEmpty {
                recentRequestsSection
            }
            if !viewModel.genres.isEmpty {
                genresSection
            }
            if !viewModel.authors.isEmpty {
                authorsSection
            }
        }
    }
    
    @ViewBuilder
    var searchResults: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: Metrics.searchResultSpacing) {
            ForEach(viewModel.searchResults, id: \.id) { result in
                searchResultItem(result: result)
                    .frame(maxHeight: .infinity)
            }
        }
    }
    
    @ViewBuilder
    var recentRequestsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedKey.Search.recentRequests)
                .textStyle(.h2)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.titleSpacing)
            
            requestGrid
        }
    }
    
    @ViewBuilder
    var genresSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedKey.Search.genres)
                .textStyle(.h2)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.titleSpacing)
            
            genreGrid
        }
    }
    
    @ViewBuilder
    var authorsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(LocalizedKey.Search.authors)
                .textStyle(.h2)
                .foregroundStyle(.accentDark)
            
            Spacer(minLength: Metrics.titleSpacing)
            
            authorGrid
        }
    }
    
    @ViewBuilder
    var requestGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: Metrics.gridSpacing) {
            ForEach(viewModel.requests, id: \.id) { request in
                requestItem(request: request)
            }
        }
    }
    
    @ViewBuilder
    var genreGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Metrics.gridSpacing) {
            ForEach(viewModel.genres, id: \.id) { genre in
                genreItem(genre: genre)
            }
        }
    }
    
    @ViewBuilder
    var authorGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: Metrics.gridSpacing) {
            ForEach(viewModel.authors, id: \.id) { author in
                authorItem(author: author)
            }
        }
    }
    
    @ViewBuilder
    func searchResultItem(result: SearchResult) -> some View {
        Button(action: {
            viewModel.showBookDetails(for: result)
        }) {
            HStack(alignment: .center, spacing: Metrics.searchResultItemSpacing) {
                Image(result.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Metrics.searchResultImageWidth, height: Metrics.searchResultImageHeight)
                    .clipShape(.rect(cornerRadius: Metrics.searchResultImageCornerRadius))
                    .clipped()
                
                VStack(alignment: .leading, spacing: Metrics.searchResultTextSpacing) {
                    Text(result.title.uppercased())
                        .textStyle(.h2)
                        .lineLimit(Metrics.searchResultTitleLineLimit)
                        .foregroundStyle(.accentDark)
                    
                    Text(result.author)
                        .textStyle(.bodySmall)
                        .lineLimit(Metrics.searchResultAuthorLineLimit)
                        .foregroundStyle(.accentDark)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    func genreItem(genre: Genre) -> some View {
        HStack {
            Text(genre.title)
                .textStyle(.bodySmall)
                .foregroundStyle(.accentDark)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.accentLight)
        .clipShape(.rect(cornerRadius: Metrics.itemCornerRadius))
        .onTapGesture {
            searchText = genre.title
        }
    }
    
    @ViewBuilder
    func authorItem(author: Author) -> some View {
        HStack {
            Image(author.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Metrics.authorImageSize, height: Metrics.authorImageSize)
                .clipped()
                .clipShape(Circle())
            
            Text(author.title)
                .textStyle(.body)
                .foregroundStyle(.accentDark)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.accentLight)
        .clipShape(.rect(cornerRadius: Metrics.itemCornerRadius))
        .onTapGesture {
            searchText = author.title
        }
    }
    
    @ViewBuilder
    func requestItem(request: Request) -> some View {
        HStack {
            Image(ImageAssets.history)
                .renderingMode(.template)
                .foregroundStyle(.accentDark)
                .padding(.trailing, Metrics.requestIconSpacing)
            
            Text(request.title)
                .textStyle(.bodySmall)
                .foregroundStyle(.accentDark)
                .lineLimit(1)
            
            Spacer()
            
            Button(action: {
                viewModel.removeRequest(request)
            }) {
                Image(ImageAssets.close)
                    .renderingMode(.template)
                    .foregroundStyle(.accentDark)
            }
        }
        .padding()
        .background(Color.accentLight)
        .clipShape(.rect(cornerRadius: Metrics.itemCornerRadius))
        .frame(maxHeight: .infinity)
        .onTapGesture {
            searchText = request.title
        }
    }
}

// MARK: - Metrics & Image Assets
private extension SearchView {
    enum Metrics {
        static let bottomPadding: CGFloat = 80
        static let sectionSpacing: CGFloat = 24
        static let titleSpacing: CGFloat = 16
        static let gridSpacing: CGFloat = 8
        static let searchResultSpacing: CGFloat = 16
        static let searchResultItemSpacing: CGFloat = 16
        static let searchResultImageWidth: CGFloat = 80
        static let searchResultImageHeight: CGFloat = 126
        static let searchResultImageCornerRadius: CGFloat = 4
        static let searchResultTextSpacing: CGFloat = 4
        static let searchResultTitleLineLimit: Int = 2
        static let searchResultAuthorLineLimit: Int = 2
        static let itemCornerRadius: CGFloat = 8
        static let authorImageSize: CGFloat = 48
        static let requestIconSpacing: CGFloat = 8
    }
    
    enum ImageAssets {
        static let history = "History"
        static let close = "Close"
    }
}
