//
//  File.swift
//  Helicon
//
//  Created by Yuriy Nefedov on 13.06.2025.
//

import SwiftUI

// MARK: - Spacing (8-pt grid)

/// A collection of recommended spacing values.
public enum Spacing {

    /// Base unit that matches Apple’s “system spacing” (8 pt).
    private static let base: CGFloat = 8

    /// Any multiple of the base unit. Example: `Spacing.system(3) == 24`.
    public static func system(_ multiplier: Int = 1) -> Self {
        .custom(CGFloat(multiplier) * base)
    }

    case small
    case medium
    case large
    case extraLarge
    
    /// Minimum gap between tappable controls.
    case controlsMinimum
    
    case custom(CGFloat)
    
    fileprivate var value: CGFloat {
        switch self {
        case .small: Self.base
        case .medium: Self.base * 2
        case .large: Self.base * 3
        case .extraLarge: Self.base * 4
        case .controlsMinimum: Self.base * 1.5
        case .custom(let cgFloat): cgFloat
        }
    }
    
}

public extension VStack {
    init(alignment: HorizontalAlignment = .center, spacing: Spacing?, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing?.value, content: content)
    }
}

public extension HStack {
    init(alignment: VerticalAlignment = .center, spacing: Spacing?, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing?.value, content: content)
    }
}
