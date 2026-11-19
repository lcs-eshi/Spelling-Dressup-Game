//
//  ClothingSelectionView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct ClothingSelectionView: View {
    let title: String
    let options: [String]
    @Binding var selection: String

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
                    Button(option) {
                        selection = option
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .tint(selection == option ? .purple : nil)
                    .frame(minHeight: 44)
                }
            }
        }
    }
}
