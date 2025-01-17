//
//  [SlideCarouselCard]+Extensions.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

extension [SlideCarouselCard] {
    func indexOf(_ card: SlideCarouselCard) -> Int {
        return self.firstIndex(of: card) ?? 0
    }
}
