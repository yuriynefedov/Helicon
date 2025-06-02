//
//  File.swift
//  Helicon
//
//  Created by Yuriy Nefedov on 02.06.2025.
//

import SwiftUI

struct GrayscaleDisabledModifier: ViewModifier {
    let isDisabled: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(isDisabled)
            .grayscale(isDisabled ? 1 : 0)
    }
}

public extension View {
    func grayscaleDisabled(_ isDisabled: Bool = true) -> some View {
        self.modifier(
            GrayscaleDisabledModifier(
                isDisabled: isDisabled
            )
        )
    }
}
