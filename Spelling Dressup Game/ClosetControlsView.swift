//
//  ClosetControlsView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct ClosetControlsView: View {
    // MARK: - Stored properties

    @Binding var selectedHeadwear: String
    @Binding var selectedHairStyle: String
    @Binding var selectedHairLength: String
    @Binding var selectedTop: String
    @Binding var selectedBottom: String
    @Binding var selectedShoes: String
    @Binding var selectedDress: String
    @Binding var isWearingDress: Bool
    @Binding var selectedAccessories: Set<String>

    let onReset: () -> Void

    private let clothingColors = ["Blue", "Pink", "Purple", "Grey", "Black"]
    private let dressColors = ["Blue", "Pink", "Purple", "Black"]
    private let headwearOptions = ["None", "Beanie", "Cap", "Scarf", "Glasses"]
    private let hairStyles = ["Straight", "Curly"]
    private let hairLengths = ["Short", "Long"]
    private let accessories = ["Bracelet", "Necklace", "Dog", "Bear"]

    // MARK: - Computed properties

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text("Choose Clothes")
                    .font(.title2)
                    .bold()

                ClothingSelectionView(
                    title: "Shirt",
                    options: clothingColors,
                    selection: $selectedTop
                )

                VStack(alignment: .leading, spacing: 10) {
                    Text("Bottom")
                        .font(.headline)

                    Picker("Bottom style", selection: $isWearingDress) {
                        Text("Pants").tag(false)
                        Text("Dress").tag(true)
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()

                    ClothingSelectionView(
                        title: isWearingDress ? "Dress color" : "Pants color",
                        options: isWearingDress ? dressColors : clothingColors,
                        selection: isWearingDress ? $selectedDress : $selectedBottom
                    )
                }

                ClothingSelectionView(
                    title: "Shoes",
                    options: clothingColors,
                    selection: $selectedShoes
                )

                ClothingSelectionView(
                    title: "Headwear",
                    options: headwearOptions,
                    selection: $selectedHeadwear
                )

                ClothingSelectionView(
                    title: "Hairstyle",
                    options: hairStyles,
                    selection: $selectedHairStyle
                )

                ClothingSelectionView(
                    title: "Hair length",
                    options: hairLengths,
                    selection: $selectedHairLength
                )

                AccessorySelectionView(
                    title: "Accessories",
                    options: accessories,
                    selection: $selectedAccessories
                )

                Button("Reset Outfit", systemImage: "arrow.counterclockwise", action: onReset)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .frame(maxWidth: .infinity)
            }
            .padding(16)
        }
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}
