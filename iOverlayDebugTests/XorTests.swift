//
//  XorTests.swift
//  iOverlayDebugTests
//
//  Created by Nail Sharipov on 24.08.2023.
//


import XCTest
import iOverlay
import iFixFloat

final class XorTests: XCTestCase {

    func test_0() throws {
        var overlay = Overlay()
        
        let subj = [
            CGPoint(x: -10, y: -10),
            CGPoint(x: -10, y:  10),
            CGPoint(x:  10, y:  10),
            CGPoint(x:  10, y: -10)
        ].map({ $0.fix })
        
        let clip = [
            CGPoint(x:  -5, y:  -5),
            CGPoint(x:  -5, y:  15),
            CGPoint(x:  15, y:  15),
            CGPoint(x:  15, y:  -5)
        ].map({ $0.fix })
        
        
        overlay.add(path: subj, type: .subject)
        overlay.add(path: clip, type: .clip)
        
        let shapes = overlay.buildGraph().extractShapes(fillRule: .xor)
        
        XCTAssertEqual(shapes.count, 2)
        XCTAssertEqual(shapes[0].paths.count, 1)
        XCTAssertEqual(shapes[1].paths.count, 1)

        let path0 = [
            FixVec(-10240, -10240),
            FixVec(-10240, 10240),
            FixVec(-5120, 10240),
            FixVec(-5120, -5120),
            FixVec(10240, -5120),
            FixVec(10240, -10240)
        ]
        
        XCTAssertEqual(shapes[0].contour, path0)
        
        let path1 = [
            FixVec(-5120, 10240),
            FixVec(-5120, 15360),
            FixVec(15360, 15360),
            FixVec(15360, -5120),
            FixVec(10240, -5120),
            FixVec(10240, 10240)
        ]
        
        XCTAssertEqual(shapes[1].contour, path1)
    }

    func test_1() throws {
        var overlay = Overlay()
        
        let subj0 = [
            CGPoint(x: -20, y: -16),
            CGPoint(x: -20, y:  16),
            CGPoint(x:  20, y:  16),
            CGPoint(x:  20, y: -16)
        ].map({ $0.fix })
        
        let subj1 = [
            CGPoint(x: -12, y: -8),
            CGPoint(x: -12, y:  8),
            CGPoint(x:  12, y:  8),
            CGPoint(x:  12, y: -8)
        ].map({ $0.fix })

        
        let clip = [
            CGPoint(x: -4, y: -24),
            CGPoint(x: -4, y:  24),
            CGPoint(x:  4, y:  24),
            CGPoint(x:  4, y: -24)
        ].map({ $0.fix })
        
        
        overlay.add(path: subj0, type: .subject)
        overlay.add(path: subj1, type: .subject)
        overlay.add(path: clip, type: .clip)
        
        let shapes = overlay.buildGraph().extractShapes(fillRule: .xor)
        
        XCTAssertEqual(shapes.count, 5)
        XCTAssertEqual(shapes[0].paths.count, 1)
        XCTAssertEqual(shapes[1].paths.count, 1)
        XCTAssertEqual(shapes[2].paths.count, 1)
        XCTAssertEqual(shapes[3].paths.count, 1)
        XCTAssertEqual(shapes[4].paths.count, 1)
        
        let path0 = [
            FixVec(-20480, -16384),
            FixVec(-20480, 16384),
            FixVec(-4096, 16384),
            FixVec(-4096, 8192),
            FixVec(-12288, 8192),
            FixVec(-12288, -8192),
            FixVec(-4096, -8192),
            FixVec(-4096, -16384)
        ]
        
        XCTAssertEqual(shapes[0].contour, path0)
        
        let path1 = [
            FixVec(-4096, -24576),
            FixVec(-4096, -16384),
            FixVec(4096, -16384),
            FixVec(4096, -24576)
        ]
        
        XCTAssertEqual(shapes[1].contour, path1)
        
        let path2 = [
            FixVec(-4096, -8192),
            FixVec(-4096, 8192),
            FixVec(4096, 8192),
            FixVec(4096, -8192)
        ]
        
        XCTAssertEqual(shapes[2].contour, path2)
        
        let path3 = [
            FixVec(-4096, 16384),
            FixVec(-4096, 24576),
            FixVec(4096, 24576),
            FixVec(4096, 16384)
        ]
        
        XCTAssertEqual(shapes[3].contour, path3)
        
        let path4 = [
            FixVec(4096, -16384),
            FixVec(4096, -8192),
            FixVec(12288, -8192),
            FixVec(12288, 8192),
            FixVec(4096, 8192),
            FixVec(4096, 16384),
            FixVec(20480, 16384),
            FixVec(20480, -16384)
        ]
        
        XCTAssertEqual(shapes[4].contour, path4)
    }
    
