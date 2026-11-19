//
//  SettingsView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ContentUnavailableView(
            "Settings",
            systemImage: "gearshape",
            description: Text("Settings will be available soon.")
        )
        .frame(minWidth: 620, minHeight: 700)
        .navigationTitle("Settings")
    }
}
