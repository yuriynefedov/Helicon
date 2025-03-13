//
//  File.swift
//  Helicon
//
//  Created by Yuriy Nefedov on 13.03.2025.
//

import SwiftUI

public struct LabeledRowViewModifier: ViewModifier {
    var isActive: Bool
    var fontWeight: Font.Weight
    var stretchToFill: Bool
    let label: String
    
    public func body(content: Content) -> some View {
        if isActive {
            HStack {
                Text(label)
                    .fontWeight(fontWeight)
                if stretchToFill {
                    Spacer()
                }
                content
            }
        } else {
            content
        }
    }
}

public extension View {
    func labeledRow(
        isActive: Bool = true,
        labelWeight: Font.Weight = .semibold,
        stretchToFill: Bool = true,
        _ label: String
    ) -> some View {
        self.modifier(
            LabeledRowViewModifier(
                isActive: isActive,
                fontWeight: labelWeight,
                stretchToFill: stretchToFill,
                label: label
            )
        )
    }
}
