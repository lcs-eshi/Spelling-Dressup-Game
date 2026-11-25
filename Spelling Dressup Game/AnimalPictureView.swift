//
//  AnimalPictureView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI
import AppKit

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

            if let photo = NSImage(named: animal.imageName) {
                Image(nsImage: photo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 520, maxHeight: 280)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .accessibilityLabel(animal.name)
            } else {
                Label(animal.name, systemImage: "photo")
                    .font(.title)
                    .frame(maxWidth: 520, minHeight: 280)
                    .background(.white.opacity(0.7), in: RoundedRectangle(cornerRadius: 24))
                    .accessibilityLabel("Photo unavailable for \(animal.name)")
            }

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
