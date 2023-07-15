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
        let path = editor.points.map({ $0.fixVec })
        let cleanPath = path.removedDegenerates()
        let points = cleanPath.split()
        dots.removeAll()
        clean.removeAll()
        guard !points.isEmpty else { return }
        
        for i in 0..<points.count {
            let p = points[i]
            let screen = matrix.screen(worldPoint: p.cgPoint)
            dots.append(.init(id: i, center: screen, radius: 4, color: .red))
        }

        clean = matrix.screen(worldPoints: cleanPath.map({ $0.cgPoint }))

        self.objectWillChange.send()
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}
