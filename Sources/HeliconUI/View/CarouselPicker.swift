//
//  SwiftUIView.swift
//  Helicon
//
//  Created by Artem Kedrov on 26.05.2025.
//

import SwiftUI

public typealias CarouselItem = Hashable & Identifiable

public struct CarouselPicker<Content: View, Item: CarouselItem>: View {
    @Binding var items: [Item]
    @Binding var selection: Item
    
    var configuration: Configuration
    
    @ViewBuilder let content: (Item) -> Content
    
    @State private var contentSize: CGSize = .zero
    @State private var scrollPosition: Item.ID?
    
    public var body: some View {
        Color.clear
            .readSize { size in
                contentSize = size
            }
            .overlay {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: configuration.spacing) {
                            ForEach(items) { item in
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: max(contentSize.width - (configuration.contentInset.left + configuration.contentInset.right), 0), height: max(contentSize.height, 0))
                                    .overlay(
                                        content(item)
                                            .id(item.id)
                                    )
                                    .scrollTransition { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1 : configuration.opacityEffect)
                                            .scaleEffect(y: phase.isIdentity ? 1 : configuration.scaleEffect)
                                    }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .contentMargins(.leading, configuration.contentInset.left, for: .scrollContent)
                    .contentMargins(.trailing, configuration.contentInset.right, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $scrollPosition)
                    .onChange(of: scrollPosition) { _, newValue in
                        if let id = newValue, let foundItem = items.first(where: { $0.id == id }) {
                            selection = foundItem
                        }
                    }
                    .onAppear {
                        withAnimation(.easeInOut) {
                            proxy.scrollTo(selection.id, anchor: .center)
                        }
                    }
                }
            }
    }
    
    public struct Configuration {
        var opacityEffect: CGFloat = 1.0
        var scaleEffect: CGFloat = .zero
        
        var spacing: CGFloat = .zero
        var contentInset: UIEdgeInsets = .zero
    }
}


fileprivate struct CarouselTestView: View {
    @State var items: [Mock] = Mock.list
    @State var selectedItem: Mock = Mock.list[0]
    var body: some View {
        CarouselPicker(items: $items,
                     selectedItem: $selectedItem,
                     configuration: .init(
                        opacityEffect: 0.3,
                        scaleEffect: 0.7,
                        spacing: .zero,
                        contentInset: .init(top: .zero, left: 62.0, bottom: .zero, right: 62.0)
                     )) { item in
                         Text("Item \(item.value)")
                             .frame(width: 250, height: 250)
                             .background(Color.purple)
                             .clipShape(RoundedRectangle(cornerRadius: 16.0))
                     }
    }
    
    struct Mock: Identifiable, Hashable {
        var id: Int { value }
        var value: Int
        static let list: [Self] = [.init(value: 0), .init(value: 1), .init(value: 2), .init(value: 3), .init(value: 4), .init(value: 5)]
    }
}

fileprivate struct SizePreferenceKey: @preconcurrency PreferenceKey {
    @MainActor static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


fileprivate extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        overlay(
            GeometryReader { proxy in
                Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}


#Preview {
    CarouselTestView()
}
