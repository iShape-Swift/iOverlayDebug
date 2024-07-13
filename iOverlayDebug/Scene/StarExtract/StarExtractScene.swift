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
    let scale: CGFloat = 1
    
    private (set) var shapes: [XShape] = []
    
    @Published
    var operation: OverlayRule = .union
    
    let operations: [OverlayRule] = [
        .clip,
        .subject,
        .difference,
        .intersect,
        .inverseDifference,
        .union,
        .xor
    ]
    
    @Published
    var angle: Double = 0 {
        didSet {
            self.solve()
        }
    }
    
    private var matrix: Matrix = .empty
    private var timer: Timer?
    
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
//        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
//            self?.solve()
    //        angle += 0.01
//        }
    }

    func onDisappear() {
        timer?.invalidate()
        timer = nil
    }
    
    func solve() {
        defer {
            self.objectWillChange.send()
        }

        shapes.removeAll()

        let sA = self.startA()
        let sB = self.startB()

        print("starA : \(sA)")
        print("starB : \(sB)")
        
        var overlay = Overlay()
        overlay.add(path: sA, type: .subject)
        overlay.add(path: sB, type: .clip)
        
        let list = overlay.buildGraph().extractShapes(overlayRule: operation)
        
        let iScale: CGFloat = 1 / scale
        
        for i in 0..<list.count {
            let color = Color(index: i)
            let item = list[i]

            let hull = matrix.screen(worldPoints: item[0].map({ iScale * $0.cgPoint }))
            
            var holes = [[CGPoint]]()
            if item.count > 1 {
                for hole in item[1..<item.count] {
                    holes.append(matrix.screen(worldPoints: hole.map({ iScale * $0.cgPoint })))
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
    
    private func startA() -> [Point] {
        let test = starTestStore.test
        
        return self.generateStarPoints(
            smallRadius: test.smallRadius,
            bigRadius: test.bigRadius,
            count: test.count,
            angle: angle,
            scale: scale
        ).map({ $0.point })
    }
    
    private func startB() -> [Point] {
        let test = starTestStore.test
        
        return self.generateStarPoints(
            smallRadius: test.smallRadius,
            bigRadius: test.bigRadius,
            count: test.count,
            angle: 0,
            scale: scale
        ).map({ $0.point })
    }
    
    func printTest() {
        print("starA : \(self.startA())")
        print("starB : \(self.startB())")
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
        case .inverseDifference:
            return "inverseDifference"
        case .xor:
            return "xor"
        }
        
    }
    
}
