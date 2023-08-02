//
//  TwoSplitTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.07.2023.
//

import iDebug
import iFixFloat
import CoreGraphics

struct TwoTest {
    let name: String
    let subjPaths: [[CGPoint]]
    let clipPaths: [[CGPoint]]
}

final class TwoTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: TwoTestStore.self), nilValue: 0)
    
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
    
    var test: TwoTest {
        data[testId]
    }
    
    let data: [TwoTest] = [
        .init(
            name: "Square",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -5, y: -5),
                    CGPoint(x: -5, y:  5),
                    CGPoint(x:  5, y:  5),
                    CGPoint(x:  5, y: -5)
                ]
            ]
        ),
        .init(
            name: "2 Squares",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x:   0, y: -10),
                    CGPoint(x:   0, y:  10),
                    CGPoint(x:  20, y:  10),
                    CGPoint(x:  20, y: -10)
                ]
            ]),
        .init(
            name: "2 Squares",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x:  -5, y:  -5),
                    CGPoint(x:  -5, y:  15),
                    CGPoint(x:  15, y:  15),
                    CGPoint(x:  15, y:  -5)
                ]
            ]),
        .init(
            name: "Test 1",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x:   5, y: -15),
                    CGPoint(x: -25, y:  15),
                    CGPoint(x:  15, y:  15),
                    CGPoint(x:  15, y: -15)
                ]
            ]),
        .init(
            name: "Test 2",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x:  -5, y: -6),
                    CGPoint(x: -25, y:  15),
                    CGPoint(x:  15, y:  15),
                    CGPoint(x:   9, y:   5)
                ]
            ]),
        .init(
            name: "Test 3",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x:   5, y: -15),
                    CGPoint(x:   5, y:  15),
                    CGPoint(x:  15, y:  15),
                    CGPoint(x:  15, y: -15)
                ]
            ]),
        .init(
            name: "Polygon Inside Polygon",
            subjPaths: [
                [
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: 0, y: 5),
                    CGPoint(x: 5, y: 5),
                    CGPoint(x: 5, y: 0)]
            ],
            clipPaths: [
                [
                    CGPoint(x: -5, y: -5),
                    CGPoint(x: -5, y: 10),
                    CGPoint(x: 10, y: 10),
                    CGPoint(x: 10, y: -5)
                ]
            ]),
        .init(
            name: "Polygon Outside Polygon",
            subjPaths: [
                [
                    CGPoint(x: -20, y: -20),
                    CGPoint(x: -20, y: -10),
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y: -20)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: 10, y: 10),
                    CGPoint(x: 10, y: 20),
                    CGPoint(x: 20, y: 20),
                    CGPoint(x: 20, y: 10)
                ]
            ]),
        .init(
            name: "Coinciding Edges",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: 10, y: -10),
                    CGPoint(x: 10, y:  10),
                    CGPoint(x: 20, y:  10),
                    CGPoint(x: 20, y: -10)
                ]
            ]),
        .init(
            name: "Touching at a Point",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: 10, y: 10),
                    CGPoint(x: 10, y: 20),
                    CGPoint(x: 20, y: 20),
                    CGPoint(x: 20, y: 10)
                ]
            ]),
        .init(
            name: "Intersection Forms a Line",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: 0, y: -10),
                    CGPoint(x: 0, y: 20),
                    CGPoint(x: 10, y: 20),
                    CGPoint(x: 10, y: -10)
                ]
            ]),
        .init(
            name: "Polygon With a Hole",
            subjPaths: [
                [
                    CGPoint(x: -20, y: -20),
                    CGPoint(x: -20, y: 20),
                    CGPoint(x: 20, y: 20),
                    CGPoint(x: 20, y: -20)
                ],
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y: 10),
                    CGPoint(x: 10, y: 10),
                    CGPoint(x: 10, y: -10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -5, y: -5),
                    CGPoint(x: -5, y: 5),
                    CGPoint(x: 5, y: 5),
                    CGPoint(x: 5, y: -5)
                ]
            ]),
        .init(
            name: "Close Intersections",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x:  10, y:  10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -10, y: 10),
                    CGPoint(x:  10, y: -10.0001) // Adjust this value as needed
                ]
            ]
        ),
        .init(
            name: "Off-Line Intersections",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x:  10, y:  10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -10, y: 10),
                    CGPoint(x:  10, y: -10)
                ]
            ]
        ),
        .init(
            name: "Parallel Lines",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x:  10, y:  10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -10, y: -9.999),  // Adjust these values as needed
                    CGPoint(x:  10, y:  10.001)  // Adjust these values as needed
                ]
            ]
        ),
        .init(
            name: "Coincident Lines",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x:  10, y:  10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x:  10, y:  10)
                ]
            ]
        ),
        .init(
            name: "Lines with Common Endpoint",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x:  10, y:  10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  20, y:  20)
                ]
            ]
        ),
        .init(
            name: "Two Rect 1",
            subjPaths: [[
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x:   0, y: -5),
                CGPoint(x:   0, y:  5),
                CGPoint(x:  20, y:  5),
                CGPoint(x:  20, y: -5)
            ]]
        ),
        .init(
            name: "Two Rect 2",
            subjPaths: [[
                CGPoint(x: -5, y: -10),
                CGPoint(x: -5, y:  10),
                CGPoint(x:  15, y:  10),
                CGPoint(x:  15, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: -10, y: -5),
                CGPoint(x: -10, y:  15),
                CGPoint(x:  10, y:  15),
                CGPoint(x:  10, y: -5)
            ]]
        ),
        .init(
            name: "Two Rect 3",
            subjPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]],
            clipPaths: [[
                CGPoint(x: -5.0, y: -20.0),
                CGPoint(x: -5.0, y: 20.0),
                CGPoint(x: 5.0, y: 20.0),
                CGPoint(x: 5.0, y: -20.0)
            ]]
        ),
        .init(
            name: "Two Rect 4",
            subjPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]],
            clipPaths: [[
                CGPoint(x:  0.0, y:-15.0),
                CGPoint(x:-15.0, y:  0.0),
                CGPoint(x:  0.0, y: 15.0),
                CGPoint(x: 15.0, y:   0.0)
            ]]
        ),
        .init(
            name: "Two Rect 5",
            subjPaths: [[
                CGPoint(x:  0.0, y:-15.0),
                CGPoint(x:-15.0, y:  0.0),
                CGPoint(x:  0.0, y: 15.0),
                CGPoint(x: 15.0, y:   0.0)
            ]],
            clipPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]]
        ),
        .init(
            name: "Two Rect 6",
            subjPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]],
            clipPaths: [[
                CGPoint(x:  0.0, y:-20.0),
                CGPoint(x:-20.0, y:  0.0),
                CGPoint(x:  0.0, y: 20.0),
                CGPoint(x: 20.0, y:   0.0)
            ]]
        ),
        .init(
            name: "Two Rect 7",
            subjPaths: [[
                CGPoint(x:  0.0, y:-20.0),
                CGPoint(x:-20.0, y:  0.0),
                CGPoint(x:  0.0, y: 20.0),
                CGPoint(x: 20.0, y:   0.0)
            ]],
            clipPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]]
        ),
        .init(
            name: "Two Rect 8",
            subjPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]],
            clipPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]]
        ),
        .init(
            name: "Two Rect 9",
            subjPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]],
            clipPaths: [[
                CGPoint(x: -20.0, y: -10.0),
                CGPoint(x: -20.0, y:   0.0),
                CGPoint(x:  10.0, y:   0.0),
                CGPoint(x:  10.0, y: -10.0)
            ]]
        ),
        .init(
            name: "Two Rect 11",
            subjPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -10.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y: -10.0)
            ]],
            clipPaths: [[
                CGPoint(x: -10.0, y: -10.0),
                CGPoint(x: -5.0, y: 10.0),
                CGPoint(x: 5.0, y: 10.0),
                CGPoint(x: 5.0, y: -20.0)
            ]]
        ),
        .init(
            name: "Two Rect 12",
            subjPaths: [[
                CGPoint(x:  0.0, y:   0.0),
                CGPoint(x:  0.0, y:  20.0),
                CGPoint(x: 20.0, y:  20.0),
                CGPoint(x: 20.0, y:   0.0)
            ]],
            clipPaths: [[
                CGPoint(x:  0.0, y:  0.0),
                CGPoint(x:  0.0, y: 10.0),
                CGPoint(x: 10.0, y: 10.0),
                CGPoint(x: 10.0, y:  0.0)
            ]]
        ),
        .init(
            name: "Two Rect 13",
            subjPaths: [[
                CGPoint(x:  0.0, y:   0.0),
                CGPoint(x:  0.0, y:  20.0),
                CGPoint(x: 20.0, y:  20.0),
                CGPoint(x: 20.0, y:   0.0)
            ]],
            clipPaths: [[
                CGPoint(x:  0.0, y: 10.0),
                CGPoint(x:  0.0, y: 20.0),
                CGPoint(x: 10.0, y: 20.0),
                CGPoint(x: 10.0, y: 10.0)
            ]]
        ),
        .init(
            name: "Concave 0",
            subjPaths: [[
                CGPoint(x: -25.0, y:  -5.0),
                CGPoint(x: -25.0, y:   5.0),
                CGPoint(x: -12.0, y:   5.0),
                CGPoint(x:  -8.0, y:  10.0),
                CGPoint(x:  -8.0, y:   5.0),
                CGPoint(x:  25.0, y:   5.0),
                CGPoint(x:  25.0, y:  -5.0)
            ]],
            clipPaths: [[
                CGPoint(x: -15.0, y:  0.0),
                CGPoint(x: -15.0, y: 20.0),
                CGPoint(x:  15.0, y: 20.0),
                CGPoint(x:  15.0, y:  0.0),
                CGPoint(x:   5.0, y:  0.0),
                CGPoint(x:   5.0, y: 10.0),
                CGPoint(x:  -5.0, y: 10.0),
                CGPoint(x:  -5.0, y:  0.0)
            ]]
        ),
        .init(
            name: "Concave 1",
            subjPaths: [[
                CGPoint(x: -25.0, y:  -5.0),
                CGPoint(x: -25.0, y:   5.0),
                CGPoint(x:  25.0, y:   5.0),
                CGPoint(x:  25.0, y:  -5.0)
            ]],
            clipPaths: [[
                CGPoint(x: -15.0, y:  0.0),
                CGPoint(x: -15.0, y: 20.0),
                CGPoint(x:  15.0, y: 20.0),
                CGPoint(x:  15.0, y:  0.0),
                CGPoint(x:   5.0, y:  0.0),
                CGPoint(x:   5.0, y: 10.0),
                CGPoint(x:  -5.0, y: 10.0),
                CGPoint(x:  -5.0, y:  0.0)
            ]]
        ),
        .init(
            name: "Concave 2",
            subjPaths: [[
                CGPoint(x: -25.0, y:  -5.0),
                CGPoint(x: -25.0, y:   5.0),
                CGPoint(x:  25.0, y:   5.0),
                CGPoint(x:  25.0, y:  -5.0)
            ]],
            clipPaths: [[
                CGPoint(x: -15.0, y: -10.0),
                CGPoint(x: -15.0, y:  20.0),
                CGPoint(x:  15.0, y:  20.0),
                CGPoint(x:  15.0, y: -10.0),
                CGPoint(x:   5.0, y: -10.0),
                CGPoint(x:   5.0, y:  10.0),
                CGPoint(x:  -5.0, y:  10.0),
                CGPoint(x:  -5.0, y: -10.0)

            ]]
        ),
        .init(
            name: "Concave 3",
            subjPaths: [[
                CGPoint(x: -10.0, y: -15.0),
                CGPoint(x: -10.0, y:  15.0),
                CGPoint(x:  10.0, y:  15.0),
                CGPoint(x:  10.0, y: -15.0),
                CGPoint(x:   5.0, y: -15.0),
                CGPoint(x:   5.0, y:  10.0),
                CGPoint(x:  -5.0, y:  10.0),
                CGPoint(x:  -5.0, y: -15.0)

            ]],
            clipPaths: [[
                CGPoint(x: -20.0, y:  -5.0),
                CGPoint(x: -20.0, y:   5.0),
                CGPoint(x:  20.0, y:   5.0),
                CGPoint(x:  20.0, y:  -5.0)
            ]]
        ),
        .init(
            name: "Test 0",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 0),
                CGPoint(x: -5, y: 10),
                CGPoint(x: 5, y: 10)
            ]]
        ),
        // 1
        .init(
            name: "Test 1",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 0),
                CGPoint(x: -10, y: -5),
                CGPoint(x: -10, y: 5)
            ]]
        ),
        // 2
        .init(
            name: "Test 2",
                subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 0),
                CGPoint(x: 5, y: -10),
                CGPoint(x: -5, y: -10)
            ]]
        ),
        // 3
        .init(
            name: "Test 3",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 0),
                CGPoint(x: 10, y: 5),
                CGPoint(x: 10, y: -5)
            ]]
        ),
        // 4
        .init(
            name: "Test 4",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 0),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10)
            ]]
        ),
        // 5
        .init(
            name: "Test 5",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 0),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 10)
            ]]
        ),
        // 6
        .init(
            name: "Test 6",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 0),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]]
        ),
        // 7
        .init(
            name: "Test 7",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 0),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10)
            ]]
        ),
        // 8
        .init(
            name: "Test 8",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: -10, y: 5),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: 5)
            ]]
        ),
        // 9
        .init(
            name: "Test 9",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: -5, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 10),
                CGPoint(x: -5, y: 10)
            ]]
        ),
        // 10
        .init(
            name: "Test 10",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 10, y: -5),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: -5)
            ]]
        ),
        // 11
        .init(
            name: "Test 11",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 5, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 5, y: -10)
            ]]
        ),
        // 12
        .init(
            name: "Test 12",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 10, y: 0),
                CGPoint(x: 0, y: 10),
                CGPoint(x: 10, y: 10)
            ]]
        ),
        // 13
        .init(
            name: "Test 13",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 10),
                CGPoint(x: -10, y: 0),
                CGPoint(x: -10, y: 10)
            ]]
        ),
        // 14
        .init(
            name: "Test 14",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: -10, y: 0),
                CGPoint(x: 0, y: -10),
                CGPoint(x: -10, y: -10)
            ]]
        ),
        // 15
        .init(
            name: "Test 15",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: -10),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: -10)
            ]]
        ),
        // 16
        .init(
            name: "Test 16",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 0, y: 10)
            ]]
        ),
        // 17
        .init(
            name: "Test 17",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 0)
            ]]
        ),
        // 18
        .init(
            name: "Test 18",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: -10, y: 0),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 0, y: -10)
            ]]
        ),
        // 19
        .init(
            name: "Test 19",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: 0)
            ]]
        ),
        // 20
        .init(
            name: "Test 20",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: -15, y: 10),
                CGPoint(x: -15, y: 20),
                CGPoint(x: -5, y: 20),
                CGPoint(x: -5, y: 10)
            ]]
        ),
        // 21
        .init(
            name: "Test 21",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: -15, y: 0),
                CGPoint(x: -15, y: 10),
                CGPoint(x: -5, y: 10),
                CGPoint(x: -5, y: 0)
            ]]
        ),
        // 22
        .init(
            name: "Test 22",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 5, y: 10),
                CGPoint(x: 5, y: 20),
                CGPoint(x: 15, y: 20),
                CGPoint(x: 15, y: 10)
            ]]
        ),
        // 23
        .init(
            name: "Test 23",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 5, y: 0),
                CGPoint(x: 5, y: 10),
                CGPoint(x: 15, y: 10),
                CGPoint(x: 15, y: 0)
            ]]
        ),
        // 24
        .init(
            name: "Test 24",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: -10, y: 20),
                CGPoint(x: 10, y: 20),
                CGPoint(x: 10, y: 10)
            ]]
        ),
        // 25
        .init(
            name: "Test 25",
            subjPaths: [[
                CGPoint(x: -10, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: -10, y: 10)
            ]],
            clipPaths: [[
                CGPoint(x: -5, y: -10),
                CGPoint(x: -5, y: 10),
                CGPoint(x: 5, y: 10),
                CGPoint(x: 5, y: -10)
            ]]
        ),
        // 26
        .init(
            name: "Test 26",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: -20, y: 0),
                CGPoint(x: -20, y: 10),
                CGPoint(x: -10, y: 10),
                CGPoint(x: -10, y: 0)
            ]]
        ),
        // 27
        .init(
            name: "Test 27",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: 0),
                CGPoint(x: -10, y: 0)
            ]],
            clipPaths: [[
                CGPoint(x: 10.0 - FixFloat(1).double, y:  30),
                CGPoint(x: 10.0 + FixFloat(1).double, y: -30),
                CGPoint(x: -15, y: -30),
                CGPoint(x: -15, y: 30)
            ]]
        ),
        // 28
        .init(
            name: "Test 28",
            subjPaths: [[
                CGPoint(x: -10, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: -10, y: 10)
            ]],
            clipPaths: [[
                CGPoint(x: 10 - FixFloat(1).double, y: 30),
                CGPoint(x: 10 + FixFloat(1).double, y: -30),
                CGPoint(x: -15, y: -30),
                CGPoint(x: -15, y: 30)
            ]]
        ),
        // 29
        .init(
            name: "Test 29",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: -10, y: -10)
            ]],
            clipPaths: [[
                CGPoint(x: 10, y: -5),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: 5),
                CGPoint(x: 20, y: 5),
                CGPoint(x: 20, y: -5)
            ]]
        ),
        // 30
        .init(
            name: "Test 30",
            subjPaths: [[
                CGPoint(x: 20, y: -5),
                CGPoint(x: 20, y: 5),
                CGPoint(x: 10, y: 5),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: -5)
            ]],
            clipPaths: [[
                CGPoint(x: -10, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: -10, y: 10)
            ]]
        ),
        // 31
        .init(
            name: "Test 31",
            subjPaths: [[
                CGPoint(x: 20, y: -5),
                CGPoint(x: 20, y: 5),
                CGPoint(x: 10, y: 5),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: -5)
            ]],
            clipPaths: [[
                CGPoint(x: -10, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: 0),
                CGPoint(x: 10, y: 10),
                CGPoint(x: -10, y: 10)
            ]]
        ),
        // 27
        .init(
            name: "Test 32",
            subjPaths: [[
                CGPoint(x: -10, y: 10),
                CGPoint(x: 10, y: 10),
                CGPoint(x: 10, y: 1),
                CGPoint(x: -10, y: 0)
            ]],
            clipPaths: [[
                CGPoint(x: 10.0 - FixFloat(1).double, y:  30),
                CGPoint(x: 10.0 + FixFloat(1).double, y: -30),
                CGPoint(x: -15, y: -30),
                CGPoint(x: -15, y: 30)
            ]]
        )
    ]
    
}
