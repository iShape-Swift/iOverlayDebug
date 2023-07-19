//
//  FixTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 107.2023.
//

import iDebug
import CoreGraphics

struct FixTest {
    let name: String
    let path: [CGPoint]
}

final class FixTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: FixTestStore.self), nilValue: 0)
    
    var onUpdate: (() -> ())?
    
    var tests: [TestHandler] {
        var result = [TestHandler]()
        result.reserveCapacity(data.count)
        
        for i in 0..<data.count {
            result.append(.init(id: i, title: data[i].name))
        }
        
        return result
    }
    
    var testId: Int {
        get {
            pIndex.value
        }
        
        set {
            pIndex.value = newValue
            self.onUpdate?()
        }
    }
    
    var test: FixTest {
        data[testId]
    }
    
    let data: [FixTest] = [
        .init(
            name: "Square 1",
            path: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10)
            ]),
        .init(
            name: "Square 2",
            path: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -10, y:  10),
                CGPoint(x:   0, y:  10),
                
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y: -10),
                CGPoint(x:   0, y: -10)
            ]),
        .init(
            name: "Simple 1",
            path: [
                CGPoint(x: -20, y:   0),
                CGPoint(x: -10, y:  15),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  20, y:   0)
            ]),
        .init(
            name: "Simple 2",
            path: [
                CGPoint(x: -10, y: -10),
                CGPoint(x:  20, y:   0),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10)
            ]),
        .init(
            name: "Simple 3",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:   0, y:  20),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  -5, y:   0),
                CGPoint(x:   0, y:  10),
                CGPoint(x:   5, y:   0),
                CGPoint(x:   0, y: -10)
            ]),
        .init(
            name: "Simple 4",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:   0, y:  10),
                CGPoint(x:  10, y:   0)
            ]),
        .init(
            name: "Simple 5",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y:  10)
            ]),
        .init(
            name: "Simple 6",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:  10),
                CGPoint(x:   0, y:  10)
            ]),
        .init(
            name: "Simple 7",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:   0, y:  20),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  -4, y:  -6),
                CGPoint(x:   0, y:  10),
                CGPoint(x:   5, y:   0),
                CGPoint(x:   0, y: -10)
            ]),
        .init(
            name: "Simple 8",
            path: [
                CGPoint(x:   0, y:   5),
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   5, y:  -5),
                CGPoint(x:   5, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:  -5, y:   5)
            ]),
        .init(
            name: "Simple 9",
            path: [
                CGPoint(x:   0, y:   5),
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   5, y:  -5),
                CGPoint(x:   5, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:   5, y: -10)
            ]),
        .init(
            name: "Simple 10",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:   5, y: -20),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 11",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:  -5, y:  -2),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 12",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:  -1, y:  -2),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 13",
            path: [
                CGPoint(x:  -5, y:   0),
                CGPoint(x:   0, y:  10),
                CGPoint(x:  12, y:  -3),
                CGPoint(x: -10, y: -13),
                CGPoint(x: -16, y:  -2),
                CGPoint(x: -10, y: -13),
                CGPoint(x:  12, y:  -3),
                CGPoint(x:   7, y:   9)
            ]),
        .init(
            name: "Simple 14",
            path: [
                CGPoint(x:  0, y: -10),
                CGPoint(x:  0, y:   5),
                CGPoint(x: -5, y: -15),
                CGPoint(x: -5, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: -15),
                CGPoint(x: -5, y: -15),
                CGPoint(x: -5, y: -20),
                CGPoint(x: -5, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x:  2, y: -15),
                CGPoint(x: -5, y: -15),
                CGPoint(x: 10, y: -15),
                CGPoint(x: -5, y: -10)
            ])
    ]
}
