//
//  TwoSplitSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.07.2023.
//

import SwiftUI
import iDebug

struct TwoSplitSceneView: View {
 
    @ObservedObject
    var scene: TwoSplitScene
    
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
            ForEach(0..<scene.cross.count, id: \.self) { id in 
                CircleView(position: scene.cross[id], radius: 5, color: .red)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
