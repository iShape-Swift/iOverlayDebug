//
//  ComplexSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.07.2023.
//

import SwiftUI

struct ComplexSceneView: View {
 
    @ObservedObject
    var scene: ComplexScene
    
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
            ForEach(scene.editors) { editor in
                scene.editorView(editor: editor)
            }
            ForEach(scene.shapes) { shape in
                XShapeView(shape: shape)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
