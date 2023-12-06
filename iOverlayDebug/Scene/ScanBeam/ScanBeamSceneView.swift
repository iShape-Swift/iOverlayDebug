//
//  ScanBeamSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 03.12.2023.
//

import SwiftUI
import iDebug

struct ScanBeamSceneView: View {
 
    @ObservedObject
    var scene: ScanBeamScene
    
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
                Button("Solve") {
                    scene.solve()
                }.buttonStyle(.borderedProminent).padding()
                .toggleStyle(.checkbox)
                Spacer()
            }
            scene.editorView()
            if let vector = scene.vector {
                VectorView(vector: vector)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
