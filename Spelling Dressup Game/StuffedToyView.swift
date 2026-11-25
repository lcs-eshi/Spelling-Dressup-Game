//
//  StuffedToyView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct StuffedToyView: View {
    // MARK: - Stored properties

    let animal: String

    // MARK: - Computed properties

    var body: some View {
        let isDog = animal == "Dog"
        let toyColor: Color = isDog ? .brown : .orange
        let muzzleColor: Color = isDog ? .brown.opacity(0.7) : .yellow.opacity(0.65)

        ZStack {
            Capsule()
                .fill(toyColor)
                .frame(width: 38, height: 48)
                .offset(y: 18)

            if isDog {
                Ellipse()
                    .fill(toyColor.opacity(0.85))
                    .frame(width: 14, height: 26)
                    .rotationEffect(.degrees(-18))
                    .offset(x: -20, y: -15)

                Ellipse()
                    .fill(toyColor.opacity(0.85))
                    .frame(width: 14, height: 26)
                    .rotationEffect(.degrees(18))
                    .offset(x: 20, y: -15)
            } else {
                HStack(spacing: 22) {
                    Circle()
                        .fill(toyColor)
                        .frame(width: 18, height: 18)
                        .overlay {
                            Circle()
                                .fill(.pink.opacity(0.75))
                                .frame(width: 9, height: 9)
                        }

                    Circle()
                        .fill(toyColor)
                        .frame(width: 18, height: 18)
                        .overlay {
                            Circle()
                                .fill(.pink.opacity(0.75))
                                .frame(width: 9, height: 9)
                        }
                }
                .offset(y: -29)
            }

            Circle()
                .fill(toyColor)
                .frame(width: 38, height: 38)
                .offset(y: -14)

            HStack(spacing: 9) {
                Circle()
                    .fill(.black)
                    .frame(width: 4, height: 4)
                Circle()
                    .fill(.black)
                    .frame(width: 4, height: 4)
            }
            .offset(y: -18)

            Ellipse()
                .fill(muzzleColor)
                .frame(width: isDog ? 22 : 18, height: 14)
                .offset(y: -6)

            Circle()
                .fill(.black)
                .frame(width: 6, height: 5)
                .offset(y: -9)

            if isDog {
                Capsule()
                    .fill(.blue)
                    .frame(width: 34, height: 7)
                    .offset(y: 8)
            }
        }
        .frame(width: 52, height: 72)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Stuffed \(animal.lowercased()) toy")
    }
}
