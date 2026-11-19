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

            NavigationLink {
                QuizView()
            } label: {
                Label("Start Quiz", systemImage: "play.fill")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: 440)
                    .frame(minHeight: 64)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)

           
            .font(.headline)
            .padding(24)
            .frame(maxWidth: 440, alignment: .leading)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))

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
}

