//
//  File.swift
//  Helicon
//
//  Created by Yuriy Nefedov on 13.06.2025.
//

import Foundation
import SwiftUI


/// A collection of recommended padding values.
public enum Padding {
    // Horizontal screen margins
    case horizontalScreenMargin   // iPhone (compact width)
    
    fileprivate var value: CGFloat {
        switch self {
        case .horizontalScreenMargin: 16
        }
    }
}

public extension View {
    func padding(_ edges: Edge.Set, _ padding: Padding) -> some View {
        self.padding(edges, padding.value)
    }
    
    func padding(_ padding: Padding) -> some View {
        self.padding(.all, padding.value)
    }
    
    func standardScreenMargin() -> some View {
        self.padding(.horizontal, .horizontalScreenMargin)
    }
}
