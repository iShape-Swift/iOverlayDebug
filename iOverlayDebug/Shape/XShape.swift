//
//  XShape.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 25.07.2023.
//

import SwiftUI

struct XShape: Identifiable {
    let id: Int
    let paths: [[CGPoint]]
    let color: Color
}


struct XShapeView: View {
    
    let shape: XShape
    
    var body: some View {
        Path() { path in
            for points in shape.paths {
                path.addLines(points)
                path.closeSubpath()
            }
        }.stroke(style: StrokeStyle(lineWidth: 4, lineJoin: .round)).foregroundColor(shape.color)
    }
}
