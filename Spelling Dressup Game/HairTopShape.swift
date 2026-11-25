//
//  HairTopShape.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct HairTopShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.height * 0.78))
        path.addCurve(
            to: CGPoint(x: rect.maxX, y: rect.height * 0.78),
            control1: CGPoint(x: rect.width * 0.08, y: rect.minY),
            control2: CGPoint(x: rect.width * 0.92, y: rect.minY)
        )
        path.addLine(to: CGPoint(x: rect.width * 0.78, y: rect.height * 0.53))
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.22, y: rect.height * 0.53),
            control: CGPoint(x: rect.midX, y: rect.height * 0.72)
        )
        path.closeSubpath()
        return path
    }
}
