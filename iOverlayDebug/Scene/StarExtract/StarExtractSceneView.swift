//
//  StarExtractSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.08.2023.
//

import SwiftUI
import iDebug

struct StarExtractSceneView: View {
 
    @ObservedObject
    var scene: StarExtractScene
    
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
                Picker("Operation", selection: $scene.operation) {
                    ForEach(scene.operations, id: \.self) {
                        Text($0.title).foregroundColor(.black)
                    }
                }
                Slider(
                    value: $scene.angle,
                    in: -Double.pi...Double.pi
                )
                Spacer()
            }
            
            ForEach(scene.shapes) { shape in
                XShapeView(shape: shape)
            }
        }.onAppear() {
            scene.onAppear()
        }.onDisappear() {
            scene.onDisappear()
        }
    }

}
