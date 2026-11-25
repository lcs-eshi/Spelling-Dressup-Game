//
//  ContentView.swift
//  Spelling Dressup Game
//
//  Created by Yicheng Shi on 2026-11-11.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Stored properties

    @State private var profile = PlayerProfile()

    var body: some View {
        NavigationStack {
            HomeView()
        }
        .environment(profile)
    }
}

#Preview {
    ContentView()
}
