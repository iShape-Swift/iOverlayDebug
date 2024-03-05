//
//  CrossSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.02.2024.
//

import SwiftUI
import iDebug

struct CrossSceneView: View {
 
    @ObservedObject
    var scene: CrossScene
    
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
                HStack {
                    Text("Edge A").font(.title2).foregroundColor(CrossScene.colorA)
                    Text("Edge B").font(.title2).foregroundColor(CrossScene.colorB)
                    Text(scene.crossResult).font(.title2).foregroundColor(.gray)
                }
                Text(scene.crossTitle).font(.largeTitle).foregroundColor(scene.crossColor).padding(.top, 10)
                Spacer()
            }
            scene.dotsEditorView()
            
            if let edge = scene.edgeA {
                Path { path in
                    path.move(to: edge.a)
                    path.addLine(to: edge.b)
                }.stroke(style: .init(lineWidth: 4, lineCap: .round)).foregroundColor(scene.colorA)
            }
           
            if let edge = scene.edgeB {
                Path { path in
                    path.move(to: edge.a)
                    path.addLine(to: edge.b)
                }.stroke(style: .init(lineWidth: 4, lineCap: .round)).foregroundColor(scene.colorB)
            }
            ForEach(0..<scene.crossVecs.count, id: \.self) { id in
                CircleView(position: scene.crossVecs[id], radius: 6, color: .red)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
