//
//  HumanFigureView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct HumanFigureView: View {
    // MARK: - Stored properties

    let hat: String
    let top: String
    let bottom: String
    let shoes: String

    // MARK: - Computed properties

    private var topColor: Color {
        switch top {
        case "Red":
            return .red
        case "Blue":
            return .blue
        case "Yellow":
            return .yellow
        default:
            return .clear
        }
    }

    private var bottomColor: Color {
        switch bottom {
        case "Blue":
            return .blue
        case "Green":
            return .green
        case "Purple":
            return .purple
        default:
            return .clear
        }
    }

    private var shoeColor: Color {
        switch shoes {
        case "White":
            return .white
        case "Brown":
            return .brown
        case "Black":
            return .black
        default:
            return .clear
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(.regularMaterial)

            ZStack {
                if hat != "None" {
                    hatView
                        .offset(y: -205)
                }

                Circle()
                    .fill(Color(red: 0.91, green: 0.72, blue: 0.58))
                    .frame(width: 92, height: 92)
                    .offset(y: -145)

                Circle()
                    .fill(.brown)
                    .frame(width: 96, height: 48)
                    .offset(y: -177)

                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.91, green: 0.72, blue: 0.58))
                    .frame(width: 34, height: 32)
                    .offset(y: -82)

                Capsule()
                    .fill(Color(red: 0.91, green: 0.72, blue: 0.58))
                    .frame(width: 32, height: 150)
                    .offset(x: -88, y: -14)
                    .rotationEffect(.degrees(8))

                Capsule()
                    .fill(Color(red: 0.91, green: 0.72, blue: 0.58))
                    .frame(width: 32, height: 150)
                    .offset(x: 88, y: -14)
                    .rotationEffect(.degrees(-8))

                if top != "None" {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(topColor)
                        .frame(width: 150, height: 112)
                        .offset(y: -20)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(topColor)
                        .frame(width: 46, height: 145)
                        .offset(x: -88, y: -14)
                        .rotationEffect(.degrees(8))

                    RoundedRectangle(cornerRadius: 10)
                        .fill(topColor)
                        .frame(width: 46, height: 145)
                        .offset(x: 88, y: -14)
                        .rotationEffect(.degrees(-8))
                }

                if bottom != "None" {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(bottomColor)
                        .frame(width: 148, height: 135)
                        .offset(y: 86)

                    RoundedRectangle(cornerRadius: 8)
                        .fill(bottomColor)
                        .frame(width: 64, height: 150)
                        .offset(x: -38, y: 150)

                    RoundedRectangle(cornerRadius: 8)
                        .fill(bottomColor)
                        .frame(width: 64, height: 150)
                        .offset(x: 38, y: 150)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.91, green: 0.72, blue: 0.58))
                        .frame(width: 54, height: 150)
                        .offset(x: -38, y: 150)

                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.91, green: 0.72, blue: 0.58))
                        .frame(width: 54, height: 150)
                        .offset(x: 38, y: 150)
                }

                if shoes != "None" {
                    Capsule()
                        .fill(shoeColor)
                        .frame(width: 78, height: 38)
                        .offset(x: -38, y: 230)

                    Capsule()
                        .fill(shoeColor)
                        .frame(width: 78, height: 38)
                        .offset(x: 38, y: 230)
                }
            }
            .frame(width: 300, height: 500)
        }
        .frame(maxWidth: 420, maxHeight: 590)
        .accessibilityLabel(outfitDescription)
    }

    private var hatView: some View {
        ZStack {
            switch hat {
            case "Cap":
                Ellipse()
                    .fill(.blue)
                    .frame(width: 110, height: 58)
                Capsule()
                    .fill(.blue)
                    .frame(width: 130, height: 24)
                    .offset(x: 25, y: 18)
            case "Top Hat":
                RoundedRectangle(cornerRadius: 6)
                    .fill(.black)
                    .frame(width: 72, height: 90)
                Ellipse()
                    .fill(.black)
                    .frame(width: 130, height: 28)
                    .offset(y: 38)
            case "Sun Hat":
                Ellipse()
                    .fill(.yellow)
                    .frame(width: 150, height: 42)
                Capsule()
                    .fill(.yellow)
                    .frame(width: 74, height: 68)
                    .offset(y: -18)
            default:
                EmptyView()
            }
        }
    }

    private var outfitDescription: String {
        "Human figure wearing \(selectedDescription(hat, category: "hat")), \(selectedDescription(top, category: "shirt")), \(selectedDescription(bottom, category: "pants")), and \(selectedDescription(shoes, category: "shoes"))."
    }

    private func selectedDescription(_ option: String, category: String) -> String {
        if option == "None" {
            return "no \(category)"
        }
        return "\(option) \(category)"
    }
}
