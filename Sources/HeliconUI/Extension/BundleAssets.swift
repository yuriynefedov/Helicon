//
//  File.swift
//  Helicon
//
//  Created by Yuriy Nefedov on 31.05.2025.
//

import Foundation
import SwiftUI

extension Image {
    static func package(named name: String) -> Self {
        self.init(name, bundle: .module)
    }
}

extension Color {
    static func package(named name: String) -> Self {
        self.init(name, bundle: .module)
    }
}
