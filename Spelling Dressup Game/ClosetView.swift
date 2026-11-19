//
//  ClosetView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct ClosetView: View {
    // MARK: - Stored properties

    @State private var selectedHat = "None"
    @State private var selectedTop = "None"
    @State private var selectedBottom = "None"
    @State private var selectedShoes = "None"

    private let hats = ["None", "Cap", "Top Hat", "Sun Hat"]
    private let tops = ["None", "Red", "Blue", "Yellow"]
    private let bottoms = ["None", "Blue", "Green", "Purple"]
    private let shoes = ["None", "White", "Brown", "Black"]

    // MARK: - Computed properties

    var body: some View {
        HStack(spacing: 24) {
            HumanFigureView(
                hat: selectedHat,
                top: selectedTop,
                bottom: selectedBottom,
                shoes: selectedShoes
            )
            .frame(maxWidth: .infinity)

            clothingPanel
                .frame(width: 300)
        }
        .frame(minWidth: 620, minHeight: 700)
        .padding(24)
        .background(
            LinearGradient(
                colors: [Color.pink.opacity(0.12), Color.purple.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .navigationTitle("Closet")
    }

    private var clothingPanel: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Choose Clothes")
                    .font(.title2)
                    .bold()

                ClothingSelectionView(
                    title: "Hat",
                    options: hats,
                    selection: $selectedHat
                )

                ClothingSelectionView(
                    title: "Top",
                    options: tops,
                    selection: $selectedTop
                )

                ClothingSelectionView(
                    title: "Pants",
                    options: bottoms,
                    selection: $selectedBottom
                )

                ClothingSelectionView(
                    title: "Shoes",
                    options: shoes,
                    selection: $selectedShoes
                )

                Button("Reset Outfit", systemImage: "arrow.counterclockwise", action: resetOutfit)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .frame(maxWidth: .infinity)
            }
            .padding(16)
        }
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
    }

    // MARK: - Functions

    private func resetOutfit() {
        selectedHat = "None"
        selectedTop = "None"
        selectedBottom = "None"
        selectedShoes = "None"
    }
}
