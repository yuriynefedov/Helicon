//
//  File.swift
//  Helicon
//
//  Created by Yuriy Nefedov on 13.03.2025.
//

import SwiftUI
import HeliconFoundation

public struct PlainPicker<T: Identifiable & Hashable & TitleRepresentable>: View {
    var title: Title?
    var stretchToFill: Bool
    let options: [T]
    @Binding var selection: T
    
    init(title: Title? = nil, stretchToFill: Bool = true, options: [T], selection: Binding<T>) {
        self.title = title
        self.stretchToFill = stretchToFill
        self.options = options
        self._selection = selection
    }
    
    init(title: String, stretchToFill: Bool = true, options: [T], selection: Binding<T>) {
        self.title = .prominent(title)
        self.stretchToFill = stretchToFill
        self.options = options
        self._selection = selection
    }
    
    public var body: some View {
        Picker("", selection: $selection) {
            ForEach(options) { option in
                Text(option.title)
                    .tag(option)
            }
        }
        .labeledRow(
            isActive: title != nil,
            labelWeight: title?.fontWeight ?? .regular,
            stretchToFill: stretchToFill,
            title?.stringValue ?? ""
        )
    }
    
    enum Title {
        case plain(String)
        case prominent(String)
        
        var fontWeight: Font.Weight {
            switch self {
            case .plain: .regular
            case .prominent: .semibold
            }
        }
        
        var stringValue: String {
            switch self {
            case .plain(let string): string
            case .prominent(let string): string
            }
        }
    }
}

