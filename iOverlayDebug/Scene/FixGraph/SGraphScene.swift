//
//  SGraphScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 11.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat


final class SGraphScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "SGraph"
    
    let fixTestStore = FixTestStore()
    var testStore: TestStore { fixTestStore }
    let editor = ContourEditor(showIndex: false, color: .gray.opacity(0.3))
    private (set) var dots: [TextDot] = []
    private (set) var segs: [GSegment] = []
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        fixTestStore.onUpdate = self.didUpdateTest
        
        editor.onUpdate = { [weak self] _ in
            self?.didUpdateEditor()
        }
    }
    
    func initSize(screenSize: CGSize) {
        if !matrix.screenSize.isIntSame(screenSize) {
            matrix = Matrix(screenSize: screenSize, scale: 10, inverseY: true)
            DispatchQueue.main.async { [weak self] in
                self?.solve()
            }
        }
    }
    
    func makeView() -> SGraphSceneView {
        SGraphSceneView(scene: self)
    }

    func editorView() -> ContourEditorView {
        editor.makeView(matrix: matrix)
    }

    func didUpdateTest() {
        let test = fixTestStore.test
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.editor.set(points: test.path)
            self.solve()
        }
    }
    
    func didUpdateEditor() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.solve()
        }
    }
    
    func onAppear() {
        didUpdateTest()
    }

    func solve() {
        let path = editor.points.map({ $0.fixVec })
        dots.removeAll()
        segs.removeAll()
        
        defer {
            self.objectWillChange.send()
        }
        
        /*
        
        guard !path.isEmpty else { return }
        guard let gr = path.graph() else { return }
        
        var id = 0
        for v in gr.verts {
            let center = matrix.screen(worldPoint: v.cgPoint)
            
            dots.append(TextDot(
                id: id,
                center: center,
                radius: 5,
                color: .orange,
                textColor: .black,
                font: .body.bold(),
                text: "\(id)"
            ))
            
            id += 1
        }
        
        var i0 = 0
        for di in gr.dirIndex {
            if di.count > 0 {
                let p0 = matrix.screen(worldPoint: gr.verts[i0].cgPoint)
                for i in di.index..<di.index + di.count {
                    let dir = gr.dir[i]
                    let p1 = matrix.screen(worldPoint: gr.verts[dir.vIndex].cgPoint)
                    
                    let a: CGPoint
                    let b: CGPoint
                    
                    if dir.count > 0 {
                        a = p0
                        b = p1
                    } else {
                        a = p1
                        b = p0
                    }
                    
                    segs.append(
                        .init(
                            id: dir.linkId,
                            start: a,
                            end: b,
                            leftColor: .red,
                            rightColor: .blue,
                            depth: 4,
                            title: "\(dir.linkId) (\(dir.count))")
                    )
                }
            }
            
            i0 += 1
        }
        */
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}
