//
//  FixSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.07.2023.
//

import SwiftUI

struct FixSceneView: View {
 
    @ObservedObject
    var scene: FixScene
    
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
            ForEach(scene.sections) { sec in
                Path { path in
                    path.addLines(sec.path)
                    path.closeSubpath()
                }.fill(sec.color)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
