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
    let editor = ContourEditor(showIndex: false, color: .gray.opacity(0.2))
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
        let path = editor.points.map({ $0.point })
        segs.removeAll()
        
        defer {
            self.objectWillChange.send()
        }
        
        guard !path.isEmpty else { return }

        var overlay = Overlay()
        overlay.add(path: path, type: .subject)
        let (segments, fills) = overlay.buildSegments(fillRule: .evenOdd, solver: .list)

        for i in 0..<segments.count {
            let s = segments[i]
            let f = fills[i]
            let start = matrix.screen(worldPoint: FixVec(s.xSegment.a).cgPoint)
            let end = matrix.screen(worldPoint: FixVec(s.xSegment.b).cgPoint)
            
            segs.append(
                SegmentData(
                    id: id,
                    start: start,
                    end: end,
                    fill: f
                )
            )
        }

    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}
