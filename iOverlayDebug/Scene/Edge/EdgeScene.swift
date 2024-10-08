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
    private (set) var crossColor: Color = .gray
    private (set) var connected = ""
    private (set) var connectedColor: Color = .gray
    
    private (set) var colorA: Color = EdgeScene.colorA
    private (set) var colorB: Color = EdgeScene.colorB
    
    private var matrix: iDebug.Matrix = .empty
    
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

        let edA = Segment(xSegment: XSegment(a: vecs[0], b: vecs[1]), count: ShapeCount(subj: 0, clip: 0))
        let edB = Segment(xSegment: XSegment(a: vecs[2], b: vecs[3]), count: ShapeCount(subj: 0, clip: 0))

        let s = edA.xSegment.factor(other: edB.xSegment)

        crossColor = edA.xSegment.isCross(other: edB.xSegment) ? .red : .gray
        
        
        let cross = CrossSolver.cross(target: edA.xSegment, other: edB.xSegment, radius: 2)
        var pnts = [Point]()

        if let cross = cross {
            switch cross.type {
            case .pure:
                crossResult = "middle(round: \(cross.isRound)): \(cross.point.floatString) s: \(s)"
                pnts.append(cross.point)
            case .targetEnd:
                crossResult = "A end cross (round: \(cross.isRound)): \(cross.point.floatString) s: \(s)"
                pnts.append(cross.point)
            case .otherEnd:
                crossResult = "B end cross (round: \(cross.isRound)): \(cross.point.floatString) s: \(s)"
                pnts.append(cross.point)
            case .overlap:
                let overlap = CrossSolver.overlay(target: edA.xSegment, other: edB.xSegment)
                crossResult = "target: (a: \(overlap.isTargetA), b: \(overlap.isTargetB)), other: (a: \(overlap.isOtherA), b: \(overlap.isOtherB)) s: \(s)"
                
                if overlap.isTargetA {
                    pnts.append(edA.xSegment.a)
                }
                
                if overlap.isTargetB {
                    pnts.append(edA.xSegment.b)
                }
                
                if overlap.isOtherA {
                    pnts.append(edB.xSegment.a)
                }
                
                if overlap.isOtherB {
                    pnts.append(edB.xSegment.b)
                }
            }
            colorA = EdgeScene.colorA.opacity(0.8)
            colorB = EdgeScene.colorB.opacity(0.8)
        } else {
            crossResult = "not cross s: \(s)"
            colorA = EdgeScene.colorA
            colorB = EdgeScene.colorB
        }

        crossVecs = matrix.screen(worldPoints: pnts.map({ $0.cgPoint }) )
        
        
        if edA.xSegment.isConnected(other: edB.xSegment) {
            self.connected = "True"
            self.connectedColor = .green
        } else {
            self.connected = "False"
            self.connectedColor = .gray
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

private extension Point {
    
    var floatString: String {
        let p = self.cgPoint
        let x = String(format: "%.1f", p.x)
        let y = String(format: "%.1f", p.y)
        return "(\(x), \(y))"
    }

}

private extension XSegment {
    
    func factor(other: XSegment) -> Int64 {
        guard IntRect(xSegment: self).isIntersectBorderInclude(IntRect(xSegment: other)) else {
            return 100
        }
        
        let a0b0a1 = Triangle.clockDirection(p0: self.a, p1: self.b, p2: other.a)
        let a0b0b1 = Triangle.clockDirection(p0: self.a, p1: self.b, p2: other.b)

        let a1b1a0 = Triangle.clockDirection(p0: other.a, p1: other.b, p2: self.a)
        let a1b1b0 = Triangle.clockDirection(p0: other.a, p1: other.b, p2: self.b)

        print("\(a0b0a1), \(a0b0b1), \(a1b1a0), \(a1b1b0)")
        
        let s = (1 & (a0b0a1 + 1)) + (1 & (a0b0b1 + 1)) + (1 & (a1b1a0 + 1)) + (1 & (a1b1b0 + 1))
        
        return s
    }
    
    func isCross(other: XSegment) -> Bool {
        guard IntRect(xSegment: self).isIntersectBorderInclude(IntRect(xSegment: other)) else {
            return false
        }
        
        let a0b0a1 = Triangle.clockDirection(p0: self.a, p1: self.b, p2: other.a)
        let a0b0b1 = Triangle.clockDirection(p0: self.a, p1: self.b, p2: other.b)

        let a1b1a0 = Triangle.clockDirection(p0: other.a, p1: other.b, p2: self.a)
        let a1b1b0 = Triangle.clockDirection(p0: other.a, p1: other.b, p2: self.b)

        let isCross = a0b0a1 != a0b0b1 && a1b1a0 != a1b1b0

        let s = (1 & (a0b0a1 + 1)) + (1 & (a0b0b1 + 1)) + (1 & (a1b1a0 + 1)) + (1 & (a1b1b0 + 1))
        
        return isCross && s != 2 || s == 4
    }
    
    func isConnected(other: XSegment) -> Bool {
        guard IntRect(xSegment: self).isIntersectBorderInclude(IntRect(xSegment: other)) else {
            return false
        }
        
        let a0b0a1 = Triangle.clockDirection(p0: self.a, p1: self.b, p2: other.a)
        let a0b0b1 = Triangle.clockDirection(p0: self.a, p1: self.b, p2: other.b)

        let a1b1a0 = Triangle.clockDirection(p0: other.a, p1: other.b, p2: self.a)
        let a1b1b0 = Triangle.clockDirection(p0: other.a, p1: other.b, p2: self.b)

        let isCollinear = (a0b0a1 | a0b0b1 | a1b1a0 | a1b1b0) == 0
        
        let isCross = a0b0a1 != a0b0b1 && a1b1a0 != a1b1b0 || isCollinear

        return isCross
    }
}

private extension IntRect {
    
    init(xSegment: XSegment) {
        let minX = xSegment.a.x
        let maxX = xSegment.b.x

        let minY: Int32
        let maxY: Int32
        
        if xSegment.a.y < xSegment.b.y {
            minY = xSegment.a.y
            maxY = xSegment.b.y
        } else {
            minY = xSegment.b.y
            maxY = xSegment.a.y
        }
        self.init(minX: minX, maxX: maxX, minY: minY, maxY: maxY)
    }
    
}
