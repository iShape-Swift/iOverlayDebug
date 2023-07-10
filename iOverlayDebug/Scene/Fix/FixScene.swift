//
//  FixScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat

struct FixSection: Identifiable {
    
    let id: Int
    let color: Color
    let path: [CGPoint]
}

final class FixScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Fix"
    
    let fixTestStore = FixTestStore()
    var testStore: TestStore { fixTestStore }
    let editor = ContourEditor(showIndex: true)
    private (set) var sections: [FixSection] = []
    
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
        let path = editor.points.map({ $0.fixVec })
        let paths = path.fix()

        var secList = [FixSection]()
        var i = 0
        while i < paths.count {
            let points = matrix.screen(worldPoints: paths[i].map({ $0.cgPoint }))
            let section = FixSection(id: i, color: .init(index: i), path: points)
            secList.append(section)
            i += 1
        }

        sections = secList
        
        self.objectWillChange.send()
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}
