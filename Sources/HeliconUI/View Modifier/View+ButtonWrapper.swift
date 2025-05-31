//
//  View+ButtonWrapper.swift
//  Helicon Widgets
//
//  Created by Yuriy Nefedov on 22.01.2025.
//

import SwiftUI

struct ButtonWrapperModifier: ViewModifier {
    
    var action: (() -> Void)
    
    func body(content: Content) -> some View {
        Button(action: action) {
            content
        }
    }
}

public extension View {
    
    func buttonWrapper(action: @escaping (() -> Void)) -> some View {
        self.modifier(ButtonWrapperModifier(action: action))
    }
}
