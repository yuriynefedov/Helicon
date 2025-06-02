//
//  ShrinkingButtonStyle.swift
//
//  Created by Yuriy Nefedov on 28.10.2023.
//

import SwiftUI

public struct ShrinkingButtonStyle: ButtonStyle {
    var pressedMultiplier: CGFloat = 0.97
    private let animationDuration: CGFloat
    
    init(multiplier: CGFloat? = nil, animationDuration: CGFloat = 0.15) {
        if let multiplier {
            self.pressedMultiplier = multiplier
        }
        
        self.animationDuration = animationDuration
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedMultiplier : 1)
            .animation(.spring(duration: animationDuration,
                               bounce: 0.0,
                               blendDuration: 0.0), value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == ShrinkingButtonStyle {
    static func shrinking(
        _ multiplier: CGFloat? = nil,
        animationDuration: CGFloat = 0.15
    ) -> Self {
        ShrinkingButtonStyle(multiplier: multiplier, animationDuration: animationDuration)
    }
    
    static var shrinking: Self {
        ShrinkingButtonStyle()
    }
}
