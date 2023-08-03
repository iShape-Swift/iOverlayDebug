//
//  TwoSegmentScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 01.08.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat


final class TwoSegmentScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Two Segment"
    
    let twoTestStore = TwoTestStore()
    var testStore: TestStore { twoTestStore }
    var subjEditors: [ContourEditor] = []
    var clipEditors: [ContourEditor] = []
    private (set) var segs: [SegmentData] = []
    
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
    
    func makeView() -> TwoSegmentSceneView {
        TwoSegmentSceneView(scene: self)
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
        segs.removeAll()
        
        defer {
            self.objectWillChange.send()
        }
        
        guard !subjEditors.isEmpty, !clipEditors.isEmpty else { return }
        
        var subjShape = BoolShape(capacity: 20)
        
        for editor in subjEditors {
            let path = editor.points.map({ $0.fixVec })
            subjShape.add(path: path)
        }
        
        var clipShape = BoolShape(capacity: 20)
        
        for editor in clipEditors {
            let path = editor.points.map({ $0.fixVec })
            clipShape.add(path: path)
        }
        
        let segments = subjShape.segments(&clipShape)

        var id = 0
        for s in segments {
            let start = matrix.screen(worldPoint: s.a.cgPoint)
            let end = matrix.screen(worldPoint: s.b.cgPoint)
            
            segs.append(
                SegmentData(
                    id: id,
                    start: start,
                    end: end,
                    fill: s.fill
                )
            )
            
            id += 1
        }
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