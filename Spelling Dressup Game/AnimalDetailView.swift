//
//  AnimalDetailView.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct AnimalDetailView: View {
    // MARK: - Stored properties

    let animal: Animal

    @Environment(\.dismiss) private var dismiss

    // MARK: - Computed properties

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Button("Close", systemImage: "xmark") {
                    dismiss()
                }
            }

            HStack(spacing: 18) {
                VStack(alignment: .leading, spacing: 6) {
                    Image(animal.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210, height: 170)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .accessibilityLabel(animal.name)

                    if let imageCredit = animal.imageCredit {
                        if let sourceURLString = animal.imageSourceURL,
                           let sourceURL = URL(string: sourceURLString) {
                            Link("Image credit: \(imageCredit)", destination: sourceURL)
                                .font(.caption)
                                .fixedSize(horizontal: false, vertical: true)
                        } else {
                            Text("Image credit: \(imageCredit)")
                                .font(.caption)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        if let imageLicense = animal.imageLicense,
                           let licenseURLString = animal.imageLicenseURL,
                           let licenseURL = URL(string: licenseURLString) {
                            Link(imageLicense, destination: licenseURL)
                                .font(.caption)
                        }
                    }
                }
                .frame(width: 210, alignment: .leading)

                Text(animal.name)
                    .font(.largeTitle)
                    .bold()
                    .textCase(.lowercase)
            }

            VStack(alignment: .leading, spacing: 10) {
                Label("Fun fact", systemImage: "sparkles")
                    .font(.title2)
                    .bold()

                Text(animal.funFact)
                    .font(.title3)
                    .fixedSize(horizontal: false, vertical: true)
            }

            if let sourceURL = URL(string: animal.factSourceURL) {
                Link("Source: Encyclopaedia Britannica", destination: sourceURL)
                    .font(.footnote)
            } else {
                Label("Fact source is unavailable.", systemImage: "exclamationmark.triangle")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)
        }
        .padding(28)
        .frame(minWidth: 520, minHeight: 450)
    }
}
