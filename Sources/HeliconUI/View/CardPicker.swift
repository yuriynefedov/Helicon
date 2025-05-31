//
//  CardPicker.swift
//  Helicon
//
//  Created by Yuriy Nefedov on 22.05.2025.
//

import SwiftUI
import HeliconFoundation

public struct CardPicker<Content: View, T: Identifiable & Equatable & TitleRepresentable>: View {
    @Binding var selection: T
    
    var direction: CardPickerStackDirection = .default
    let options: [T]
    
    var spacing: CGFloat = 16
    var strokeWidth: CGFloat = 3
    var innerPadding: CGFloat = 6
    var cornerRadius: CGFloat = 20
    var applyScaleEffect: Bool = true
    var applyOpacityEffect: Bool = true
    var font: Font = .subheadline
    var fontWeight: Font.Weight = .medium
    var selectedFontWeight: Font.Weight = .medium
    var labelPadding: CGFloat = 12
    
    let content: (T) -> Content
    var onDoubleSelect: (() -> Void)? = nil
    
    var innerCornerRadiusDecrement: CGFloat { innerPadding / 2 }
    
    public var body: some View {
        picker
//            .sensoryFeedback(
//                sensoryFeedbackRequest.feedback,
//                trigger: sensoryFeedbackRequest
//            )
    }
    
    @ViewBuilder
    private var picker: some View {
        switch direction {
        case .vertical:
            VStack(spacing: spacing) {
                pickerContent
            }
        case .horizontal:
            HStack(spacing: spacing) {
                pickerContent
            }
        }
    }
    
    private var pickerContent: some View {
        ForEach(options) { option in
            view(for: option)
                .buttonWrapper {
                    withAnimation {
                        if selection == option {
                            if let onDoubleSelect {
//                                provideSensoryFeedback(.success)
                                onDoubleSelect()
                            }
                        } else {
                            selection = option
//                            provideSensoryFeedback(.selection)
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    private func view(for option: T) -> some View {
        VStack(spacing: labelPadding) {
            card(for: option)
            label(for: option)
        }
    }
    
    @ViewBuilder
    private func card(for option: T) -> some View {
        let isSelected = selection == option
        let scaleEffect: CGFloat = isSelected ? 1.025 : 0.975
        let opacityEffect: CGFloat = isSelected ? 1 : 0.75
        
        ZStack {
            content(option)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: cornerRadius - innerPadding/2
                    )
                )
                .padding(innerPadding)
                .background(
                    RoundedRectangle(
                        cornerRadius: cornerRadius
                    )
                    .stroke(
                        isSelected ? Color.accentColor : .clear,
                        lineWidth: strokeWidth
                    )
                    .padding(strokeWidth / 2)
                )
        }
        .scaleEffect(applyScaleEffect ? scaleEffect : 1)
        .opacity(applyOpacityEffect ? opacityEffect : 1)
    }
    
    @ViewBuilder
    private func label(for option: T) -> some View {
        let isSelected = selection == option
        
        Text(option.title)
            .font(font)
            .fontWeight(isSelected ? selectedFontWeight : fontWeight)
            .foregroundStyle(Color.primary)
    }
}

//extension CardPicker {
//    private func provideSensoryFeedback(_ feedback: SensoryFeedback) {
//        self.sensoryFeedbackRequest = .init(feedback)
//    }
//}

public enum CardPickerStackDirection: Sendable {
    case vertical
    case horizontal
    
    static let `default`: Self = .vertical
}

fileprivate enum Animal: String, Identifiable, Equatable, CaseIterable, TitleRepresentable {
    case dog
    case elephant
    case dinosaur
    
    var emoji: String {
        switch self {
        case .dog: "🐶"
        case .elephant: "🐘"
        case .dinosaur: "🦖"
        }
    }
    
    var title: String {
        rawValue.capitalized
    }
    
    var id: String { rawValue }
}

fileprivate struct AnimalPicker: View {
    @State private var animal: Animal = .elephant
    
    var body: some View {
        CardPicker(
            selection: $animal,
            direction: .vertical,
            options: Animal.allCases) { animal in
                ZStack {
                    Rectangle()
                        .foregroundStyle(.gray.opacity(0.1))
                    Text(animal.emoji)
                        .font(.largeTitle)
                }
                .frame(width: 100, height: 100)
            } onDoubleSelect: {
                print("Double selected \(animal)")
            }

    }
}

#Preview {
    AnimalPicker()
}
