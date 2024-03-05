//
//  RandomSegmSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.02.2024.
//

import SwiftUI
import iDebug

struct RandomSegmSceneView: View {
 
    @ObservedObject
    var scene: RandomSegmScene
    
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
                Button("Print Test") {
                    scene.printTest()
                }.buttonStyle(.borderedProminent).padding()
                Button("Solve") {
                    scene.solve()
                }.buttonStyle(.borderedProminent).padding()
                Spacer()
            }
            ForEach(scene.edges, id: \.self) { edge in
                Path { path in
                    path.move(to: edge.a)
                    path.addLine(to: edge.b)
                }.stroke(style: .init(lineWidth: 1, lineCap: .round)).foregroundColor(.blue)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
