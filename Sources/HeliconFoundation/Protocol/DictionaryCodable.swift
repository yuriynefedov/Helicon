//
//  File.swift
//  HeliconUI
//
//  Created by Yuriy Nefedov on 13.03.2025.
//

import Foundation

public protocol DictionaryEncodable {
    func encode() throws -> Any
}

public extension DictionaryEncodable where Self: Encodable {
    func encode() throws -> Any {
        let jsonData = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }
}

public protocol DictionaryDecodable {
    static func decode(_ dictionary: Any) throws -> Self
}

public extension DictionaryDecodable where Self: Decodable {
    static func decode(_ dictionary: Any) throws -> Self {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return try JSONDecoder().decode(Self.self, from: jsonData)
    }
}

public typealias DictionaryCodable = DictionaryEncodable & DictionaryDecodable

public extension Encodable {
    var dictionary: [String: Any?] {
        var dict = [String:Any?]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}
