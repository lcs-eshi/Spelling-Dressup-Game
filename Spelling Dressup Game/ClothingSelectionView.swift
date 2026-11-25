//
//  ClothingSelectionView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct ClothingSelectionView: View {
    // MARK: - Stored properties

    let title: String
    let options: [String]
    @Binding var selection: String

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 72), spacing: 8)
                ],
                spacing: 8
            ) {
                ForEach(options, id: \.self) { option in
                    Button {
                        selection = option
                    } label: {
                        HStack(spacing: 6) {
                            if let color = swatchColor(for: option) {
                                Circle()
                                    .fill(color)
                                    .frame(width: 14, height: 14)
                                    .overlay {
                                        Circle()
                                            .strokeBorder(.primary.opacity(0.25), lineWidth: 1)
                                    }
                                    .accessibilityHidden(true)
                            }

                            Text(option)

                            if selection == option {
                                Image(systemName: "checkmark")
                                    .font(.caption.weight(.bold))
                                    .accessibilityHidden(true)
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .tint(selection == option ? .purple : nil)
                    .frame(minHeight: 44)
                    .accessibilityLabel("\(option)\(selection == option ? ", selected" : "")")
                }
            }
        }
    }

    // MARK: - Functions

    private func swatchColor(for option: String) -> Color? {
        switch option {
        case "Blue":
            return .blue
        case "Pink":
            return .pink
        case "Purple":
            return .purple
        case "Grey":
            return .gray
        case "Black":
            return .black
        default:
            return nil
        }
    }
}
