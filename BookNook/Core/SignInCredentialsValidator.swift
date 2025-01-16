//
//  SignInCredentialsValidator.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation

enum SignInCredentialsValidator: Sendable {
    static func canEnableSignIn(email: String, password: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedEmail.isEmpty
            && !password.isEmpty
            && isValidEmail(trimmedEmail)
    }

    static func isValidEmail(_ email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let pattern = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
}
