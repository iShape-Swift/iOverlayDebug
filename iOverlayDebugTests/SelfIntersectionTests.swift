//
//  SelfIntersectionTests.swift
//  SelfIntersectionTests
//
//  Created by Nail Sharipov on 24.08.2023.
//

import XCTest
import iOverlay
import iFixFloat

final class SelfIntersectionTests: XCTestCase {

    func test_0() throws {
        var overlay = Overlay()
        overlay.add(path: [
            FixVec(0, 0),
            FixVec(0, 1024),
            FixVec(1024, 1024),
            FixVec(1024, 0)
        ], type: .subject)
        
        let shapes = overlay.buildGraph().extractShapes(fillRule: .subject)
        let contour = shapes[0].contour
        
        
        let test = [
            FixVec(0, 0),
            FixVec(0, 1024),
            FixVec(1024, 1024),
            FixVec(1024, 0)
        ]
        
        XCTAssertEqual(contour, test)
    }

    func test_1() throws {
        var overlay = Overlay()
        overlay.add(path: [
            FixVec(-1024, 0),
            FixVec(-1024, 1024),
            FixVec(0, 1024),
            FixVec(0, -1024),
            FixVec(1024, -1024),
            FixVec(1024, 0)
        ], type: .subject)
        
        let shapes = overlay.buildGraph().extractShapes(fillRule: .subject)
        XCTAssertEqual(shapes.count, 2)

        let shape0 = [
            FixVec(-1024, 0),
            FixVec(-1024, 1024),
            FixVec(0, 1024),
            FixVec(0, 0)
        ]
        XCTAssertEqual(shapes[0].contour, shape0)

        let shape1 = [
            FixVec(0, -1024),
            FixVec(0, 0),
            FixVec(1024, 0),
            FixVec(1024, -1024)
        ]
        XCTAssertEqual(shapes[1].contour, shape1)
    }


}