    func test_2() throws {
        var overlay = Overlay()
        
        let subj0 = [
            CGPoint(x: -30, y: -30),
            CGPoint(x: -30, y: 30),
            CGPoint(x: 30, y: 30),
            CGPoint(x: 30, y: -30)
        ].map({ $0.fix })
        
        let subj1 = [
            CGPoint(x: -20, y: -20),
            CGPoint(x: -20, y: 20),
            CGPoint(x: 20, y: 20),
            CGPoint(x: 20, y: -20)
        ].map({ $0.fix })
        
        let clip = [
            CGPoint(x: -5, y: -5),
            CGPoint(x: -5, y:  5),
            CGPoint(x:  5, y:  5),
            CGPoint(x:  5, y: -5)
        ].map({ $0.fix })
        
        
        overlay.add(path: subj0, type: .subject)
        overlay.add(path: subj1, type: .subject)
        overlay.add(path: clip, type: .clip)
        
        let shapes = overlay.buildGraph().extractShapes(fillRule: .xor)
        
        XCTAssertEqual(shapes.count, 2)
        XCTAssertEqual(shapes[0].paths.count, 2)
        XCTAssertEqual(shapes[1].paths.count, 1)
        
        let path0 = [
            FixVec(-30720, -30720),
            FixVec(-30720, 30720),
            FixVec(30720, 30720),
            FixVec(30720, -30720)
        ]
        
        XCTAssertEqual(shapes[0].paths[0], path0)
        
        let path1 = [
            FixVec(-20480, -20480),
            FixVec(-20480, 20480),
            FixVec(20480, 20480),
            FixVec(20480, -20480)
        ]
        
        XCTAssertEqual(shapes[0].paths[1], path1)
        
        let path2 = [
            FixVec(-5120, -5120),
            FixVec(-5120, 5120),
            FixVec(5120, 5120),
            FixVec(5120, -5120)
        ]
        
        XCTAssertEqual(shapes[1].paths[0], path2)
    }
    
    func test_3() throws {
        var overlay = Overlay()
        
        let subj0 = [
            CGPoint(x: -20, y: -20),
            CGPoint(x: -20, y: 20),
            CGPoint(x: 20, y: 20),
            CGPoint(x: 20, y: -20)
        ].map({ $0.fix })
        
        let subj1 = [
            CGPoint(x: -10, y: -10),
            CGPoint(x: -10, y: 0),
            CGPoint(x: 0, y: 0),
            CGPoint(x: 0, y: -10)
        ].map({ $0.fix })
        
        let subj2 = [
            CGPoint(x: 0, y: -10),
            CGPoint(x: 0, y: 10),
            CGPoint(x: 10, y: 10),
            CGPoint(x: 10, y: -10)
        ].map({ $0.fix })
        
        let clip = [
            CGPoint(x: -5, y: -5),
            CGPoint(x: -5, y: 5),
            CGPoint(x: 5, y: 5),
            CGPoint(x: 5, y: -5)
        ].map({ $0.fix })
        
        
        overlay.add(path: subj0, type: .subject)
        overlay.add(path: subj1, type: .subject)
        overlay.add(path: subj2, type: .subject)
        overlay.add(path: clip, type: .clip)
        
        let shapes = overlay.buildGraph().extractShapes(fillRule: .xor)

        XCTAssertEqual(shapes.count, 2)
        XCTAssertEqual(shapes[0].paths.count, 2)
        XCTAssertEqual(shapes[1].paths.count, 1)
        
        let path0 = [
            FixVec(-20480, -20480),
            FixVec(-20480, 20480),
            FixVec(20480, 20480),
            FixVec(20480, -20480)
        ]
        
        XCTAssertEqual(shapes[0].contour, path0)
        
        let path1 = [
            FixVec(-10240, -10240),
            FixVec(-10240, 0),
            FixVec(-5120, 0),
            FixVec(-5120, 5120),
            FixVec(0, 5120),
            FixVec(0, 10240),
            FixVec(10240, 10240),
            FixVec(10240, -10240)
        ]
        
        XCTAssertEqual(shapes[0].paths[1], path1)
        
        let path2 = [
            FixVec(-5120, -5120),
            FixVec(-5120, 0),
            FixVec(0, 0),
            FixVec(0, 5120),
            FixVec(5120, 5120),
            FixVec(5120, -5120)
        ]
        
        XCTAssertEqual(shapes[1].paths[0], path2)
    }
}

