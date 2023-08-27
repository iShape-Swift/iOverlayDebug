//
//  StarTests.swift
//  iOverlayDebugTests
//
//  Created by Nail Sharipov on 27.08.2023.
//

import XCTest
import iOverlay
import iFixFloat

final class StarTests: XCTestCase {
    
    func test_brute_0() throws {

        let clip = createStar(100.0, 200.0, 5, 0)

        var angle: Double = 0
        
        for i in 0..<20_000 {
            if i % 100 == 0 {
                print("test index: \(i)")
            }
            
            var overlay = Overlay()
            let subj = createStar(100.0, 200.0, 7, angle)

            overlay.add(path: subj, type: .subject)
            overlay.add(path: clip, type: .clip)

            let shapes = overlay.buildGraph().extractShapes(fillRule: .union)
        
            XCTAssertEqual(shapes.count > 0, true)
            
            angle += 0.0025;
        }
    }
    
    func test_single_0() throws {

        let clip = createStar(100.0, 200.0, 5, 0)

        let angle: Double = 41.634999999998378
            
        var overlay = Overlay()
        let subj = createStar(100.0, 200.0, 7, angle)

        overlay.add(path: subj, type: .subject)
        overlay.add(path: clip, type: .clip)

        let shapes = overlay.buildGraph().extractShapes(fillRule: .union)
    
        XCTAssertEqual(shapes.count > 0, true)
    }
    
    private func createStar(_ r0: Double, _ r1: Double, _ count: Int, _ angle: Double) -> [FixVec] {
        let dA = Double.pi / Double(count)
        var a: Double = angle
        
        let x0: Double = 400.0
        let y0: Double = 400.0
        
        var points = [FixVec]()
        points.reserveCapacity(2 * count)
        
        
        for _ in 0..<count {
            let xr0 = r0 * cos(a) + x0
            let yr0 = r0 * sin(a) + y0
            
            a += dA

            let xr1 = r1 * cos(a) + x0
            let yr1 = r1 * sin(a) + y0
            
            a += dA
            
            let p0 = FixVec(x: xr0.fix, y: yr0.fix)
            let p1 = FixVec(x: xr1.fix, y: yr1.fix)
            
            points.append(p0)
            points.append(p1)
        }
        
        return points
    }
}
