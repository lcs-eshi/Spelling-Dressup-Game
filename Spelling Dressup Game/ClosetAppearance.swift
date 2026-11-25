//
//  ClosetAppearance.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import Foundation

struct ClosetAppearance {
    // MARK: - Stored properties

    var headwear: String
    var hairStyle: String
    var hairLength: String
    var top: String
    var bottom: String
    var shoes: String
    var dress: String
    var isWearingDress: Bool
    var accessories: Set<String>

    // MARK: - Initializer

    init(
        headwear: String = "None",
        hairStyle: String = "Straight",
        hairLength: String = "Short",
        top: String = "Blue",
        bottom: String = "Blue",
        shoes: String = "Blue",
        dress: String = "Blue",
        isWearingDress: Bool = false,
        accessories: Set<String> = []
    ) {
        self.headwear = headwear
        self.hairStyle = hairStyle
        self.hairLength = hairLength
        self.top = top
        self.bottom = bottom
        self.shoes = shoes
        self.dress = dress
        self.isWearingDress = isWearingDress
        self.accessories = accessories
    }
}
