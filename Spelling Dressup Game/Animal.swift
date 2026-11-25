//
//  Animal.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import Foundation

struct Animal: Identifiable {
    // MARK: - Stored properties

    let id: String
    let name: String
    let imageName: String
    let funFact: String
    let factSourceURL: String
    let imageCredit: String?
    let imageSourceURL: String?
    let imageLicense: String?
    let imageLicenseURL: String?

    // MARK: - Initializer

    init(
        id: String,
        name: String,
        imageName: String,
        funFact: String,
        factSourceURL: String,
        imageCredit: String? = nil,
        imageSourceURL: String? = nil,
        imageLicense: String? = nil,
        imageLicenseURL: String? = nil
    ) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.funFact = funFact
        self.factSourceURL = factSourceURL
        self.imageCredit = imageCredit
        self.imageSourceURL = imageSourceURL
        self.imageLicense = imageLicense
        self.imageLicenseURL = imageLicenseURL
    }
}
