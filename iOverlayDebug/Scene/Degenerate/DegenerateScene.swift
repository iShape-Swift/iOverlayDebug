//
//  DegenerateScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat

final class DegenerateScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Degenerate"
    
    let degTestStore = DegenerateTestStore()
    var testStore: TestStore { degTestStore }
    let editor = ContourEditor(showIndex: true)
    private (set) var verts: [DVert] = []
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        degTestStore.onUpdate = self.didUpdateTest
        
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
    
    func makeView() -> DegenerateSceneView {
        DegenerateSceneView(scene: self)
    }

    func editorView() -> ContourEditorView {
        editor.makeView(matrix: matrix)
    }

    func didUpdateTest() {
        let test = degTestStore.test
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // TODO validate convex
            self.editor.set(points: test.path)
            self.solve()
        }
    }
    
    func didUpdateEditor() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // TODO validate convex
            self.solve()
        }
    }
    
    func onAppear() {
        didUpdateTest()
    }

    func solve() {
        let path = editor.points.map({ $0.fixVec })
        let clean = path.removedDegenerates()
        debugPrint("clean: \(clean)")
        let points = matrix.screen(worldPoints: clean.map({ $0.cgPoint }))

        var i = 0
        verts.removeAll()
        while i < points.count {
            verts.append(.init(id: i, title: "", pos: points[i], color: .red))
            i += 1
        }

        self.objectWillChange.send()
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}
