//
//  HairstyleView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct HairstyleView: View {
    // MARK: - Stored properties

    let style: String
    let length: String
    let isBackLayer: Bool

    // MARK: - Computed properties

    var body: some View {
        ZStack {
            if isBackLayer, length == "Long" {
                if style == "Curly" {
                    HStack(spacing: 96) {
                        curlColumn
                        curlColumn
                    }
                    .offset(y: -124)
                } else {
                    HStack(spacing: 96) {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.brown)
                            .frame(width: 28, height: 160)
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.brown)
                            .frame(width: 28, height: 160)
                    }
                    .offset(y: -90)
                }
            }

            if !isBackLayer {
                if style == "Curly" {
                    HStack(spacing: -7) {
                        Circle().fill(.brown).frame(width: 24, height: 24)
                        Circle().fill(.brown).frame(width: 24, height: 24)
                        Circle().fill(.brown).frame(width: 24, height: 24)
                        Circle().fill(.brown).frame(width: 24, height: 24)
                        Circle().fill(.brown).frame(width: 24, height: 24)
                    }
                    .offset(y: -193)
                } else {
                    HairTopShape()
                        .fill(.brown)
                        .frame(width: 112, height: 58)
                        .offset(y: -177)
                }

                if length == "Long" {
                    if style == "Curly" {
                        HStack(spacing: 70) {
                            curlColumn
                            curlColumn
                        }
                        .offset(y: -124)
                    } else {
                        HStack(spacing: 96) {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.brown)
                                .frame(width: 24, height: 160)
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.brown)
                                .frame(width: 24, height: 160)
                        }
                        .offset(y: -90)
                    }
                }
            }
        }
        .frame(width: 300, height: 500)
        .accessibilityHidden(true)
    }

    private var curlColumn: some View {
        VStack(spacing: -8) {
            Circle().fill(.brown).frame(width: 24, height: 30)
            Circle().fill(.brown).frame(width: 24, height: 30)
            Circle().fill(.brown).frame(width: 24, height: 30)
            Circle().fill(.brown).frame(width: 24, height: 30)
            Circle().fill(.brown).frame(width: 24, height: 30)
            Circle().fill(.brown).frame(width: 24, height: 30)
        }
    }
}
