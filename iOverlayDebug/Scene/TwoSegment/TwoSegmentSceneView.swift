//
//  TwoSegmentSceneView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 01.08.2023.
//
import SwiftUI
import iDebug

struct TwoSegmentSceneView: View {
 
    @ObservedObject
    var scene: TwoSegmentScene
    
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
                Button("Print JS") {
                    scene.printJS()
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
            ForEach(scene.segs) { seg in
                SegmentView(seg: seg)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
