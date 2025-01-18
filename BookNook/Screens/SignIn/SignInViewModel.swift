//
//  SignInViewModel.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject {
    // MARK: - Public Properties
    @Published var isButtonActive: Bool = false
    @Published var email: String = "" {
        didSet {
            updateButtonState()
        }
    }
    @Published var password: String = "" {
        didSet {
            updateButtonState()
        }
    }
    @Published var isPasswordVisible: Bool = false
    @Published var carouselImages: [Image] = []
    
    // MARK: - Init
    init() {
        self.carouselImages = [
            Image("TestBook1"),
            Image("TestBook2"),
            Image("TestBook3")
        ]
        
        updateButtonState()
    }
    
    // MARK: - Public Methods
    func signIn() -> Bool {
        return isButtonActive
    }
    
    // MARK: - Private Methods
    private func updateButtonState() {
        isButtonActive = SignInCredentialsValidator.canEnableSignIn(email: email, password: password)
    }
}
