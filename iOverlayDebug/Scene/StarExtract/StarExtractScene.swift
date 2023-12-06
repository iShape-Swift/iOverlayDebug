//
//  StarExtractScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.08.2023.
//

import SwiftUI
import iDebug
import iOverlay
import iFixFloat

final class StarExtractScene: ObservableObject, SceneContainer {
    
    let starTestStore = StarTestStore()
    var testStore: TestStore { starTestStore }
    
    let id: Int
    let title = "Star Extract"
    
    private (set) var shapes: [XShape] = []
    
    @Published
    var operation: OverlayRule = .union
    
    let operations: [OverlayRule] = [
        .clip,
        .subject,
        .difference,
        .intersect,
        .union,
        .xor
    ]
    
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
    
    func makeView() -> StarExtractSceneView {
        StarExtractSceneView(scene: self)
    }
    
    func onAppear() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
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
        
        let scale: CGFloat = 50_000
        let iScale: CGFloat = 1 / scale
        shapes.removeAll()
        
        let pointsA = self.generateStarPoints(
            smallRadius: test.smallRadius,
            bigRadius: test.bigRadius,
            count: test.count,
            angle: angle,
            scale: scale
        )

        let pointsB = self.generateStarPoints(
            smallRadius: test.smallRadius,
            bigRadius: test.bigRadius,
            count: test.count,
            angle: 0,
            scale: scale
        )
        
        let sA = pointsA.map({ $0.fixVec })
        let sB = pointsB.map({ $0.fixVec })

        var overlay = Overlay()
        overlay.add(path: sA, type: .subject)
        overlay.add(path: sB, type: .clip)
        
        let list = overlay.buildGraph().extractShapes(overlayRule: operation)
        
        for i in 0..<list.count {
            let color = Color(index: i)
            let item = list[i]

            let hull = matrix.screen(worldPoints: item.contour.map({ iScale * $0.cgPoint }))
            
            var holes = [[CGPoint]]()
            for hole in item.holes {
                holes.append(matrix.screen(worldPoints: hole.map({ iScale * $0.cgPoint })))
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

        angle += 0.01
    }
 
    
    private func generateStarPoints(smallRadius: CGFloat, bigRadius: CGFloat, count: Int, angle: Double, scale: CGFloat) -> [CGPoint] {
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
            
            points.append(CGPoint(x: xR * scale, y: yR * scale))
            points.append(CGPoint(x: xr * scale, y: yr * scale))
        }
        
        return points
    }
}

extension OverlayRule {
    
    
    var title: String {
        switch self {
        case .subject:
            return "subject"
        case .clip:
            return "clip"
        case .intersect:
            return "intersect"
        case .union:
            return "union"
        case .difference:
            return "difference"
        case .xor:
            return "xor"
        }
        
    }
    
}
