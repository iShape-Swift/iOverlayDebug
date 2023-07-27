//
//  AngleClockWiseSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 26.07.2023.
//

import SwiftUI
import iDebug

struct AngleClockWiseSceneView: View {
 
    @ObservedObject
    var scene: AngleClockWiseScene
    
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
                Toggle(isOn: $scene.isClockWise) {
                    Text("Is ClockWise").foregroundColor(.gray)
                }
                .toggleStyle(.checkbox)
                Spacer()
            }
            scene.editorView()
            ForEach(scene.vectors) { vector in
                VectorView(vector: vector)
            }
            ForEach(scene.dots) { dot in
                TextDotView(dot: dot)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
