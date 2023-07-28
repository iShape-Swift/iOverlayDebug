//
//  ComplexScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat

final class ComplexScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Complex"
    
    let complexTestStore = ComplexTestStore()
    var testStore: TestStore { complexTestStore }
    var editors: [ContourEditor] = []
    var shapes: [XShape] = []
    
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        complexTestStore.onUpdate = self.didUpdateTest
    }
    
    func initSize(screenSize: CGSize) {
        if !matrix.screenSize.isIntSame(screenSize) {
            matrix = Matrix(screenSize: screenSize, scale: 10, inverseY: true)
            DispatchQueue.main.async { [weak self] in
                self?.solve()
            }
        }
    }
    
    func makeView() -> ComplexSceneView {
        ComplexSceneView(scene: self)
    }

    func editorView(editor: ContourEditor) -> ContourEditorView {
        editor.makeView(matrix: matrix)
    }

    func didUpdateTest() {
        let test = complexTestStore.test

        var newEditors = [ContourEditor]()
        for path in test.paths {
            let editor = ContourEditor(showIndex: true, color: .gray.opacity(0.7), showArrows: false)
            editor.onUpdate = { [weak self] _ in
                self?.didUpdateEditor()
            }
            editor.set(points: path)
            newEditors.append(editor)
        }
        
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.editors = newEditors
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
        
        guard !editors.isEmpty else { return }
        
        var boolShape = BoolShape(capacity: 20)
        
        for editor in editors {
            let path = editor.points.map({ $0.fixVec })
            boolShape.add(path: path)
        }
        
        let list = boolShape.shapes()

        for i in 0..<list.count {
            let color = Color(index: i)
            let item = list[i]
            var paths = [[CGPoint]]()
            
            paths.append(matrix.screen(worldPoints: item.contour.map({ $0.cgPoint })))
            
            for hole in item.holes {
                paths.append(matrix.screen(worldPoints: hole.map({ $0.cgPoint })))
            }

            shapes.append(XShape(id: i, paths: paths, color: color))
        }
    }
    
    func printTest() {
        for editor in editors {
            print("path \(editor.id): \(editor.points.prettyPrint())")
            print("")
        }
    }
    
}
