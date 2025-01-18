//
//  SignInView.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

struct SignInView: View {
    // MARK: - Public Properties
    @Binding var isLoggedIn: Bool
    @Binding var selectedTab: CustomTabBar.Tab
    
    // MARK: - Private Properties
    @State private var carouselScrollOffset: CGFloat = 0
    
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            carouselView
                .padding(.top, Metrics.topPadding)
                .padding(.bottom, Metrics.bottomPadding)
            headerView
            authFieldsView
                .padding(.top, Metrics.authFieldsTopPadding)
            authButton
                .padding(.top, Metrics.buttonTopPadding)
                .padding(.bottom, Metrics.buttonBottomPadding)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.accentDark)
    }
}

// MARK: - View Components
private extension SignInView {
    @ViewBuilder
    var headerView: some View {
        VStack(alignment: .leading, spacing: Metrics.headerSpacing) {
            Text(LocalizedKey.SignIn.titleMessage)
                .textStyle(.h1)
                .foregroundStyle(.accentLight)
            
            let titleLines = LocalizedKey.SignIn.title.splitIntoLines()
            
            VStack(alignment: .leading, spacing: Metrics.headerTitleInternalSpacing) {
                Text(titleLines.first)
                    .textStyle(.title)
                    .foregroundStyle(.customSecondary)
                
                if !titleLines.second.isEmpty {
                    Text(titleLines.second)
                        .textStyle(.title)
                        .foregroundStyle(.customSecondary)
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var carouselView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Metrics.spacing) {
                ForEach(0..<2) { _ in
                    ForEach(Array(viewModel.carouselImages.enumerated()), id: \.offset) { _, item in
                        item
                            .resizable()
                            .scaledToFill()
                            .frame(width: Metrics.itemWidth, height: Metrics.itemHeight)
                            .cornerRadius(Metrics.cornerRadius)
                            .clipped()
                    }
                }
            }
            .offset(x: carouselScrollOffset, y: 0)
        }
        .accessibilityIdentifier("carouselView")
        .disabled(true)
        .onAppear {
            startCarouselAutoScroll(itemsCount: viewModel.carouselImages.count)
        }
        .frame(height: Metrics.itemHeight)
    }
    
    @ViewBuilder
    var authFieldsView: some View {
        VStack(spacing: 0) {
            CustomInputField(
                type: .email,
                text: $viewModel.email,
                isPasswordVisible: $viewModel.isPasswordVisible
            )
            .accessibilityIdentifier("emailField")
            
            DividerLine()
            
            CustomInputField(
                type: .password,
                text: $viewModel.password,
                isPasswordVisible: $viewModel.isPasswordVisible
            )
            .accessibilityIdentifier("passwordField")
        }
        .overlay(
            RoundedRectangle(cornerRadius: Metrics.inputFieldCornerRadius)
                .stroke(.accentMedium, lineWidth: Metrics.inputFieldBorderWidth)
        )
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var authButton: some View {
        Button(action: signInAction) {
            Text(LocalizedKey.SignIn.buttonTitle)
                .textStyle(.bodyBold)
                .foregroundColor(viewModel.isButtonActive ? .accentDark : .accentLight)
                .padding()
                .frame(maxWidth: .infinity)
                .background(viewModel.isButtonActive ? .customWhite : .accentMedium)
                .cornerRadius(Metrics.buttonCornerRadius)
        }
        .accessibilityIdentifier("authButton")
        .accessibilityLabel(LocalizedKey.SignIn.buttonTitle)
        .padding(.horizontal)
        .disabled(!viewModel.isButtonActive)
    }
}

// MARK: - Carousel Methods
private extension SignInView {
    func startCarouselAutoScroll(itemsCount: Int) {
        let totalWidth = CGFloat(itemsCount) * (Metrics.itemWidth + Metrics.spacing)
        
        withAnimation(.linear(duration: TimeInterval(itemsCount * 5)).repeatForever(autoreverses: false)) {
            carouselScrollOffset = -totalWidth
        }
    }
}

// MARK: - Actions
private extension SignInView {
    func signInAction() {
        if viewModel.signIn() {
            withAnimation {
                isLoggedIn = true
                selectedTab = .library
            }
        }
    }
}

// MARK: - Metrics
private extension SignInView {
    enum Metrics {
        // Carousel
        static let itemHeight: CGFloat = UIScreen.main.bounds.height * 0.309
        static let itemWidth: CGFloat = itemHeight * 0.637
        static let spacing: CGFloat = itemWidth / 21.5
        static let cornerRadius: CGFloat = itemWidth / 43
        
        // Padding
        static let topPadding: CGFloat = UIScreen.main.bounds.height * 0.055
        static let bottomPadding: CGFloat = UIScreen.isSmallDevice
            ? UIScreen.main.bounds.height * 0.01
            : UIScreen.main.bounds.height * 0.055
        static let buttonTopPadding: CGFloat = UIScreen.main.bounds.height * 0.0275
        static let buttonBottomPadding: CGFloat = UIScreen.main.bounds.height * 0.0275
        static let authFieldsTopPadding: CGFloat = UIScreen.isSmallDevice ? 0 : UIScreen.main.bounds.height * 0.00915
        
        // Button
        static let buttonCornerRadius: CGFloat = 12
        
        // Input field
        static let inputFieldCornerRadius: CGFloat = 10
        static let inputFieldBorderWidth: CGFloat = 1
        
        // Header
        static let headerSpacing: CGFloat = -12
        static let headerTitleInternalSpacing: CGFloat = -36
    }
}
