//
//  SGraphSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 11.07.2023.
//

import SwiftUI
import iDebug

struct SGraphSceneView: View {
 
    @ObservedObject
    var scene: SGraphScene
    
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
            scene.editorView()
            ForEach(scene.segs) { seg in
                GSegmentView(seg: seg)
            }
            ForEach(scene.dots) { dot in
                TextDotView(dot: dot)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
