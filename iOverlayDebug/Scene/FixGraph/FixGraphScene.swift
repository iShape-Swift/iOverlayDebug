//
//  FixGraphScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 11.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat


final class FixGraphScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Fix Graph"
    
    let fixTestStore = FixTestStore()
    var testStore: TestStore { fixTestStore }
    let editor = ContourEditor(showIndex: false, color: .gray.opacity(0.3))
    private (set) var vectors: [Vector] = []
    
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
    
    func makeView() -> FixGraphSceneView {
        FixGraphSceneView(scene: self)
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
        vectors.removeAll()
        /*
        guard !path.isEmpty else { return }
        
        let graph = path.segGraph()
        
        var id = 0
        for i in 0..<graph.nodes.count {
            let node = graph.nodes[i]
            var j = node.offset
            let v0 = graph.verts[i]
            let p0 = matrix.screen(worldPoint: v0.cgPoint)
            while j < node.offset + node.count {
                let link = graph.links[j]
                let v1 = graph.verts[link.nodeIndex]
                let p1 = matrix.screen(worldPoint: v1.cgPoint)
                vectors.append(Vector(id: id, start: p0, end: p1, color: .red.opacity(0.5), lineWidth: 4, arrowColor: .red))
                j += 1
            }
            id += 1
        }
        */
        self.objectWillChange.send()
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}
