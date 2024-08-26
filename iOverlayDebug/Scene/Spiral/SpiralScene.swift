//
//  SpiralScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 24.08.2024.
//

import SwiftUI
import iDebug
import iShape
import iOverlay
import iFixFloat


final class SpiralScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "SpiralScene"
    
    @Published
    var count: CGFloat = 50 {
        didSet {
            self.solve()
        }
    }
    
    @Published
    var radius: CGFloat = 100.0 {
        didSet {
            self.solve()
        }
    }
    
    let edgeTestStore = EdgeTestStore()
    var testStore: TestStore { edgeTestStore }

    private (set) var rawShape: [CGPoint] = []
    private (set) var spiralShape: [CGPoint] = []
    
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
    
    func makeView() -> SpiralSceneView {
        SpiralSceneView(scene: self)
    }
    
    
    func onAppear() {
        solve()
    }

    func solve() {
        defer {
            self.objectWillChange.send()
        }
        rawShape.removeAll()
        spiralShape.removeAll()
        
        
        self.rawShape = self.spiral(count: Int(self.count), radius: self.radius, width: 10)
        
        
        var overlay = CGOverlay()
        overlay.add(path: self.rawShape, type: .subject)
        
        spiralShape = overlay.buildGraph(fillRule: .nonZero).extractShapes(overlayRule: .subject).first![0]
    }

    func spiral(count: Int, radius: CGFloat, width w: CGFloat) -> [CGPoint] {
        var aPath = [CGPoint]()
        var bPath = [CGPoint]()
        
        var a: Double = 0
        var i = 0
        var r = radius
        let x0 = 0.5 * self.matrix.screenSize.width
        let y0 = 0.5 * self.matrix.screenSize.height
        
        let c0 = CGPoint(x: x0, y: y0)
        var p0 = c0

        while i < count {
            let da = radius / r
            let sx = cos(a)
            let sy = sin(a)

            let rr: CGFloat
            
            if i % 2 == 0 {
                rr = r + 0.2 * radius
            } else {
                rr = r - 0.2 * radius
            }
            
            let p = CGPoint(x: rr * sx, y: rr * sy) + c0
            let n = (p - p0).normalize
            let t = CGPoint(x: w * -n.y, y: w * n.x)

            aPath.append(p0 + t)
            aPath.append(p + t)
            bPath.append(p0 - t)
            bPath.append(p - t)
            
            a += da
            r = radius * (1 + a / (2 * .pi))
            p0 = p
            i += 1
        }

        bPath.reverse()

        aPath.append(contentsOf: bPath)
        
        return aPath
    }

}
