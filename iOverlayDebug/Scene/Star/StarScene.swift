//
//  StarScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 31.07.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat

final class StarScene: ObservableObject, SceneContainer {
    
    let starTestStore = StarTestStore()
    var testStore: TestStore { starTestStore }
    
    let id: Int
    let title = "Star"
    
    private (set) var starA: [CGPoint] = []
    private (set) var starB: [CGPoint] = []
    private (set) var cross: [CGPoint] = []
    
    private var matrix: Matrix = .empty
    private var timer: Timer?
    private var angle: Double = 0
    
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
    
    func makeView() -> StarSceneView {
        StarSceneView(scene: self)
    }
    
    func onAppear() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
            self?.solve()
        }
    }

    func onDisappear() {
        timer?.invalidate()
        timer = nil
    }
    
    func solve() {
        defer {
            self.objectWillChange.send()
        }

        let test = starTestStore.test
        
        let pointsA = self.generateStarPoints(
            smallRadius: test.smallRadius,
            bigRadius: test.bigRadius,
            count: test.count,
            angle: angle
        )

        let pointsB = self.generateStarPoints(
            smallRadius: test.smallRadius,
            bigRadius: test.bigRadius,
            count: test.count,
            angle: 0
        )
        
        self.starA = matrix.screen(worldPoints: pointsA)
        self.starB = matrix.screen(worldPoints: pointsB)
        
        let sA = pointsA.map({ $0.point })
        let sB = pointsB.map({ $0.point })
        
//        var original = Set<FixVec>()
        
        var overlay = Overlay()
        overlay.add(path: sA, type: .subject)
        overlay.add(path: sB, type: .clip)
        let segments = overlay.buildSegments(fillRule: .evenOdd, solver: .list)
        
        var points = Set<FixVec>()
        
        for seg in segments {
            points.insert(FixVec(seg.seg.a))
            points.insert(FixVec(seg.seg.b))
        }
        
//        points.subtract(original)
        
        cross = matrix.screen(worldPoints: points.map({ $0.cgPoint }))
        
        angle += 0.001
    }
 
    
    private func generateStarPoints(smallRadius: CGFloat, bigRadius: CGFloat, count: Int, angle: Double) -> [CGPoint] {
        let dA = Double.pi / Double(count)
        var a: Double = angle
        
        var points = [CGPoint]()
        points.reserveCapacity(2 * count)
        
        for _ in 0..<count {
            let xR = bigRadius * cos(a)
            let yR = bigRadius * sin(a)
            
            a += dA

            let xr = smallRadius * cos(a)
            let yr = smallRadius * sin(a)
            
            a += dA
            
            points.append(CGPoint(x: xR, y: yR))
            points.append(CGPoint(x: xr, y: yr))
        }
        
        return points
    }
}
