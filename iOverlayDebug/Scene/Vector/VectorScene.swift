//
//  VectorScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 30.01.2024.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat


final class VectorScene: ObservableObject, SceneContainer {

    @Published
    var rule: FillRule = .nonZero {
        didSet {
            self.solve()
        }
    }
    
    @Published
    var operation: OverlayRule = .subject {
        didSet {
            self.solve()
        }
    }
    
    
    let operations: [OverlayRule] = [
        .clip,
        .subject,
        .difference,
        .intersect,
        .union,
        .xor
    ]

    @Published
    var power: Float = 1 {
        didSet {
            let scale = pow(10.0, power)
            matrix.update(scale: scale)
            for editor in subjEditors {
                editor.matrix = matrix
            }
            for editor in clipEditors {
                editor.matrix = matrix
            }
            self.solve()
        }
    }
    
    let rules: [FillRule] = [
        .nonZero,
        .evenOdd
    ]
    
    let id: Int
    let title = "Vector"
    
    let twoTestStore = TwoTestStore()
    var testStore: TestStore { twoTestStore }
    var subjEditors: [ContourEditor] = []
    var clipEditors: [ContourEditor] = []
    private (set) var vecs: [VectorFillData] = []
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        twoTestStore.onUpdate = self.didUpdateTest
    }
    
    func initSize(screenSize: CGSize) {
        if !matrix.screenSize.isIntSame(screenSize) {
            matrix = Matrix(screenSize: screenSize, scale: pow(10.0, power), inverseY: true)
            DispatchQueue.main.async { [weak self] in
                self?.solve()
            }
        }
    }
    
    func makeView() -> VectorSceneView {
        VectorSceneView(scene: self)
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
        vecs.removeAll()
        
        defer {
            self.objectWillChange.send()
        }
        
        guard !subjEditors.isEmpty else { return }
        
        var overlay = Overlay()
        
        for editor in subjEditors {
            let path = editor.points.map({ $0.fixVec })
            overlay.add(path: path, type: .subject)
        }
        
        if !clipEditors.isEmpty {
            for editor in clipEditors {
                let path = editor.points.map({ $0.fixVec })
                overlay.add(path: path, type: .clip)
            }
        }
        
        let vecShapes = overlay.buildVectors(fillRule: rule, overlayRule: operation)

        var id = 0
        for shape in vecShapes {
            for path in shape {
                for v in path {
                    let start = matrix.screen(worldPoint: v.a.cgPoint)
                    let end = matrix.screen(worldPoint: v.b.cgPoint)
                    
                    vecs.append(
                        VectorFillData(
                            id: id,
                            start: start,
                            end: end,
                            fill: v.fill
                        )
                    )

                    id += 1
                }
            }
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
