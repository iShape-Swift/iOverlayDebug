//
//  TwoSplitScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat

final class TwoSplitScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "TwoSplit"
    
    let twoTestStore = TwoTestStore()
    var testStore: TestStore { twoTestStore }
    var subjEditors: [ContourEditor] = []
    var clipEditors: [ContourEditor] = []
    private (set) var cross: [CGPoint] = []
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        twoTestStore.onUpdate = self.didUpdateTest
    }
    
    func initSize(screenSize: CGSize) {
        if !matrix.screenSize.isIntSame(screenSize) {
            matrix = Matrix(screenSize: screenSize, scale: 10, inverseY: true)
            DispatchQueue.main.async { [weak self] in
                self?.solve()
            }
        }
    }
    
    func makeView() -> TwoSplitSceneView {
        TwoSplitSceneView(scene: self)
    }

    func editorView(editor: ContourEditor) -> ContourEditorView {
        editor.makeView(matrix: matrix)
    }

    func didUpdateTest() {
        let test = twoTestStore.test

        var newSubjEditors = [ContourEditor]()
        for path in test.subjPaths {
            let editor = ContourEditor(showIndex: true, color: .gray.opacity(0.7), showArrows: false)
            editor.onUpdate = { [weak self] _ in
                self?.didUpdateEditor()
            }
            editor.set(points: path)
            newSubjEditors.append(editor)
        }
        
        var newClipEditors = [ContourEditor]()
        for path in test.clipPaths {
            let editor = ContourEditor(showIndex: true, color: .gray.opacity(0.7), showArrows: false)
            editor.onUpdate = { [weak self] _ in
                self?.didUpdateEditor()
            }
            editor.set(points: path)
            newClipEditors.append(editor)
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.subjEditors = newSubjEditors
            self.clipEditors = newClipEditors
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
        cross.removeAll()
        
        defer {
            self.objectWillChange.send()
        }
        
        guard !subjEditors.isEmpty, !clipEditors.isEmpty else { return }

        var original = Set<FixVec>()
        
        var subjShape = BoolShape(capacity: 20)
        
        for editor in subjEditors {
            let path = editor.points.map({ $0.fixVec })
            subjShape.add(path: path)
            original.formUnion(path)
        }
        
        var clipShape = BoolShape(capacity: 20)
        
        for editor in clipEditors {
            let path = editor.points.map({ $0.fixVec })
            clipShape.add(path: path)
            original.formUnion(path)
        }
        
        _ = subjShape.overlay(&clipShape)
        
        let clipEdges = clipShape.edges
        
        var points = Set<FixVec>()
        
        for edge in clipEdges {
            points.insert(edge.a)
            points.insert(edge.b)
        }
        
        points.subtract(original)
        
        cross = matrix.screen(worldPoints: points.map({ $0.cgPoint }))
    }
    
    func printTest() {
        print("subjEditors:")
        for editor in subjEditors {
            print("path \(editor.id): \(editor.points.prettyPrint())")
        }
        
        print("clipEditors:")
        for editor in clipEditors {
            print("path \(editor.id): \(editor.points.prettyPrint())")
        }
    }
    
}