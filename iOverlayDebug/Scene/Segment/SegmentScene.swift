//
//  SegmentScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 11.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat


final class SegmentScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Segment"
    
    let fixTestStore = FixTestStore()
    var testStore: TestStore { fixTestStore }
    let editor = ContourEditor(showIndex: false, color: .gray.opacity(0.3))
    private (set) var segs: [SegmentData] = []
    
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
    
    func makeView() -> SegmentSceneView {
        SegmentSceneView(scene: self)
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
        segs.removeAll()
        
        defer {
            self.objectWillChange.send()
        }
        
        guard !path.isEmpty else { return }

        var boolShape = BoolShape(capacity: 20)
        boolShape.add(path: path)
        boolShape.build()
        let segments = boolShape.buildSegments()

        var id = 0
        for s in segments {
            let start = matrix.screen(worldPoint: s.a.cgPoint)
            let end = matrix.screen(worldPoint: s.b.cgPoint)
            
            segs.append(
                SegmentData(
                    id: id,
                    start: start,
                    end: end,
                    isFillTop: s.isFillTop
                )
            )
            
            id += 1
        }

    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}
