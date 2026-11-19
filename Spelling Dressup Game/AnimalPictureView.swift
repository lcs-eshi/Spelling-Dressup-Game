//
//  AnimalPictureView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct AnimalPictureView: View {
    let animal: Animal
    let questionNumber: Int
    let totalQuestions: Int

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Label("Animal Spelling", systemImage: "sparkles")
                    .font(.title2)
                    .bold()

                Spacer()

                Text("\(questionNumber) of \(totalQuestions)")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(animal.emoji)
                .font(.system(size: 150))
                .accessibilityLabel(animal.name)

            Text("What animal is this?")
                .font(.title)
                .bold()

            Spacer()
        }
        .padding(.horizontal, 34)
        .padding(.vertical, 24)
        .background(
            LinearGradient(
                colors: [Color.blue.opacity(0.18), Color.cyan.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
