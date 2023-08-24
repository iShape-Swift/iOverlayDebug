//
//  iOverlayDebugTests.swift
//  iOverlayDebugTests
//
//  Created by Nail Sharipov on 24.08.2023.
//

import XCTest
import iOverlay
import iFixFloat

final class iOverlayDebugTests: XCTestCase {

    func test_self_intersect() throws {
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


}
