//
//  HomeView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Stored properties

    @Environment(PlayerProfile.self) private var profile
    @AppStorage("spellingMode") private var spellingModeRawValue = SpellingMode.practice.rawValue
    @State private var isNameEntryPresented = false
    @State private var hasCheckedNameAtLaunch = false
    @State private var nameDraft = ""

    // MARK: - Computed properties

    private var selectedMode: SpellingMode {
        SpellingMode(rawValue: spellingModeRawValue) ?? .practice
    }

    var body: some View {
        VStack(spacing: 0) {
            homeHeader
                .frame(height: 108, alignment: .top)

            Spacer(minLength: 12)

            VStack(spacing: 28) {
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

                NavigationLink {
                    HandbookView()
                } label: {
                    Label("Open Handbook", systemImage: "book.closed")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: 440)
                        .frame(minHeight: 60)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)

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
            }

            Spacer(minLength: 12)
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
        .sheet(isPresented: $isNameEntryPresented) {
            nameEntrySheet
        }
        .onAppear(perform: checkNameAtLaunch)
    }

    private var homeHeader: some View {
        HStack(alignment: .top, spacing: 12) {
            HumanFigureView(appearance: profile.closetAppearance)
                .frame(width: 300, height: 500)
                .scaleEffect(0.18, anchor: .topLeading)
                .frame(width: 54, height: 90, alignment: .topLeading)
                .clipped()

            Spacer(minLength: 12)

            VStack(alignment: .trailing, spacing: 8) {
                if !profile.displayName.isEmpty {
                    Text("Welcome, \(profile.displayName)!")
                        .font(.headline)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(2)
                }

                Button {
                    beginNameEntry()
                } label: {
                    Label(
                        profile.displayName.isEmpty ? "Set Name" : "Change Name",
                        systemImage: "person.crop.circle"
                    )
                }
                .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var nameEntrySheet: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(profile.displayName.isEmpty ? "Welcome!" : "Change your name")
                .font(.title2)
                .bold()

            TextField("Enter a name", text: $nameDraft)
                .onSubmit(saveName)

            HStack {
                Button(profile.displayName.isEmpty ? "Not now" : "Cancel") {
                    isNameEntryPresented = false
                }
                .keyboardShortcut(.cancelAction)

                Spacer()

                Button("Save", action: saveName)
                    .buttonStyle(.borderedProminent)
                    .keyboardShortcut(.defaultAction)
                    .disabled(nameDraft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .padding(28)
        .frame(minWidth: 380, minHeight: 200)
    }

    // MARK: - Functions

    private func checkNameAtLaunch() {
        guard !hasCheckedNameAtLaunch else {
            return
        }

        hasCheckedNameAtLaunch = true
        guard profile.displayName.isEmpty else {
            return
        }

        beginNameEntry()
    }

    private func beginNameEntry() {
        nameDraft = profile.displayName
        isNameEntryPresented = true
    }

    private func saveName() {
        let trimmedName = nameDraft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            return
        }

        profile.updateDisplayName(trimmedName)
        isNameEntryPresented = false
    }

    private func difficultyLink(_ difficulty: SpellingDifficulty, color: Color) -> some View {
        NavigationLink {
            QuizView(difficulty: difficulty, mode: selectedMode)
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

