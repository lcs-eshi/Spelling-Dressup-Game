//
//  AccessorySelectionView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct AccessorySelectionView: View {
    // MARK: - Stored properties

    let title: String
    let options: [String]
    @Binding var selection: Set<String>

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 88), spacing: 8)
                ],
                spacing: 8
            ) {
                ForEach(options, id: \.self) { option in
                    let isSelected = selection.contains(option)

                    Button {
                        toggle(option)
                    } label: {
                        HStack(spacing: 6) {
                            Text(option)
                            if isSelected {
                                Image(systemName: "checkmark")
                                    .font(.caption.weight(.bold))
                                    .accessibilityHidden(true)
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .tint(isSelected ? .purple : nil)
                    .frame(minHeight: 44)
                    .accessibilityLabel("\(option)\(isSelected ? ", selected" : "")")
                }
            }
        }
    }

    // MARK: - Functions

    private func toggle(_ option: String) {
        if selection.contains(option) {
            selection.remove(option)
        } else {
            selection.insert(option)
        }
    }
}
