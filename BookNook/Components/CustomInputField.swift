//
//  CustomInputField.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

enum InputFieldType {
    case email
    case password
    
    var placeholder: String {
        switch self {
        case .email:
            return LocalizedKey.SignIn.emailPlaceholder
        case .password:
            return LocalizedKey.SignIn.passwordPlaceholder
        }
    }
    
    var iconName: String {
        switch self {
        case .email:
            return "Close"
        case .password:
            return "EyeOn"
        }
    }
}

struct CustomInputField: View {
    // MARK: - Public Properties
    let type: InputFieldType
    @Binding var text: String
    @Binding var isPasswordVisible: Bool
    var buttonImageName: String {
        if type == .email {
            return type.iconName
        } else {
            return isPasswordVisible ? "EyeOff" : "EyeOn"
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                placeholderView(width: geometry.size.width * Metrics.placeholderWidthRatio)
                Spacer()
                inputView(geometry: geometry)
                actionButton
            }
            .padding(.horizontal, Metrics.horizontalPadding)
        }
        .frame(height: Metrics.fieldHeight)
    }
}

// MARK: - View Components
private extension CustomInputField {
    @ViewBuilder
    func placeholderView(width: CGFloat) -> some View {
        Text(type.placeholder)
            .textStyle(.bodySmall)
            .foregroundColor(.accentMedium)
            .lineLimit(1)
            .frame(width: width, alignment: .leading)
    }
    
    @ViewBuilder
    func inputView(geometry: GeometryProxy) -> some View {
        if type == .password && !isPasswordVisible {
            SecureField("", text: $text)
                .inputStyle(width: geometry.size.width * Metrics.inputWidthRatio)
        } else {
            TextField("", text: $text)
                .inputStyle(width: geometry.size.width * Metrics.inputWidthRatio)
        }
    }
    
    @ViewBuilder
    var actionButton: some View {
        if !text.isEmpty {
            Button(action: actionButtonTapped) {
                Image(buttonImageName)
                    .foregroundColor(.accentMedium)
            }
            .frame(width: Metrics.actionButtonWidth)
        } else {
            Color.clear
                .frame(width: Metrics.actionButtonWidth)
        }
    }
}

// MARK: - Actions
private extension CustomInputField {
    func actionButtonTapped() {
        switch type {
        case .email:
            text = ""
        case .password:
            isPasswordVisible.toggle()
        }
    }
}

// MARK: - Metrics
private extension CustomInputField {
    enum Metrics {
        // Field
        static let fieldHeight: CGFloat = 44
        static let inputWidthRatio: CGFloat = 0.65
        static let placeholderWidthRatio: CGFloat = 0.15
        
        // Padding
        static let horizontalPadding: CGFloat = 16
        
        // Action Button
        static let actionButtonWidth: CGFloat = 24
    }
}

// MARK: - Input Style
private extension View {
    func inputStyle(width: CGFloat) -> some View {
        self
            .foregroundColor(.accentLight)
            .font(.custom("VelaSans-Regular", size: 14))
            .frame(width: width, height: CustomInputField.Metrics.fieldHeight)
    }
}
