//
//  View+ProgressBlurred.swift
//  App
//
//  Created by Yuriy Nefedov on 28.11.2024.
//

import SwiftUI

public struct ProgressBlurredViewModifier: ViewModifier {
    let isActive: Bool
    let showSpinner: Bool
    
    private var blurRadius: CGFloat {
        isActive ? 10 : 0
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: blurRadius)
            if isActive && showSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
    }
}

public extension View {
    func progressBlurred(_ isActive: Bool = true, showSpinner: Bool = true) -> some View {
        self.modifier(
            ProgressBlurredViewModifier(
                isActive: isActive,
                showSpinner: showSpinner
            )
        )
    }
}

fileprivate struct ProgressBlurredExampleView: View {
    @State private var loading = true
    
    var body: some View {
        Text("ProgressBlurred")
            .progressBlurred(loading)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                    DispatchQueue.main.async {
                        withAnimation {
                            loading.toggle()
                        }
                    }
                }
            }
    }
}

#Preview {
    ProgressBlurredExampleView()
}
