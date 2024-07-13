//
//  XorScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 09.08.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat

final class XorScene: ObservableObject, SceneContainer {

    @Published
    var rule: FillRule = .evenOdd {
        didSet {
            self.solve()
        }
    }
    
    @Published
    var solver: Solver = .auto {
        didSet {
            self.solve()
        }
    }
    
    let rules: [FillRule] = [
        .nonZero,
        .evenOdd
    ]
    
    let solvers: [Solver] = [
        .list,
        .tree,
        .auto
    ]
    
    let id: Int
    let title = "Xor"
    
    let twoTestStore = TwoTestStore()
    var testStore: TestStore { twoTestStore }
    var subjEditors: [ContourEditor] = []
    var clipEditors: [ContourEditor] = []
    private (set) var shapes: [XShape] = []
    
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
    
    func makeView() -> XorSceneView {
        XorSceneView(scene: self)
    }

    func editorView(editor: ContourEditor) -> ContourEditorView {
        editor.makeView(matrix: matrix)
    }

    func didUpdateTest() {
        let test = twoTestStore.test

        var newSubjEditors = [ContourEditor]()
        for path in test.subjPaths {
            let editor = ContourEditor(showIndex: true, color: .red.opacity(0.7), showArrows: false)
            editor.onUpdate = { [weak self] _ in
                self?.didUpdateEditor()
            }
            editor.set(points: path)
            newSubjEditors.append(editor)
        }
        
        var newClipEditors = [ContourEditor]()
        for path in test.clipPaths {
            let editor = ContourEditor(showIndex: true, color: .blue.opacity(0.7), showArrows: false)
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
        
        guard !subjEditors.isEmpty || !clipEditors.isEmpty else { return }

        var overlay = Overlay()
        
        for editor in subjEditors {
            let path = editor.points.map({ $0.point })
            overlay.add(path: path, type: .subject)
        }
        
        for editor in clipEditors {
            let path = editor.points.map({ $0.point })
            overlay.add(path: path, type: .clip)
        }
        
        let list = overlay.buildGraph(fillRule: rule, solver: solver).extractShapes(overlayRule: .xor)
        
        for i in 0..<list.count {
            let color = Color(index: i)
            let item = list[i]

            let hull = matrix.screen(worldPoints: item[0].map({ $0.cgPoint }))
            
            var holes = [[CGPoint]]()
            if item.count > 1{
                for hole in item[1..<item.count] {
                    holes.append(matrix.screen(worldPoints: hole.map({ $0.cgPoint })))
                }
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
