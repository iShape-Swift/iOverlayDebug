//
//  XShape.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 25.07.2023.
//

import SwiftUI

struct XShape: Identifiable {
    let id: Int
    let hull: [CGPoint]
    let holes: [[CGPoint]]
    let color: Color
    let holeColor: Color
    let fillColor: Color?
    
    init(id: Int, hull: [CGPoint], holes: [[CGPoint]], color: Color, holeColor: Color = .white, fillColor: Color? = nil) {
        self.id = id
        self.hull = hull
        self.holes = holes
        self.color = color
        self.holeColor = holeColor
        self.fillColor = fillColor
    }
}


struct XShapeView: View {
    
    let shape: XShape
    
    var body: some View {
        ZStack {
            if let color = shape.fillColor {
                Path() { path in
                    path.addLines(shape.hull)
                    path.closeSubpath()

                    for hole in shape.holes {
                        path.addLines(hole)
                        path.closeSubpath()
                    }
                }.fill(color, style: .init(eoFill: true))
            }
            Path() { path in
                path.addLines(shape.hull)
                path.closeSubpath()

                for hole in shape.holes {
                    path.addLines(hole)
                    path.closeSubpath()
                }
            }.stroke(style: StrokeStyle(lineWidth: 4, lineJoin: .round)).foregroundColor(shape.color)
        }
    }
}
