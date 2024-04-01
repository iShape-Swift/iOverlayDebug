//
//  RandomSegmScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.02.2024.
//

import SwiftUI
import iDebug
import iShape
import iOverlay
import iFixFloat


final class RandomSegmScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "RandomSegm"
    
    let edgeTestStore = EdgeTestStore()
    var testStore: TestStore { edgeTestStore }

    private (set) var edges: [Edge] = []

    private (set) var colorA: Color = .orange
    private (set) var colorB: Color = .purple
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
    }
    
    func initSize(screenSize: CGSize) {
        if !matrix.screenSize.isIntSame(screenSize) {
            matrix = Matrix(screenSize: screenSize, scale: 10, inverseY: true)
            DispatchQueue.main.async { [weak self] in
                self?.solve()
            }
        }
    }
    
    func makeView() -> RandomSegmSceneView {
        RandomSegmSceneView(scene: self)
    }
    
    
    func onAppear() {
        solve()
    }

    func solve() {
        defer {
            self.objectWillChange.send()
        }
        edges.removeAll()
        
        let length: Int32 = 20
        let reandEdges = TestCrossSolver.randomSegments(range: 0..<2 * length, length: 4..<8, count: 100)
        
        for id in 0..<reandEdges.count {
            let e = reandEdges[id]
            
            let a = matrix.screen(worldPoint: CGPoint(x: CGFloat(e.a.x - length), y: CGFloat(e.a.y - length)))
            let b = matrix.screen(worldPoint: CGPoint(x: CGFloat(e.b.x - length), y: CGFloat(e.b.y - length)))
            
            edges.append(.init(id: id, a: a, b: b))
        }
    }
    
    
    func printTest() {

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
