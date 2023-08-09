//
//  FixScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 25.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat

final class FixScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Fix"
    
    let fixTestStore = FixTestStore()
    var testStore: TestStore { fixTestStore }
    let editor = ContourEditor(showIndex: true, color: .gray.opacity(0.7))
    var shapes: [XShape] = []
    
    
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
    
    func makeView() -> FixSceneView {
        FixSceneView(scene: self)
    }

    func editorView() -> ContourEditorView {
        editor.makeView(matrix: matrix)
    }

    func didUpdateTest() {
        let test = fixTestStore.test
        
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
        
        shapes.removeAll()
        
        defer {
            self.objectWillChange.send()
        }
        
        guard !editor.points.isEmpty else { return }
        
        let path = editor.points.map({ $0.fixVec })

        var overlay = Overlay()
        overlay.add(path: path, type: .subject)

        let list = overlay.buildGraph().shapes(type: .subject)

        for i in 0..<list.count {
            let color = Color(index: i)
            let item = list[i]
            let hull = matrix.screen(worldPoints: item.contour.map({ $0.cgPoint }))
            
            var holes = [[CGPoint]]()
            for hole in item.holes {
                holes.append(matrix.screen(worldPoints: hole.map({ $0.cgPoint })))
            }

            shapes.append(
                XShape(
                    id: i,
                    hull: hull,
                    holes: holes,
                    color: color,
                    fillColor: color.opacity(0.5)
                )
            )
        }
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}
