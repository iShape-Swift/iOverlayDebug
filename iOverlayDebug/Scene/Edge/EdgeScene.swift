//
//  EdgeScene.swift
//  iShapeDebug
//
//  Created by Nail Sharipov on 10.07.2023.
//

import SwiftUI
import iDebug
import iShape
@testable import iOverlay
import iFixFloat

struct Edge: Identifiable, Hashable {
    let id: Int
    let a: CGPoint
    let b: CGPoint
    func hash(into hasher: inout Hasher) {
        hasher.combine(a.x)
        hasher.combine(a.y)
        hasher.combine(b.x)
        hasher.combine(b.y)
    }
}

final class EdgeScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "Edge"
    let edgeTestStore = EdgeTestStore()
    var testStore: TestStore { edgeTestStore }
    let editor = PointsEditor()
    
    static let colorA: Color = .orange
    static let colorB: Color = .purple

    private (set) var edgeA: Edge?
    private (set) var edgeB: Edge?
    private (set) var crossVecs: [CGPoint] = []
    private (set) var crossResult = ""
    
    private (set) var colorA: Color = EdgeScene.colorA
    private (set) var colorB: Color = EdgeScene.colorB
    
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
    
    func makeView() -> EdgeSceneView {
        EdgeSceneView(scene: self)
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
        let vecs = points.map { $0.point }
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

        let cross = ScanCrossSolver.debugCross(target: edA.xSegment, other: edB.xSegment)
        var pnts = [Point]()

        if let cross = cross {
            switch cross {
            case .pure(let p):
                crossResult = "middle cross : \(p.floatString)"
                pnts.append(p)
            case .endOverlap:
                crossResult = "end overlap"
            case .overlap:
                crossResult = "mid overlap"
            case .targetEndExact(let p):
                crossResult = "A end cross : \(p.floatString)"
                pnts.append(p)
            case .targetEndRound(let p):
                crossResult = "A end cross : \(p.floatString)"
                pnts.append(p)
            case .otherEndExact(let p):
                crossResult = "B end cross : \(p.floatString)"
                pnts.append(p)
            case .otherEndRound(let p):
                crossResult = "B end cross : \(p.floatString)"
                pnts.append(p)
            }
            colorA = EdgeScene.colorA.opacity(0.8)
            colorB = EdgeScene.colorB.opacity(0.8)
        } else {
            crossResult = "not cross or parallel"
            colorA = EdgeScene.colorA
            colorB = EdgeScene.colorB
        }
        

        crossVecs = matrix.screen(worldPoints: pnts.map({ $0.cgPoint }) )
        
    }
    
    
    func printTest() {
        let points = editor.points
        let edgeA = [points[0], points[1]]
        let edgeB = [points[2], points[3]]

        print("A: \(edgeA.prettyPrint())")
        print("B: \(edgeB.prettyPrint())")
    }
    
}

private extension Point {
    
    var floatString: String {
        let p = self.cgPoint
        let x = String(format: "%.1f", p.x)
        let y = String(format: "%.1f", p.y)
        return "(\(x), \(y))"
    }

}
