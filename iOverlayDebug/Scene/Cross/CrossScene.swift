//
//  CrossScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.02.2024.
//

import SwiftUI
import iDebug
import iShape
import iOverlay
import iFixFloat


final class CrossScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Cross"
    let edgeTestStore = EdgeTestStore()
    var testStore: TestStore { edgeTestStore }
    let editor = PointsEditor()
    
    static let colorA: Color = .orange
    static let colorB: Color = .purple
    
    var crossColor: Color = .gray
    var crossTitle: String = ""

    private (set) var edgeA: Edge?
    private (set) var edgeB: Edge?
    private (set) var crossVecs: [CGPoint] = []
    private (set) var crossResult = ""
    
    private (set) var colorA: Color = CrossScene.colorA
    private (set) var colorB: Color = CrossScene.colorB
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        edgeTestStore.onUpdate = self.didUpdateTest
        
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
    
    func makeView() -> CrossSceneView {
        CrossSceneView(scene: self)
    }

    func dotsEditorView() -> PointsEditorView {
        editor.makeView(matrix: matrix)
    }
    
    func didUpdateTest() {
        let test = edgeTestStore.test
        
        let points = test.edgeA + test.edgeB
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.editor.set(points: points)
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
        defer {
            self.objectWillChange.send()
        }
        
        let points = editor.points
        let vecs = points.map { $0.fixVec }
        crossVecs.removeAll()
        guard !vecs.isEmpty else {
            edgeA = nil
            edgeB = nil
            crossResult = ""
            return
        }
        
        let screen = matrix.screen(worldPoints: points)
        
        edgeA = Edge(id: 0, a: screen[0], b: screen[1])
        edgeB = Edge(id: 1, a: screen[2], b: screen[3])

        let edA = ShapeEdge(a: vecs[0], b: vecs[1], count: ShapeCount(subj: 0, clip: 0))
        let edB = ShapeEdge(a: vecs[2], b: vecs[3], count: ShapeCount(subj: 0, clip: 0))
        
        let cross = edA.cross(edB)
        var pnts = [FixVec]()

        if let cross = cross {
            switch cross.type {
            case .pure:
                crossResult = "middle cross : \(cross.point.floatString)"
                pnts.append(cross.point)
            case .end_a:
                crossResult = "A end cross : \(cross.point.floatString)"
                pnts.append(cross.point)
            case .end_b:
                crossResult = "B end cross : \(cross.point.floatString)"
                pnts.append(cross.point)
            case .overlay_a:
                crossResult = "A overlay B"
            case .overlay_b:
                crossResult = "B overlay A"
            case .penetrate:
                crossResult = "penetrate A: \(cross.point.floatString) B: \(cross.second.floatString)"
                pnts.append(cross.point)
                pnts.append(cross.second)
            }
            colorA = EdgeScene.colorA.opacity(0.8)
            colorB = EdgeScene.colorB.opacity(0.8)
        } else {
            crossResult = "not cross or parallel"
            colorA = EdgeScene.colorA
            colorB = EdgeScene.colorB
        }
        

        crossVecs = matrix.screen(worldPoints: pnts.map({ $0.cgPoint }) )
        
        let crossType = CrossSolver.isCross(a0: edA.a, b0: edA.b, a1: edB.a, b1: edB.b)
        
        switch crossType {
        case .pure:
            crossTitle = "Cross"
            self.crossColor = .red
        case .overlap:
            crossTitle = "Overlap"
            self.crossColor = .purple
        case .sameEnd:
            crossTitle = "SameEnd"
            self.crossColor = .green
        case .equal:
            crossTitle = "Equal"
            self.crossColor = .purple
        case .notCross:
            crossTitle = "NotCross"
            self.crossColor = .gray.opacity(0.6)
        }
    }
    
    
    func printTest() {
        let points = editor.points
        let edgeA = [points[0], points[1]]
        let edgeB = [points[2], points[3]]

        print("A: \(edgeA.prettyPrint())")
        print("B: \(edgeB.prettyPrint())")
    }
}

private extension FixVec {
    
    var floatString: String {
        let p = self.float
        let x = String(format: "%.1f", p.x)
        let y = String(format: "%.1f", p.y)
        return "(\(x), \(y))"
    }

}
