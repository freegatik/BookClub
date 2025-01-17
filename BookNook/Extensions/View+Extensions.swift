//
//  View+Extensions.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

extension View {
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat) -> Void) -> some View {
        self
            .overlay {
                GeometryReader {
                    let minX = $0.frame(in: .scrollView).minX
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self, perform: { value in
                            completion(value)
                        })
                }
            }
    }
}
