//
//  SwiftUIView.swift
//  Helicon
//
//  Created by Artem Kedrov on 26.05.2025.
//

import SwiftUI

public typealias CarouselItem = Hashable & Identifiable

public struct CarouselPicker<Content: View, Option: CarouselItem>: View {
    @Binding var selection: Option
    var options: [Option]
    
    var configuration: Configuration
    
    @ViewBuilder let content: (Option) -> Content
    
    @State private var contentSize: CGSize = .zero
    @State private var scrollPosition: Option.ID?
    @State private var itemSize: CGSize = .zero
    public init(selection: Binding<Option>, options: [Option], configuration: Configuration, content: @escaping (Option) -> Content) {
        self.options = options
        self._selection = selection
        self.configuration = configuration
        self.content = content
        self.contentSize = contentSize
        self.scrollPosition = scrollPosition
    }
    
    public var body: some View {
        Color.clear
            .readSize { size in
                contentSize = size
            }
            .overlay {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: contentSize.width / 2 - itemSize.width / 2 - configuration.contentInset) {
                            ForEach(options) { item in
                                content(item)
                                    .readSize { size in
                                        itemSize = size
                                    }
                                    .scrollTransition { content, phase in
                                        content.opacity(phase.isIdentity ? 1.0: configuration.opacityEffect)
                                    }
                            }
                        }
                        .scrollTargetLayout()
                        .scrollIndicators(.never)
                    }
                    .contentMargins(.leading, contentSize.width / 2 - (itemSize.width / 2), for: .scrollContent)
                    .contentMargins(.trailing, contentSize.width / 2 - (itemSize.width / 2), for: .scrollContent)
                }
                .scrollTargetBehavior(.viewAligned)
            }
    }
    
    public struct Configuration : Sendable {
        var opacityEffect: CGFloat
        var contentInset: CGFloat
        
        public init(
            opacityEffect: CGFloat = 1.0,
            contentInset: CGFloat = .zero
        ) {
            self.opacityEffect = opacityEffect
            self.contentInset = contentInset
        }
        
        static var `default`: Self {
            .init(opacityEffect: 0.7, contentInset: 8.0)
        }
    }
}


fileprivate struct CarouselTestView: View {
    @State var options: [Mock] = Mock.list
    @State var selectedItem: Mock = Mock.list[0]
    var body: some View {
        ZStack {
            CarouselPicker(
                selection: $selectedItem,
                options: options,
                configuration: .default
            ) { item in
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(Color.purple)
                    .frame(width: 250.0, height: 250.0)
                    .overlay {
                        Text("WWW")
                    }
            }
            Rectangle()
                .fill(Color.black)
                .frame(width: 1)
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
