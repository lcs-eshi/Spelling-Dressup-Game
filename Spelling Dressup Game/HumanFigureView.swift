//
//  HumanFigureView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct HumanFigureView: View {
    // MARK: - Stored properties

    let headwear: String
    let hairStyle: String
    let hairLength: String
    let top: String
    let bottom: String
    let shoes: String
    let dress: String
    let isWearingDress: Bool
    let accessories: Set<String>

    private let skinColor = Color(red: 0.91, green: 0.72, blue: 0.58)

    // MARK: - Initializer

    init(appearance: ClosetAppearance) {
        self.headwear = appearance.headwear
        self.hairStyle = appearance.hairStyle
        self.hairLength = appearance.hairLength
        self.top = appearance.top
        self.bottom = appearance.bottom
        self.shoes = appearance.shoes
        self.dress = appearance.dress
        self.isWearingDress = appearance.isWearingDress
        self.accessories = appearance.accessories
    }

    // MARK: - Computed properties

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(.regularMaterial)

            ZStack {
                HairstyleView(style: hairStyle, length: hairLength, isBackLayer: true)
                head
                neck
                arms
                clothing
                HairstyleView(style: hairStyle, length: hairLength, isBackLayer: false)
                accessoryDetails
                shoesView
                headwearView
            }
            .frame(width: 300, height: 500)
        }
        .frame(maxWidth: 420, maxHeight: 590)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(outfitDescription)
    }

    private var head: some View {
        ZStack {
            Circle()
                .fill(skinColor)
                .frame(width: 92, height: 92)

            if headwear == "Glasses" {
                HStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 4)
                        .frame(width: 28, height: 20)
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 4)
                        .frame(width: 28, height: 20)
                }
                .offset(y: 2)
            }
        }
        .offset(y: -145)
    }

    private var neck: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(skinColor)
            .frame(width: 34, height: 22)
            .offset(y: -87)
    }

    private var arms: some View {
        ZStack {
            Capsule()
                .fill(skinColor)
                .frame(width: 32, height: 150)
                .offset(x: -88, y: -14)
                .rotationEffect(.degrees(8))

            Capsule()
                .fill(skinColor)
                .frame(width: 32, height: 150)
                .offset(x: 88, y: -14)
                .rotationEffect(.degrees(-8))
        }
    }

    @ViewBuilder
    private var clothing: some View {
        if isWearingDress {
            DressShape()
                .fill(color(for: dress))
                .frame(width: 178, height: 240)
                .offset(y: 62)

            HStack(spacing: 22) {
                Capsule()
                    .fill(skinColor)
                    .frame(width: 25, height: 55)
                Capsule()
                    .fill(skinColor)
                    .frame(width: 25, height: 55)
            }
            .offset(y: 194)
        } else {
            shirt
            pants
        }
    }

    private var shirt: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(color(for: top))
                .frame(width: 150, height: 112)
                .offset(y: -20)

            RoundedRectangle(cornerRadius: 10)
                .fill(color(for: top))
                .frame(width: 46, height: 145)
                .offset(x: -88, y: -14)
                .rotationEffect(.degrees(8))

            RoundedRectangle(cornerRadius: 10)
                .fill(color(for: top))
                .frame(width: 46, height: 145)
                .offset(x: 88, y: -14)
                .rotationEffect(.degrees(-8))
        }
    }

    @ViewBuilder
    private var pants: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(color(for: bottom))
            .frame(width: 148, height: 135)
            .offset(y: 86)

        RoundedRectangle(cornerRadius: 8)
            .fill(color(for: bottom))
            .frame(width: 64, height: 150)
            .offset(x: -38, y: 150)

        RoundedRectangle(cornerRadius: 8)
            .fill(color(for: bottom))
            .frame(width: 64, height: 150)
            .offset(x: 38, y: 150)
    }

    private var shoesView: some View {
        HStack(spacing: 19) {
            Capsule()
                .fill(color(for: shoes))
                .frame(width: 58.5, height: 28.5)

            Capsule()
                .fill(color(for: shoes))
                .frame(width: 58.5, height: 28.5)
        }
        .offset(y: 230)
    }

    @ViewBuilder
    private var headwearView: some View {
        switch headwear {
        case "Beanie":
            ZStack {
                Capsule()
                    .fill(.purple)
                    .frame(width: 98, height: 40)
                Circle()
                    .fill(.purple)
                    .frame(width: 18, height: 18)
                    .offset(y: -23)
            }
            .offset(y: -200)
        case "Cap":
            ZStack {
                Ellipse()
                    .fill(.blue)
                    .frame(width: 110, height: 58)
                Capsule()
                    .fill(.blue)
                    .frame(width: 130, height: 24)
                    .offset(x: 25, y: 18)
            }
            .offset(y: -205)
        case "Scarf":
            ZStack {
                Capsule()
                    .fill(.pink)
                    .frame(width: 106, height: 26)
                RoundedRectangle(cornerRadius: 8)
                    .fill(.pink)
                    .frame(width: 24, height: 68)
                    .offset(x: 30, y: 34)
            }
            .offset(y: -78)
        default:
            EmptyView()
        }
    }

    @ViewBuilder
    private var accessoryDetails: some View {
        if accessories.contains("Necklace") {
            NecklaceShape()
                .stroke(.yellow, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .frame(width: 54, height: 36)
                .offset(y: -61)

            RoundedRectangle(cornerRadius: 8)
                .fill(skinColor)
                .frame(width: 34, height: 32)
                .offset(y: -82)
        }

        if accessories.contains("Bracelet") {
            HStack(spacing: 144) {
                Capsule()
                    .fill(.yellow)
                    .frame(width: 32, height: 10)
                Capsule()
                    .fill(.yellow)
                    .frame(width: 32, height: 10)
            }
            .offset(y: 50)
        }

        if accessories.contains("Dog") {
            StuffedToyView(animal: "Dog")
                .offset(x: -127, y: 74)
        }

        if accessories.contains("Bear") {
            StuffedToyView(animal: "Bear")
                .offset(x: 127, y: 74)
        }
    }

    private var outfitDescription: String {
        let lowerGarment = isWearingDress ? "\(dress) dress" : "\(bottom) pants"
        var description = "Figure with \(hairLength.lowercased()) \(hairStyle.lowercased()) hair, wearing a \(top) shirt, \(lowerGarment), and \(shoes) shoes."

        if headwear != "None" {
            description += " Headwear: \(headwear)."
        }

        if !accessories.isEmpty {
            description += " Accessories: \(accessories.sorted().joined(separator: ", "))."
        }

        return description
    }

    // MARK: - Functions

    private func color(for name: String) -> Color {
        switch name {
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
            return .blue
        }
    }
}
