//
//  File.swift
//  Helicon
//
//  Created by Yuriy Nefedov on 02.06.2025.
//

import SwiftUI

struct OpacityDisabledModifier: ViewModifier {
    let isDisabled: Bool
    var effect: OpacityEffect
    
    func body(content: Content) -> some View {
        content
            .disabled(isDisabled)
            .opacity(isDisabled ? effect.rawValue : 1)
    }
}

public enum OpacityEffect: CGFloat, Sendable {
    case heavy = 0.33
    case slight = 0.66
    
    public static let `default`: Self = .heavy
}

public extension View {
    func opacityDisabled(_ isDisabled: Bool = true, _ effect: OpacityEffect = .default) -> some View {
        self.modifier(
            OpacityDisabledModifier(
                isDisabled: isDisabled,
                effect: effect
            )
        )
    }
}
