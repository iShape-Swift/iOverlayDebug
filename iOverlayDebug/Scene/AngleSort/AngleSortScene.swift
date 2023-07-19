//
//  AngleSortScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 16.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat
import iShape


final class AngleSortScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "AngleSort"
    
    let angleSortTestStore = AngleSortTestStore()
    var testStore: TestStore { angleSortTestStore }
    let editor = PointsEditor(showIndex: false)
    private (set) var dots: [TextDot] = []
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        angleSortTestStore.onUpdate = self.didUpdateTest
        
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
    
    func makeView() -> AngleSortSceneView {
        AngleSortSceneView(scene: self)
    }

    func editorView() -> PointsEditorView {
        editor.makeView(matrix: matrix)
    }

    func didUpdateTest() {
        let test = angleSortTestStore.test
        
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
        var points = editor.points.map({ $0.fixVec })
        guard !points.isEmpty else {
            return
        }
        let start = points.removeFirst()
        guard !points.contains(where: { $0.x < start.x }) else {
            return
        }
        
        dots.append(.init(
            id: 0,
            center: matrix.screen(worldPoint: start.cgPoint),
            radius: 5,
            color: .red,
            text: "start"
        ))
        
        points.sort(start: start)
        
        var id = 1
        for p in points {
            dots.append(.init(
                id: id,
                center: matrix.screen(worldPoint: p.cgPoint),
                radius: 5,
                color: .green,
                text: "\(id)"
            ))
            id += 1
        }
        
        
        self.objectWillChange.send()
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}

private extension Array where Element == FixVec {

    mutating func sort(start: FixVec) {
        self.sort(by: {
            if $0.point.x == $1.point.x {
                return $0.point.y < $1.point.y
            } else {
                return Triangle.isClockwise(p0: start, p1: $1, p2: $0)
            }
        })
    }
}
