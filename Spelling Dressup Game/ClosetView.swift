//
//  ClosetView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct ClosetView: View {
    // MARK: - Stored properties

    @Environment(PlayerProfile.self) private var profile

    // MARK: - Computed properties

    var body: some View {
        @Bindable var profile = profile

        HStack(spacing: 24) {
            HumanFigureView(appearance: profile.closetAppearance)
                .frame(maxWidth: .infinity)

            ClosetControlsView(
                selectedHeadwear: $profile.closetAppearance.headwear,
                selectedHairStyle: $profile.closetAppearance.hairStyle,
                selectedHairLength: $profile.closetAppearance.hairLength,
                selectedTop: $profile.closetAppearance.top,
                selectedBottom: $profile.closetAppearance.bottom,
                selectedShoes: $profile.closetAppearance.shoes,
                selectedDress: $profile.closetAppearance.dress,
                isWearingDress: $profile.closetAppearance.isWearingDress,
                selectedAccessories: $profile.closetAppearance.accessories,
                onReset: resetOutfit
            )
            .frame(width: 300)
        }
        .frame(minWidth: 620, minHeight: 700)
        .padding(24)
        .background(
            LinearGradient(
                colors: [Color.pink.opacity(0.12), Color.purple.opacity(0.08)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .navigationTitle("Closet")
    }

    // MARK: - Functions

    private func resetOutfit() {
        profile.resetClosetAppearance()
    }
}
