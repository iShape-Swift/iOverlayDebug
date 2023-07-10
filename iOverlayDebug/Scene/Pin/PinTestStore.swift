//
//  PinTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.07.2023.
//

import iDebug
import iFixFloat
import CoreGraphics

struct PinTest {
    let name: String
    let pA: [CGPoint]
    let pB: [CGPoint]
}

final class PinTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: PinTestStore.self), nilValue: 0)
    
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
    
    var test: PinTest {
        data[testId]
    }
    
    let data: [PinTest] = [
        .init(
            name: "Two Rect 1",
            pA: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10)
            ],
            pB: [
                CGPoint(x:   0, y: -5),
                CGPoint(x:   0, y:  5),
                CGPoint(x:  20, y:  5),
                CGPoint(x:  20, y: -5)
            ]
        ),
        .init(
            name: "Two Rect 2",
            pA: [
                CGPoint(x: -5, y: -10),
                CGPoint(x: -5, y:  10),
                CGPoint(x:  15, y:  10),
                CGPoint(x:  15, y: -10)
            ],
            pB: [
                CGPoint(x: -10, y: -5),
                CGPoint(x: -10, y:  15),
                CGPoint(x:  10, y:  15),
                CGPoint(x:  10, y: -5)
            ]
        ),
        .init(
            name: "Two Rect 3",
            pA: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ],
            pB: [
                CGPoint(x: -5.0, y: -20.0),
                CGPoint(x: -5.0, y: 20.0),
                CGPoint(x: 5.0, y: 20.0),
                CGPoint(x: 5.0, y: -20.0)
            ]
        ),
        .init(
            name: "Two Rect 4",
            pA: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ],
            pB: [
                CGPoint(x:  0.0, y:-15.0),
                CGPoint(x:-15.0, y:  0.0),
                CGPoint(x:  0.0, y: 15.0),
                CGPoint(x: 15.0, y:   0.0)
            ]
        ),
        .init(
            name: "Two Rect 5",
            pA: [
                CGPoint(x:  0.0, y:-15.0),
                CGPoint(x:-15.0, y:  0.0),
                CGPoint(x:  0.0, y: 15.0),
                CGPoint(x: 15.0, y:   0.0)
            ],
            pB: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]
        ),
        .init(
            name: "Two Rect 6",
            pA: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ],
            pB: [
                CGPoint(x:  0.0, y:-20.0),
                CGPoint(x:-20.0, y:  0.0),
                CGPoint(x:  0.0, y: 20.0),
                CGPoint(x: 20.0, y:   0.0)
            ]
        ),
        .init(
            name: "Two Rect 7",
            pA: [
                CGPoint(x:  0.0, y:-20.0),
                CGPoint(x:-20.0, y:  0.0),
                CGPoint(x:  0.0, y: 20.0),
                CGPoint(x: 20.0, y:   0.0)
            ],
            pB: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]
        ),
        .init(
            name: "Two Rect 8",
            pA: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ],
            pB: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]
        ),
        .init(
            name: "Two Rect 9",
            pA: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ],
            pB: [
                CGPoint(x: -20.0, y: -10.0),
                CGPoint(x: -20.0, y:   0.0),
                CGPoint(x:  10.0, y:   0.0),
                CGPoint(x:  10.0, y: -10.0)
            ]
        ),
        .init(
            name: "Two Rect 11",
            pA: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ],
            pB: [
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -5.0, y: 10.0),
                CGPoint(x: 5.0, y: 10.0),
                CGPoint(x: 5.0, y: -20.0)
            ]
        ),
        .init(
            name: "Two Rect 12",
            pA: [
                CGPoint(x:  0.0, y:   0.0),
                CGPoint(x:  0.0, y:  20.0),
                CGPoint(x: 20.0, y:  20.0),
                CGPoint(x: 20.0, y:   0.0)
            ],
            pB: [
                CGPoint(x:  0.0, y:  0.0),
                CGPoint(x:  0.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y:  0.0)
            ]
        ),
        .init(
            name: "Two Rect 13",
            pA: [
                CGPoint(x:  0.0, y:   0.0),
                CGPoint(x:  0.0, y:  20.0),
                CGPoint(x: 20.0, y:  20.0),
                CGPoint(x: 20.0, y:   0.0)
            ],
            pB: [
                CGPoint(x:  0.0, y: 10.0),
                CGPoint(x:  0.0, y: 20.0),
                CGPoint(x: 10.0, y: 20.0),
                CGPoint(x: 10.0, y: 10.0)
            ]
        ),
        .init(
            name: "Concave 0",
            pA: [
                CGPoint(x: -25.0, y:  -5.0),
                CGPoint(x: -25.0, y:   5.0),
                CGPoint(x: -12.0, y:   5.0),
                CGPoint(x:  -8.0, y:  10.0),
                CGPoint(x:  -8.0, y:   5.0),
                CGPoint(x:  25.0, y:   5.0),
                CGPoint(x:  25.0, y:  -5.0)
            ],
            pB: [
                CGPoint(x: -15.0, y:  0.0),
                CGPoint(x: -15.0, y: 20.0),
                CGPoint(x:  15.0, y: 20.0),
                CGPoint(x:  15.0, y:  0.0),
                CGPoint(x:   5.0, y:  0.0),
                CGPoint(x:   5.0, y: 10.0),
                CGPoint(x:  -5.0, y: 10.0),
                CGPoint(x:  -5.0, y:  0.0)
            ]
        ),
        .init(
            name: "Concave 1",
            pA: [
                CGPoint(x: -25.0, y:  -5.0),
                CGPoint(x: -25.0, y:   5.0),
                CGPoint(x:  25.0, y:   5.0),
                CGPoint(x:  25.0, y:  -5.0)
            ],
            pB: [
                CGPoint(x: -15.0, y:  0.0),
                CGPoint(x: -15.0, y: 20.0),
                CGPoint(x:  15.0, y: 20.0),
                CGPoint(x:  15.0, y:  0.0),
                CGPoint(x:   5.0, y:  0.0),
                CGPoint(x:   5.0, y: 10.0),
                CGPoint(x:  -5.0, y: 10.0),
                CGPoint(x:  -5.0, y:  0.0)
            ]
        ),
        .init(
            name: "Concave 2",
            pA: [
                CGPoint(x: -25.0, y:  -5.0),
                CGPoint(x: -25.0, y:   5.0),
                CGPoint(x:  25.0, y:   5.0),
                CGPoint(x:  25.0, y:  -5.0)
            ],
            pB: [
                CGPoint(x: -15.0, y: -10.0),
                CGPoint(x: -15.0, y:  20.0),
                CGPoint(x:  15.0, y:  20.0),
                CGPoint(x:  15.0, y: -10.0),
                CGPoint(x:   5.0, y: -10.0),
                CGPoint(x:   5.0, y:  10.0),
                CGPoint(x:  -5.0, y:  10.0),
                CGPoint(x:  -5.0, y: -10.0)

            ]
        ),
        .init(
            name: "Concave 3",
            pA: [
                CGPoint(x: -10.0, y: -15.0),
                CGPoint(x: -10.0, y:  15.0),
                CGPoint(x:  10.0, y:  15.0),
                CGPoint(x:  10.0, y: -15.0),
                CGPoint(x:   5.0, y: -15.0),
                CGPoint(x:   5.0, y:  10.0),
                CGPoint(x:  -5.0, y:  10.0),
                CGPoint(x:  -5.0, y: -15.0)

            ],
            pB: [
                CGPoint(x: -20.0, y:  -5.0),
                CGPoint(x: -20.0, y:   5.0),
                CGPoint(x:  20.0, y:   5.0),
                CGPoint(x:  20.0, y:  -5.0)
            ]
        ),
        .init(
            name: "Test 0",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: -5, y: 10),
                CGPoint(x: 5, y: 10)
            ]
        ),
        // 1
        .init(
            name: "Test 1",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: -10, y: -5),
                CGPoint(x: -10, y: 5)
            ]
        ),
        // 2
        .init(
            name: "Test 2",
                pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: 5, y: -10),
                CGPoint(x: -5, y: -10)
            ]
        ),
        // 3
        .init(
            name: "Test 3",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: 10, y: 5),
                CGPoint(x: 10, y: -5)
            ]
        ),
        // 4
        .init(
            name: "Test 4",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10)
            ]
        ),
        // 5
        .init(
            name: "Test 5",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 10)
            ]
        ),
        // 6
        .init(
            name: "Test 6",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]
        ),
        // 7
        .init(
            name: "Test 7",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10)
            ]
        ),
        // 8
        .init(
            name: "Test 8",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: -10, y: 5),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: 5)
            ]
        ),
        // 9
        .init(
            name: "Test 9",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: -5, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 10),
                CGPoint(x: -5, y: 10)
            ]
        ),
        // 10
        .init(
            name: "Test 10",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 10, y: -5),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: -5)
            ]
        ),
        // 11
        .init(
            name: "Test 11",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 5, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 5, y: -10)
            ]
        ),
        // 12
        .init(
            name: "Test 12",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 10, y: 0),
                CGPoint(x: 0, y: 10),
                CGPoint(x: 10, y: 10)
            ]
        ),
        // 13
        .init(
            name: "Test 13",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 10),
                CGPoint(x: -10, y: 0),
                CGPoint(x: -10, y: 10)
            ]
        ),
        // 14
        .init(
            name: "Test 14",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: -10, y: 0),
                CGPoint(x: 0, y: -10),
                CGPoint(x: -10, y: -10)
            ]
        ),
        // 15
        .init(
            name: "Test 15",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: -10),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: -10)
            ]
        ),
        // 16
        .init(
            name: "Test 16",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 0, y: 10)
            ]
        ),
        // 17
        .init(
            name: "Test 17",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 0)
            ]
        ),
        // 18
        .init(
            name: "Test 18",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: -10, y: 0),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 0, y: -10)
            ]
        ),
        // 19
        .init(
            name: "Test 19",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 0, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: 0)
            ]
        ),
        // 20
        .init(
            name: "Test 20",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: -15, y: 10),
                CGPoint(x: -15, y: 20),
                CGPoint(x: -5, y: 20),
                CGPoint(x: -5, y: 10)
            ]
        ),
        // 21
        .init(
            name: "Test 21",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: -15, y: 0),
                CGPoint(x: -15, y: 10),
                CGPoint(x: -5, y: 10),
                CGPoint(x: -5, y: 0)
            ]
        ),
        // 22
        .init(
            name: "Test 22",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 5, y: 10),
                CGPoint(x: 5, y: 20),
                CGPoint(x: 15, y: 20),
                CGPoint(x: 15, y: 10)
            ]
        ),
        // 23
        .init(
            name: "Test 23",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 5, y: 0),
                CGPoint(x: 5, y: 10),
                CGPoint(x: 15, y: 10),
                CGPoint(x: 15, y: 0)
            ]
        ),
        // 24
        .init(
            name: "Test 24",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: -10, y: 20),
                CGPoint(x: 10, y: 20),
                CGPoint(x: 10, y: 10)
            ]
        ),
        // 25
        .init(
            name: "Test 25",
            pA: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: -10, y: 10)
            ],
            pB: [
                CGPoint(x: -5, y: -10),
                CGPoint(x: -5, y: 10),
                CGPoint(x: 5, y: 10),
                CGPoint(x: 5, y: -10)
            ]
        ),
        // 26
        .init(
            name: "Test 26",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: -20, y: 0),
                CGPoint(x: -20, y: 10),
                CGPoint(x: -10, y: 10),
                CGPoint(x: -10, y: 0)
            ]
        ),
        // 27
        .init(
            name: "Test 27",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: 0),
                CGPoint(x: -10, y: 0)
            ],
            pB: [
                CGPoint(x: 10.0 - FixFloat(1).double, y:  30),
                CGPoint(x: 10.0 + FixFloat(1).double, y: -30),
                CGPoint(x: -15, y: -30),
                CGPoint(x: -15, y: 30)
            ]
        ),
        // 28
        .init(
            name: "Test 28",
            pA: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: -10, y: 10)
            ],
            pB: [
                CGPoint(x: 10 - FixFloat(1).double, y: 30),
                CGPoint(x: 10 + FixFloat(1).double, y: -30),
                CGPoint(x: -15, y: -30),
                CGPoint(x: -15, y: 30)
            ]
        ),
        // 29
        .init(
            name: "Test 29",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ],
            pB: [
                CGPoint(x: 10, y: -5),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: 5),
                CGPoint(x: 20, y: 5),
                CGPoint(x: 20, y: -5)
            ]
        ),
        // 30
        .init(
            name: "Test 30",
            pA: [
                CGPoint(x: 20, y: -5),
                CGPoint(x: 20, y: 5),
                CGPoint(x: 10, y: 5),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: -5)
            ],
            pB: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: -10, y: 10)
            ]
        ),
        // 31
        .init(
            name: "Test 31",
            pA: [
                CGPoint(x: 20, y: -5),
                CGPoint(x: 20, y: 5),
                CGPoint(x: 10, y: 5),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: -5)
            ],
            pB: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: 10),
                CGPoint(x: -10, y: 10)
            ]
        ),
        // 27
        .init(
            name: "Test 32",
            pA: [
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: 1),
                CGPoint(x: -10, y: 0)
            ],
            pB: [
                CGPoint(x: 10.0 - FixFloat(1).double, y:  30),
                CGPoint(x: 10.0 + FixFloat(1).double, y: -30),
                CGPoint(x: -15, y: -30),
                CGPoint(x: -15, y: 30)
            ]
        )
    ]

}
