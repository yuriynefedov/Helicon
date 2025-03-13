//
//  File.swift
//  HeliconUI
//
//  Created by Yuriy Nefedov on 13.03.2025.
//

import Foundation

public protocol ClassNameRepresentable {
    static var className: String { get }
}

public extension ClassNameRepresentable {
    static var className: String {
        String(describing: self)
    }
}
