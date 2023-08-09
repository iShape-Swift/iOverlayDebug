//
//  IntersectSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 08.08.2023.
//

import SwiftUI
import iDebug

struct IntersectSceneView: View {
 
    @ObservedObject
    var scene: IntersectScene
    
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
            ForEach(scene.subjEditors) { editor in
                scene.editorView(editor: editor)
            }
            ForEach(scene.clipEditors) { editor in
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
