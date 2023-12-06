//
//  ScanBeamScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 03.12.2023.
//

import SwiftUI
import iDebug


final class ScanBeamScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "ScanBeamScene"
    
    let scanBeamSceneTestStore = ScanBeamSceneTestStore()
    var testStore: TestStore { scanBeamSceneTestStore }
    let editor = PointsEditor(showIndex: true)

    private (set) var vector: Vector?
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        scanBeamSceneTestStore.onUpdate = self.didUpdateTest
        
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
    
    func makeView() -> ScanBeamSceneView {
        ScanBeamSceneView(scene: self)
    }

    func editorView() -> PointsEditorView {
        editor.makeView(matrix: matrix)
    }

    func didUpdateTest() {
        let test = scanBeamSceneTestStore.test
        
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
        vector = nil
        
        defer {
            self.objectWillChange.send()
        }
        
        let points = editor.points.map({ $0.fixVec })
        guard !points.isEmpty else {
            return
        }

        let pts = matrix.screen(worldPoints: points.map({ $0.cgPoint }))
        
        vector = Vector(id: 0, start: pts[0], end: pts[1], color: .black, lineWidth: 5, arrowColor: .black)
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
}
