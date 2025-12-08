//
//  DeviceFrame.swift
//  Helicon Widgets
//
//  Created by Yuriy Nefedov on 23.05.2025.
//

import SwiftUI

struct DeviceWrapper<Content: View>: View {
    
    let frame: DeviceFrame
    let content: () -> Content
    
    init(_ frame: DeviceFrame, content: @escaping () -> Content) {
        self.frame = frame
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            
            let frameAspectRatio: CGFloat = frame.frameAspectRatio
            let inferredFrameWidth: CGFloat = min(proxy.size.width, proxy.size.height * frameAspectRatio)
            
            let inferredCornerRadius: CGFloat = inferredFrameWidth * frame.cornerRadiusToFrameWidthRatio
            let inferedBezzleWidth: CGFloat = inferredFrameWidth * frame.bezzleWidthToFrameWidthRatio
            let inferedBezzleHeight: CGFloat = inferredFrameWidth * frame.bezzleHeightToFrameWidthRatio
            
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
        Image.package(named: frame.imageName)
            .resizable()
            .scaledToFit()
            .allowsHitTesting(false)
    }
}

struct DeviceWrappedModifier: ViewModifier {
    
    let frame: DeviceFrame
    
    func body(content: Content) -> some View {
        DeviceWrapper(frame) {
            content
        }
    }
}

public extension View {
    func deviceWrapped(_ frame: DeviceFrame = .iPhone16Pro) -> some View {
        self.modifier(DeviceWrappedModifier(frame: frame))
    }
}

public enum DeviceFrame : Sendable {
    case iPhone16Pro
    case appleWatchUltra
        
    var imageName: String {
        switch self {
        case .iPhone16Pro: "Frame.iPhone16Pro.DesertTitanium"
        case .appleWatchUltra: "Frame.AppleWatchUltra.YellowBeigeTrailLoop"
        }
    }
    
    var frameAspectRatio: CGFloat {
        switch self {
        case .iPhone16Pro: 0.483
        case .appleWatchUltra: 0.483
        }
    }
    
    var cornerRadiusToFrameWidthRatio: CGFloat {
        switch self {
        case .iPhone16Pro: 1/7
        case .appleWatchUltra: 1/7
        }
    }
    
    var bezzleWidthToFrameWidthRatio: CGFloat {
        switch self {
        case .iPhone16Pro: 1/26
        case .appleWatchUltra: 1/6.2
        }
    }
    
    var bezzleHeightToFrameWidthRatio: CGFloat {
        switch self {
        case .iPhone16Pro: 1/30
        case .appleWatchUltra: 1/2.8
        }
    }
}

#Preview {
    Color.blue.opacity(0.5)
        .deviceWrapped(.appleWatchUltra)
        .padding(0)
}
