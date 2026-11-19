//
//  ClosetView.swift
//  Spelling Dressup Game
//

import SwiftUI

struct ClosetView: View {
    var body: some View {
        ContentUnavailableView(
            "Closet",
            systemImage: "tshirt",
            description: Text("The animal closet will be available soon.")
        )
        .frame(minWidth: 620, minHeight: 700)
        .navigationTitle("Closet")
    }
}
