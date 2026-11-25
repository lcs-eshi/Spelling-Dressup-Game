//
//  DressShape.swift
//  Spelling Dressup Game
//  Developed with GitHub Copilot assistance.
//

import SwiftUI

struct DressShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width * 0.3, y: 0))
        path.addLine(to: CGPoint(x: rect.width * 0.7, y: 0))
        path.addLine(to: CGPoint(x: rect.width * 0.78, y: rect.height * 0.45))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width * 0.22, y: rect.height * 0.45))
        path.closeSubpath()
        return path
    }
}
