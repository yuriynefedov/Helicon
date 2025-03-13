//
//  File.swift
//  HeliconUI
//
//  Created by Yuriy Nefedov on 13.03.2025.
//

import Foundation

public protocol StandardStringConvertible: Encodable, CustomStringConvertible, ClassNameRepresentable {}

public extension StandardStringConvertible {
    var description: String {
        let className = Self.className
        let properties = self.dictionary.map { "\($0.key): \($0.value ?? "nil")" }.joined(separator: ", ")
        return "\(className)(\(properties))"
    }
}
