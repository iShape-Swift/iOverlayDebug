//
//  SpiralSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 24.08.2024.
//

import SwiftUI
import iDebug


private struct SpiralShape: Shape {
    var points: [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        if let p = points.first {
            path.move(to: p)
            for point in points.dropFirst() {
                path.addLine(to: point)
            }
            path.closeSubpath()
        }
        
        return path
    }
}


struct SpiralSceneView: View {
 
    @ObservedObject
    var scene: SpiralScene
    
    var body: some View {
        return HStack {
            GeometryReader { proxy in
                content(size: proxy.size)
            }
        }
    }
    
    private func content(size: CGSize) -> some View {
        scene.initSize(screenSize: size)
        return ZStack {
            Color.white
            VStack {
                Slider(
                    value: $scene.radius,
                    in: 10...1000
                )
                Slider(
                    value: $scene.count,
                    in: 10...500
                )
                Spacer()
            }
            SpiralShape(points: scene.spiralShape)
                .fill(Color.red).opacity(0.6)
                .padding()
            SpiralShape(points: scene.rawShape)
                .stroke(Color.blue, lineWidth: 2)
                .padding()
        }.onAppear() {
            scene.onAppear()
        }
    }

}
