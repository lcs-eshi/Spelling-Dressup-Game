//
//  NecklaceShape.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct NecklaceShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.25, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.75, y: rect.minY),
            control: CGPoint(x: rect.midX, y: rect.maxY * 1.3)
        )
        return path
    }
}
