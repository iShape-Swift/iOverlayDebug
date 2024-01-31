//
//  VectorSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 30.01.2024.
//

import SwiftUI
import iDebug

struct VectorSceneView: View {
 
    @ObservedObject
    var scene: VectorScene
    
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
                Picker("FillRule", selection: $scene.rule) {
                    ForEach(scene.rules, id: \.self) {
                        Text($0.title).foregroundColor(.black)
                    }
                }.frame(maxWidth: 300)
                Picker("Operation", selection: $scene.operation) {
                    ForEach(scene.operations, id: \.self) {
                        Text($0.title).foregroundColor(.black)
                    }
                }.frame(maxWidth: 300)
                Slider(
                    value: $scene.power,
                    in: 0.1...5
                ).frame(maxWidth: 300)
                Spacer()
            }
            ForEach(scene.subjEditors) { editor in
                scene.editorView(editor: editor)
            }
            ForEach(scene.clipEditors) { editor in
                scene.editorView(editor: editor)
            }
            ForEach(scene.vecs) { vec in
                VectorFillView(vec: vec)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
