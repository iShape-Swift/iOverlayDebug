//
//  StarSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 31.07.2023.
//

import SwiftUI
import iDebug

struct StarSceneView: View {
 
    @ObservedObject
    var scene: StarScene
    
    var body: some View {
        HStack {
            GeometryReader { proxy in
                content(size: proxy.size)
            }
        }
    }
    
    private func content(size: CGSize) -> some View {
        scene.initSize(screenSize: size)
        return ZStack {
            Color.white
            Path() { path in
                path.addLines(scene.starA)
                path.closeSubpath()
            }.stroke(style: .init(lineWidth: 3)).foregroundColor(.green)
            Path() { path in
                path.addLines(scene.starB)
                path.closeSubpath()
            }.stroke(style: .init(lineWidth: 3)).foregroundColor(.blue)
            ForEach(0..<scene.cross.count, id: \.self) { id in
                CircleView(position: scene.cross[id], radius: 5, color: .red)
            }
        }.onAppear() {
            scene.onAppear()
        }.onDisappear() {
            scene.onDisappear()
        }
    }

}
