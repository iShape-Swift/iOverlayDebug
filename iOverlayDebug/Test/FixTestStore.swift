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
            name: "Simple 0",
            path: [
                CGPoint(x: -20, y:   0),
                CGPoint(x: -10, y:  15),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  20, y:   0)
            ]),
        .init(
            name: "Simple 1",
            path: [
                CGPoint(x: -20, y:   0),
                CGPoint(x:  10, y:  15),
                CGPoint(x: -10, y: -15),
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
            ]),
        .init(
            name: "Simple 15",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x: -12, y:  24),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  20, y:  -3),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:  -1, y:  19),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 16",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x:  -5, y:  37),
                CGPoint(x: -10, y:  -1),
                CGPoint(x:  10, y:  -1),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:   7, y:  -5),
                CGPoint(x: -10, y:  -1),
                CGPoint(x:  10, y:  -1),
                CGPoint(x:  -5, y:  37),
                CGPoint(x: -10, y:  -1),
                CGPoint(x:  18, y:  19),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 17",
            path: [
                CGPoint(x:  -2, y:   5),
                CGPoint(x:  -2, y: -20),
                CGPoint(x:   5, y: -20),
                CGPoint(x:   5, y:   0),
                CGPoint(x:   7, y: -20),
                CGPoint(x:  -4, y: -20),
                CGPoint(x:   9, y:  10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  -7, y: -20),
                CGPoint(x:  10, y: -20)
            ]),
        .init(
            name: "Simple 18",
            path: [
                CGPoint(x:  -5, y:  20),
                CGPoint(x:  -5, y:   0),
                CGPoint(x:   0, y:   0),
                CGPoint(x:   5, y:   5),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  20, y:   0),
                CGPoint(x:  20, y:  15),
                CGPoint(x: -15, y:   0),
                CGPoint(x:  15, y:   0)
            ]),
        .init(
            name: "Simple 19",
            path: [
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:   5, y:   0),
                CGPoint(x:   5, y:  10),
                CGPoint(x:   0, y:  10),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  15, y:   5),
                CGPoint(x:  15, y:  10)
            ]),
        .init(
            name: "Simple 20",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:  20),
                CGPoint(x:   0, y:  10)
            ]),
        .init(
            name: "Simple 21",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x: -12, y:  24),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  20, y:  -3),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:  -1, y:  19),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -12, y:  24),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 22",
            path: [
                CGPoint(x:  15, y:  25),
                CGPoint(x: -12, y:  20),
                CGPoint(x:  -5, y:   0),
                CGPoint(x:  -5, y:  -9),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -22),
                CGPoint(x:  -5, y: -25),
                CGPoint(x:   0, y: -25),
                CGPoint(x:   0, y:  30),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -11, y:   0),
                CGPoint(x: -12, y:  20),
                CGPoint(x:  15, y:  20)
            ]),
        .init(
            name: "Simple 23",
            path: [
                CGPoint(x:  15, y:  25),
                CGPoint(x: -12, y:  20),
                CGPoint(x:  -5, y:   0),
                CGPoint(x:   0, y:  30),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -11, y:   0),
                CGPoint(x: -12, y:  20),
                CGPoint(x:  15, y:  20)
            ]),
        .init(
            name: "Simple 24",
            path: [
                CGPoint(x:  10, y:  20),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -10, y:  10),
                CGPoint(x:   0, y:  10),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0)
            ]),
        .init(
            name: "Simple 25",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x:  -5, y:  21),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  20, y:   5),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:   0, y: -20),
                CGPoint(x:   0, y:  21),
                CGPoint(x:  10, y:  14),
                CGPoint(x: -10, y:  14),
                CGPoint(x: -10, y:  -7),
                CGPoint(x:  10, y:   5),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 26",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x:  -2, y: -26),
                CGPoint(x:  -2, y:   5),
                CGPoint(x:  20, y:   5),
                CGPoint(x:  20, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:   0, y: -20),
                CGPoint(x:   0, y:  25),
            ]),
        .init(
            name: "Simple 27",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x:  -2, y: -26),
                CGPoint(x:  -2, y:   5),
                CGPoint(x:  20, y:   5),
                CGPoint(x:  20, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:   0, y: -20),
                CGPoint(x:   0, y:  -5),
            ]),
        .init(
            name: "Simple 28",
            path: [
                CGPoint(x: 15.0, y: -4.0),
                CGPoint(x: -5.0, y: -24.0),
                CGPoint(x: -5.0, y: 5.0),
                CGPoint(x: 20.0, y: 5.0),
                CGPoint(x: 20.0, y: -15.0),
                CGPoint(x: -9.0, y: -10.0),
                CGPoint(x: -1, y: -20.0),
                CGPoint(x: -1, y: 25.0)
            ]),
        .init(
            name: "Same Line 1",
            path: [
                CGPoint(x:   5, y:   5),
                CGPoint(x:  15, y:   5),
                CGPoint(x:  15, y:  -5),
                CGPoint(x:   5, y:  -5),
                CGPoint(x:   5, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y:  -5),
                CGPoint(x: -15, y:  -5),
                CGPoint(x: -15, y:   5),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y:  15),
                CGPoint(x:   5, y:  15),
            ]),
        .init(
            name: "Same Line 2",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  10, y:   5),
                CGPoint(x:  10, y:  15),
                CGPoint(x: -10, y:  15),
                CGPoint(x: -10, y: -15),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  10, y:  -5),
            ]),
        .init(
            name: "Same Line 3",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  10, y:   5),
                CGPoint(x:  10, y:  15),
                CGPoint(x:   0, y:  15),
                CGPoint(x:   0, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y: -10),
                CGPoint(x:   0, y: -10),
                CGPoint(x:   0, y: -15),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  10, y:  -5),
            ]),
        .init(
            name: "Same Line 4",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  10, y:   5),
                CGPoint(x:  10, y:  15),
                CGPoint(x:   0, y:  15),
                CGPoint(x:   0, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y: -15),
                CGPoint(x:   0, y: -15),
                CGPoint(x:   0, y: -10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y:  -5),
            ]),
        .init(
            name: "Random 0",
            path: [
                CGPoint(x: -5921, y: -17504),
                CGPoint(x: 16517, y:  17652),
                CGPoint(x:  1040, y:    578),
            ])
    ]
}
