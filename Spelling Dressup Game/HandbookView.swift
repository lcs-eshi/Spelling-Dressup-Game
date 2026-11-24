//
//  HandbookView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct HandbookView: View {
    // MARK: - Stored properties

    @State private var selectedDifficulty: SpellingDifficulty = .easy
    @Environment(\.dismiss) private var dismiss

    // MARK: - Computed properties

    private let columns = [
        GridItem(.flexible(), spacing: 18),
        GridItem(.flexible(), spacing: 18)
    ]

    // MARK: - Functions

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Animal Handbook")
                        .font(.largeTitle)
                        .bold()

                    Text("Review the 15 animals in each spelling level.")
                        .foregroundStyle(.secondary)
                }

                Picker("Difficulty", selection: $selectedDifficulty) {
                    Text("Easy").tag(SpellingDifficulty.easy)
                    Text("Hard").tag(SpellingDifficulty.hard)
                    Text("Insane").tag(SpellingDifficulty.insane)
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 520)

                HStack(spacing: 10) {
                    Circle()
                        .fill(levelColor)
                        .frame(width: 12, height: 12)

                    Text("\(selectedDifficulty.rawValue) Level")
                        .font(.title2)
                        .bold()
                }

                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(selectedDifficulty.animals) { animal in
                        handbookCard(animal)
                    }
                }
            }
            .padding(34)
        }
        .frame(minWidth: 620, minHeight: 700)
        .background(levelColor.opacity(0.08))
        .navigationTitle("Handbook")
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button("Exit to Home", systemImage: "house", action: dismiss)
            }
        }
    }

    private var levelColor: Color {
        switch selectedDifficulty {
        case .easy:
            return .green
        case .hard:
            return .orange
        case .insane:
            return .red
        }
    }

    private func handbookCard(_ animal: Animal) -> some View {
        VStack(spacing: 12) {
            Image(animal.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            Text(animal.name)
                .font(.title3)
                .bold()
                .textCase(.lowercase)
        }
        .padding(12)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    NavigationStack {
        HandbookView()
    }
}
