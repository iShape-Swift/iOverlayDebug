//
//  SplitSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 13.07.2023.
//

import SwiftUI
import iDebug

struct SplitSceneView: View {
 
    @ObservedObject
    var scene: SplitScene
    
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
            VStack {
                Button("Print Test") {
                    scene.printTest()
                }.buttonStyle(.borderedProminent).padding()
                Button("Solve") {
                    scene.solve()
                }.buttonStyle(.borderedProminent).padding()
                Spacer()
            }
            Path() { path in
                path.addLines(scene.clean)
                path.closeSubpath()
            }.stroke(style: .init(lineWidth: 4, lineJoin: .round)).foregroundColor(.yellow.opacity(0.7))
            scene.editorView()
            ForEach(scene.dots) { dot in
                TextDotView(dot: dot)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
