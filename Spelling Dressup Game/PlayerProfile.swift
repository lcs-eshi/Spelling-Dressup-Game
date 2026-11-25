//
//  PlayerProfile.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import Foundation
import Observation

@MainActor
@Observable
final class PlayerProfile {
    // MARK: - Stored properties

    private static let displayNameKey = "player.displayName"
    private static let closetAppearanceKey = "player.closetAppearance"

    @ObservationIgnored private let defaults: UserDefaults

    var displayName: String {
        didSet {
            defaults.set(displayName, forKey: Self.displayNameKey)
        }
    }

    var closetAppearance: ClosetAppearance {
        didSet {
            persistClosetAppearance()
        }
    }

    // MARK: - Initializer

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.displayName = defaults.string(forKey: Self.displayNameKey) ?? ""

        let savedAppearance = defaults.dictionary(forKey: Self.closetAppearanceKey) ?? [:]
        self.closetAppearance = ClosetAppearance(
            headwear: savedAppearance["headwear"] as? String ?? "None",
            hairStyle: savedAppearance["hairStyle"] as? String ?? "Straight",
            hairLength: savedAppearance["hairLength"] as? String ?? "Short",
            top: savedAppearance["top"] as? String ?? "Blue",
            bottom: savedAppearance["bottom"] as? String ?? "Blue",
            shoes: savedAppearance["shoes"] as? String ?? "Blue",
            dress: savedAppearance["dress"] as? String ?? "Blue",
            isWearingDress: savedAppearance["isWearingDress"] as? Bool ?? false,
            accessories: Set(savedAppearance["accessories"] as? [String] ?? [])
        )
    }

    // MARK: - Functions

    func updateDisplayName(_ name: String) {
        displayName = name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func resetClosetAppearance() {
        closetAppearance = ClosetAppearance()
    }

    private func persistClosetAppearance() {
        defaults.set(
            [
                "headwear": closetAppearance.headwear,
                "hairStyle": closetAppearance.hairStyle,
                "hairLength": closetAppearance.hairLength,
                "top": closetAppearance.top,
                "bottom": closetAppearance.bottom,
                "shoes": closetAppearance.shoes,
                "dress": closetAppearance.dress,
                "isWearingDress": closetAppearance.isWearingDress,
                "accessories": closetAppearance.accessories.sorted()
            ],
            forKey: Self.closetAppearanceKey
        )
    }
}
