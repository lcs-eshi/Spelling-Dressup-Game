//
//  SettingsView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Stored properties

    @AppStorage("spellingMode") private var spellingModeRawValue = SpellingMode.practice.rawValue

    // MARK: - Computed properties

    private var selectedMode: SpellingMode {
        SpellingMode(rawValue: spellingModeRawValue) ?? .practice
    }

    var body: some View {
        Form {
            Section("Quiz Mode") {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 12) {
                        ForEach(SpellingMode.allCases) { mode in
                            Button {
                                selectMode(mode)
                            } label: {
                                VStack(spacing: 8) {
                                    Text(mode.rawValue)
                                        .font(.headline)

                                    Image(systemName: selectedMode == mode ? "checkmark.circle.fill" : "circle")
                                        .font(.title3)
                                        .accessibilityHidden(true)
                                }
                                .frame(maxWidth: .infinity, minHeight: 76, maxHeight: 76)
                            }
                            .buttonStyle(.bordered)
                            .tint(selectedMode == mode ? .accentColor : .gray)
                            .accessibilityValue(selectedMode == mode ? "Selected" : "Not selected")
                        }
                    }

                    Text(selectedMode.description)
                        .foregroundStyle(.secondary)
                        .lineLimit(3, reservesSpace: true)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, minHeight: 72, alignment: .topLeading)
                }
            }
        }
        .padding(24)
        .frame(minWidth: 620, minHeight: 700)
        .navigationTitle("Settings")
    }

    // MARK: - Functions

    private func selectMode(_ mode: SpellingMode) {
        spellingModeRawValue = mode.rawValue
    }
}
