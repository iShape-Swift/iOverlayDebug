//
//  SplitScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 13.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat


final class SplitScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Split"
    
    let fixTestStore = FixTestStore()
    var testStore: TestStore { fixTestStore }
    let editor = ContourEditor(showIndex: false, color: .gray.opacity(0.3))
    private (set) var clean: [CGPoint] = []
    private (set) var dots: [TextDot] = []
    
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
    
    func makeView() -> SplitSceneView {
        SplitSceneView(scene: self)
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
        dots.removeAll()
        clean.removeAll()

        defer {
            self.objectWillChange.send()
        }
        
        guard !editor.points.isEmpty else { return }
        
        let path = editor.points.map({ $0.fixVec })
        
        var overlay = Overlay()
        overlay.add(path: path, type: .subject)

        let segments = overlay.buildSegments(fillRule: .evenOdd)
        
        var set = Set<FixVec>()
        for seg in segments {
            set.insert(FixVec(seg.seg.a))
            set.insert(FixVec(seg.seg.b))
        }

        let points = Array(set)

        for i in 0..<points.count {
            let p = points[i]
            let screen = matrix.screen(worldPoint: p.cgPoint)
            dots.append(.init(id: i, center: screen, radius: 2.4, color: .red))
        }

        for seg in segments {
            let a = matrix.screen(worldPoint: FixVec(seg.seg.a).cgPoint)
            let b = matrix.screen(worldPoint: FixVec(seg.seg.b).cgPoint)
            clean.append(a)
            clean.append(b)
        }
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}
