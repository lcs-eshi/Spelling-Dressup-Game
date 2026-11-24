//
//  HomeView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            VStack(spacing: 12) {
                Text("🐾")
                    .font(.system(size: 76))
                    .accessibilityHidden(true)

                Text("Animal Spelling")
                    .font(.largeTitle)
                    .bold()

                Text("Look at the animal, then type its name.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            HStack(spacing: 12) {
                difficultyLink(.easy, color: .green)
                difficultyLink(.hard, color: .orange)
                difficultyLink(.insane, color: .red)
            }
            .frame(maxWidth: 440)

            HStack(spacing: 16) {
                NavigationLink {
                    SettingsView()
                } label: {
                    Label("Settings", systemImage: "gearshape")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(minHeight: 52)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)

                NavigationLink {
                    ClosetView()
                } label: {
                    Label("Closet", systemImage: "tshirt")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(minHeight: 52)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .frame(maxWidth: 440)

            Spacer()
        }
        .padding(40)
            .frame(minWidth: 620, minHeight: 700)
            .background(
                LinearGradient(
                    colors: [Color.blue.opacity(0.16), Color.cyan.opacity(0.08)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .navigationTitle("Home")
    }

    // MARK: - Functions

    private func difficultyLink(_ difficulty: SpellingDifficulty, color: Color) -> some View {
        NavigationLink {
            QuizView(difficulty: difficulty)
        } label: {
            VStack(spacing: 8) {
                Image(systemName: difficultyIcon(difficulty))
                    .font(.title2)
                Text(difficulty.rawValue)
                    .font(.headline)
                    .bold()
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(minHeight: 72)
        }
        .buttonStyle(.plain)
        .background(color, in: RoundedRectangle(cornerRadius: 16))
    }

    private func difficultyIcon(_ difficulty: SpellingDifficulty) -> String {
        switch difficulty {
        case .easy:
            return "leaf.fill"
        case .hard:
            return "flame.fill"
        case .insane:
            return "bolt.fill"
        }
    }
}

