//
//  DeviceFrame.swift
//  Helicon Widgets
//
//  Created by Yuriy Nefedov on 23.05.2025.
//

import SwiftUI

struct DeviceWrapper<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        GeometryReader { proxy in
            
            let frameAspectRatio: CGFloat = 0.483
            let inferredFrameWidth: CGFloat = min(proxy.size.width, proxy.size.height * frameAspectRatio)
            
            let inferredCornerRadius: CGFloat = inferredFrameWidth / 7
            let inferedBezzleWidth: CGFloat = inferredFrameWidth / 26
            let inferedBezzleHeight: CGFloat = inferredFrameWidth / 30
            
            ZStack {
                deviceFrame
                    .background(
                        content()
                            .clipShape(RoundedRectangle(cornerRadius: inferredCornerRadius))
                            .padding(.horizontal, inferedBezzleWidth)
                            .padding(.vertical, inferedBezzleHeight)
                    )
                    
            }
            .position(
                x: proxy.size.width / 2,
                y: proxy.size.height / 2
            )
        }
    }
    
    private var deviceFrame: some View {
        Image.package(named: "Frame.iPhone16Pro.DesertTitanium")
            .resizable()
            .scaledToFit()
    }
}

struct DeviceWrappedModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        DeviceWrapper {
            content
        }
    }
}

public extension View {
    func deviceWrapped(_ frame: DeviceFrame) -> some View {
        self.modifier(DeviceWrappedModifier())
    }
}

public enum DeviceFrame {
    case userDevice
    case iPhone16Pro
}

#Preview {
    DeviceWrapper {
        Color.blue.opacity(0.5)
    }
}
