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
            name: "Doc",
            subjPaths: [
                [
                    CGPoint(x: -20, y: -16),
                    CGPoint(x: -20, y:  16),
                    CGPoint(x:  20, y:  16),
                    CGPoint(x:  20, y: -16)
                ],
                [
                    CGPoint(x: -12, y: -8),
                    CGPoint(x: -12, y:  8),
                    CGPoint(x:  12, y:  8),
                    CGPoint(x:  12, y: -8)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -4, y: -24),
                    CGPoint(x: -4, y:  24),
                    CGPoint(x:  4, y:  24),
                    CGPoint(x:  4, y: -24)
                ]
            ]
        ),
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
            name: "Polygon With a Hole 0",
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
            name: "Polygon With a Hole 1",
            subjPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ],
                [
                    CGPoint(x: -5, y: -5),
                    CGPoint(x: -5, y:  5),
                    CGPoint(x:  5, y:  5),
                    CGPoint(x:  5, y: -5)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -15, y: -15),
                    CGPoint(x: -15, y:  15),
                    CGPoint(x:  15, y:  15),
                    CGPoint(x:  15, y: -15)
                ]
            ]),
        .init(
            name: "Polygon With a Hole 2",
            subjPaths: [
                [
                    CGPoint(x: -15, y: -15),
                    CGPoint(x: -15, y:  15),
                    CGPoint(x:  15, y:  15),
                    CGPoint(x:  15, y: -15)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ],
                [
                    CGPoint(x: -5, y: -5),
                    CGPoint(x: -5, y:  5),
                    CGPoint(x:  5, y:  5),
                    CGPoint(x:  5, y: -5)
                ]
            ]),
        .init(
            name: "Many Holes in Subject",
            subjPaths: [
                [
                    CGPoint(x: -20, y: -20),
                    CGPoint(x: -20, y: 20),
                    CGPoint(x: 20, y: 20),
                    CGPoint(x: 20, y: -20)
                ],
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y: 0),
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: 0, y: -10)
                ],
                [
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: 0, y: 10),
                    CGPoint(x: 10, y: 10),
                    CGPoint(x: 10, y: 0)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -5, y: -5),
                    CGPoint(x: -5, y: 5),
                    CGPoint(x: 5, y: 5),
                    CGPoint(x: 5, y: -5)
                ]
            ]
        ),
        .init(
            name: "Intersecting Holes in Subject and Clip",
            subjPaths: [
                [
                    CGPoint(x: -20, y: -20),
                    CGPoint(x: -20, y: 20),
                    CGPoint(x: 20, y: 20),
                    CGPoint(x: 20, y: -20)
                ],
                [
                    CGPoint(x: -10, y: 10),
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: 10, y: -10),
                    CGPoint(x: 10, y: 10)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -15, y: -15),
                    CGPoint(x: -15, y: 15),
                    CGPoint(x: 15, y: 15),
                    CGPoint(x: 15, y: -15)
                ],
                [
                    CGPoint(x: -5, y: 5),
                    CGPoint(x: -5, y: -5),
                    CGPoint(x: 5, y: -5),
                    CGPoint(x: 5, y: 5)
                ]
            ]
        ),
        .init(
            name: "Nested Holes",
            subjPaths: [
                [
                    CGPoint(x: -30, y: -30),
                    CGPoint(x: -30, y: 30),
                    CGPoint(x: 30, y: 30),
                    CGPoint(x: 30, y: -30)
                ],
                [
                    CGPoint(x: -20, y: -20),
                    CGPoint(x: -20, y: 20),
                    CGPoint(x: 20, y: 20),
                    CGPoint(x: 20, y: -20)
                ],
                [
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: 0, y: 10),
                    CGPoint(x: 10, y: 10),
                    CGPoint(x: 10, y: 0)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -5, y: -5),
                    CGPoint(x: -5, y: 5),
                    CGPoint(x: 5, y: 5),
                    CGPoint(x: 5, y: -5)
                ]
            ]
        ),
        .init(
            name: "Intersecting Holes",
            subjPaths: [
                [
                    CGPoint(x: -20, y: -20),
                    CGPoint(x: -20, y: 20),
                    CGPoint(x: 20, y: 20),
                    CGPoint(x: 20, y: -20)
                ],
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y: 0),
                    CGPoint(x: 0, y: 0),
                    CGPoint(x: 0, y: -10)
                ],
                [
                    CGPoint(x: 0, y: -10),
                    CGPoint(x: 0, y: 10),
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
            ]
        ),
        .init(
            name: "Multiple Non-Intersecting Holes",
            subjPaths: [
                [
                    CGPoint(x: -30, y: -30),
                    CGPoint(x: -30, y: 30),
                    CGPoint(x: 30, y: 30),
                    CGPoint(x: 30, y: -30)
                ],
                [
                    CGPoint(x: -15, y: -15),
                    CGPoint(x: -15, y: -5),
                    CGPoint(x: -5, y: -5),
                    CGPoint(x: -5, y: -15)
                ],
                [
                    CGPoint(x: 5, y: 5),
                    CGPoint(x: 5, y: 15),
                    CGPoint(x: 15, y: 15),
                    CGPoint(x: 15, y: 5)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y: 10),
                    CGPoint(x: 10, y: 10),
                    CGPoint(x: 10, y: -10)
                ]
            ]
        ),
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
            name: "Disjoint Polygons",
            subjPaths: [[CGPoint(x: -20, y: -20), CGPoint(x: -20, y: 20), CGPoint(x: -10, y: 20), CGPoint(x: -10, y: -20)]],
            clipPaths: [[CGPoint(x: 10, y: -20), CGPoint(x: 10, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: -20)]]
        ),
        .init(
            name: "Nested Polygons",
            subjPaths: [[CGPoint(x: -15, y: -15), CGPoint(x: -15, y: 15), CGPoint(x: 15, y: 15), CGPoint(x: 15, y: -15)]],
            clipPaths: [[CGPoint(x: -10, y: -10), CGPoint(x: -10, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: -10)]]
        ),
        .init(
            name: "Touching Polygons",
            subjPaths: [[CGPoint(x: -10, y: -10), CGPoint(x: -10, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: -10)]],
            clipPaths: [[CGPoint(x: 10, y: -10), CGPoint(x: 10, y: 10), CGPoint(x: 30, y: 10), CGPoint(x: 30, y: -10)]]
        ),
        .init(
            name: "Overlapping Polygons with Holes",
            subjPaths: [
                [CGPoint(x: -15, y: -15), CGPoint(x: -15, y: 15), CGPoint(x: 15, y: 15), CGPoint(x: 15, y: -15)],
                [CGPoint(x: -5, y: -5), CGPoint(x: -5, y: 5), CGPoint(x: 5, y: 5), CGPoint(x: 5, y: -5)]
            ],
            clipPaths: [
                [CGPoint(x: -10, y: -10), CGPoint(x: -10, y: 10), CGPoint(x: 20, y: 10), CGPoint(x: 20, y: -10)],
                [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: 0)]
            ]
        ),
        .init(
            name: "Multiple Overlapping Polygons",
            subjPaths: [[CGPoint(x: -20, y: -20), CGPoint(x: -20, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: -20)]],
            clipPaths: [
                [CGPoint(x: -10, y: -10), CGPoint(x: -10, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 10, y: -10)],
                [CGPoint(x: -5, y: -5), CGPoint(x: -5, y: 5), CGPoint(x: 15, y: 5), CGPoint(x: 15, y: -5)]
            ]
        ),
        .init(
            name: "C + I Polygons Creating a Hole",
            subjPaths: [
                [
                    CGPoint(x:   5, y:   5),
                    CGPoint(x:   5, y:  10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x: -10, y: -10),
                    CGPoint(x:   5, y: -10),
                    CGPoint(x:   5, y:  -5),
                    CGPoint(x:  -5, y:  -5),
                    CGPoint(x:  -5, y:   5)
                ]
            ],
            clipPaths: [
                [
                    CGPoint(x:   5, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10),
                    CGPoint(x:   5, y: -10)
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
        ),
        .init(
            name: "Stars crash 0",
            subjPaths: [[
                CGPoint(x: -4.6523414908376743, y: 16.351015829379847),
                CGPoint(x: -0.891484448293693, y: 1.7903227302501887),
                CGPoint(x: -10.244847443969478, y: 13.566248591625913),
                CGPoint(x: -1.4780236570680427, y: 1.3473849001481384),
                CGPoint(x: -14.453729981133797, y: 8.9492843083943878),
                CGPoint(x: -1.864947580943541, y: 0.72247527316361126),
                CGPoint(x: -16.71055619346334, y: 3.123669589617958),
                CGPoint(x: -1.9999999999813254, y: -0.0000086428353511304817),
                CGPoint(x: -16.710529195477257, y: -3.1238140160870955),
                CGPoint(x: -1.8649413366390553, y: -0.72249139157150777),
                CGPoint(x:  -14.453652633403172, y: -8.9494092292685749),
                CGPoint(x:  -1.478012011786993, y: -1.3473976744129275),
                CGPoint(x:  -10.244730192733932, y: -13.566337135648876),
                CGPoint(x:  -0.8914689747958131, y: -1.7903304351366265),
                CGPoint(x:  -4.6522001715262657, y: -16.351056038190652),
                CGPoint(x:  -0.1845281129583404, y: -1.9914691500317132),
                CGPoint(x:  1.5686352615770882, y: -16.927474218445496),
                CGPoint(x:  0.54733429303972825, y: -1.9236489211035108),
                CGPoint(x:  7.5776178104964096, y: -15.217743207126595),
                CGPoint(x:  1.2052761698787648, y: -1.5960292460736347),
                CGPoint(x:  12.563201085078388, y: -11.45277165125915),
                CGPoint(x:  1.7004388213098611, y: -1.0528569774581591),
                CGPoint(x:  15.852054438020117, y: -6.141039821890649),
                CGPoint(x:  1.9659477874662765, y: -0.36749053995504716),
                CGPoint(x:  16.999999999841265, y: 0.000073464100550472842),
                CGPoint(x:  1.9659446112326169, y: 0.36750753130437269),
                CGPoint(x:  15.852001361431942, y: 6.1411768283578914),
                CGPoint(x:  1.7004297215768382, y: 1.052871674031606),
                CGPoint(x:  12.563102100189377, y: 11.452880232509955),
                CGPoint(x:  1.205262375615747, y: 1.5960396630175222),
                CGPoint(x:  7.5774862857643193, y: 15.21780869866137),
                CGPoint(x:  0.5473176672383725, y: 1.9236536515518448),
                CGPoint(x:  1.5684889601457903, y: 16.927487775269572),
                CGPoint(x:  -0.18454532489143427, y: 1.9914675551112337)
            ]],
            clipPaths: [[
                CGPoint(x: 17,                 y: 0),
                CGPoint(x: 1.9659461993678036, y: 0.36749903563314068),
                CGPoint(x: 15.852027899874049, y: 6.1411083251815999),
                CGPoint(x: 1.7004342714592284, y: 1.0528643257547114),
                CGPoint(x: 12.563151592751204, y: 11.452825941991472),
                CGPoint(x: 1.2052692727585128, y: 1.596034454560479),
                CGPoint(x: 7.5775520482011513, y: 15.21777595303606),
                CGPoint(x: 0.547325980144166, y: 1.9236512863456381),
                CGPoint(x: 1.5685621108761378, y: 16.927480997015586),
                CGPoint(x: -0.18453671892660337, y: 1.9914683525900692),
                CGPoint(x: -4.652270831225402, y: 16.351035933937926),
                CGPoint(x: -0.89147671155307562, y: 1.7903265827101251),
                CGPoint(x: -10.244788818447349, y: 13.566292863764078),
                CGPoint(x: -1.4780178344413173, y: 1.3473912872931153),
                CGPoint(x: -14.453691307403433, y: 8.9493467689150581),
                CGPoint(x: -1.864944458808711, y: 0.7224833323743074),
                CGPoint(x: -16.710542694626326, y: 3.1237418028817108),
                CGPoint(x: -2,                  y: 2.0212861992297212E-15),
                CGPoint(x: -16.710542694626334, y: -3.1237418028816775),
                CGPoint(x: -1.8649444588087125, y: -0.72248333237430373),
                CGPoint(x: -14.453691307403451, y: -8.9493467689150297),
                CGPoint(x: -1.4780178344413202, y: -1.3473912872931124),
                CGPoint(x: -10.244788818447372, y: -13.56629286376406),
                CGPoint(x: -0.89147671155307762, y: -1.790326582710124),
                CGPoint(x: -4.6522708312254126, y: -16.351035933937922),
                CGPoint(x: -0.18453671892660381, y: -1.9914683525900692),
                CGPoint(x: 1.5685621108761414, y: -16.927480997015586),
                CGPoint(x: 0.54732598014416733, y: -1.9236512863456376),
                CGPoint(x: 7.5775520482011682, y: -15.21777595303605),
                CGPoint(x: 1.205269272758515, y: -1.5960344545604772),
                CGPoint(x: 12.563151592751227, y: -11.452825941991449),
                CGPoint(x: 1.7004342714592307, y: -1.0528643257547077),
                CGPoint(x: 15.852027899874065, y: -6.141108325181559),
                CGPoint(x: 1.9659461993678047, y: -0.36749903563313485)
            ]]
        ),
        .init(
            name: "Stars crash 1",
            subjPaths: [[

                CGPoint(x: -30, y: -20),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  30, y: -20),
                CGPoint(x:  15, y:  30)
            ]],
            clipPaths: [[

                CGPoint(x:  30, y: -40),
                CGPoint(x:  -5, y:   0),
                CGPoint(x: -30, y: -20),

                CGPoint(x:  15, y: -40),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  30, y: -20)
            ]]
        ),
        .init(
            name: "Stars crash custom",
            subjPaths: [[
                CGPoint(x:   0, y: -2),
                CGPoint(x: -20, y:  0),
                CGPoint(x:  7.5776178104964096, y: -15.217743207126595)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: -2),
                CGPoint(x: 7.5775520482011682, y: -15.21777595303605),
                CGPoint(x: 1, y: -2),
            ]]
        ),
        .init(
            name: "Stars crash custom clean",
            subjPaths: [[
                CGPoint(x:   0, y: 0),
                CGPoint(x: -20, y:  0),
                CGPoint(x: 7.57761781049641, y: -15.217743207126595)
            ]],
            clipPaths: [[
                CGPoint(x: 0, y: 0),
                CGPoint(x: 7.577552048201168, y: -15.21777595303605),
                CGPoint(x: 5, y: 5)
            ]]
        ),
        .init(
            name: "Cheese 1",
            subjPaths: [
                [
                    FixVec(0, 20480),
                    FixVec(8192, 10240),
                    FixVec(7168, 6144),
                    FixVec(9216, 1024),
                    FixVec(13312, -1024),
                    FixVec(17408, 1024),
                    FixVec(26624, -7168),
                    FixVec(14336, -15360),
                    FixVec(0, -18432),
                    FixVec(-14336, -15360),
                    FixVec(-25600, -7168),
                    FixVec(-18432, 0),
                    FixVec(-16384, -3072),
                    FixVec(-13312, -4096),
                    FixVec(-8192, -2048),
                    FixVec(-6144, 2048),
                    FixVec(-7168, 6144),
                    FixVec(-10240, 8192),
                ].map({ $0.cgPoint }),
                [
                    FixVec(2048, 0),
                    FixVec(-2048, -2048),
                    FixVec(-4096, -5120),
                    FixVec(9216, 1024),
                    FixVec(2048, -11264),
                    FixVec(5120, -9216),
                    FixVec(7168, -5120),
                    FixVec(5120, -2048)
                ].map({ $0.cgPoint })
            ],
            clipPaths: [
                []
            ]
        ),
        .init(
            name: "Cheese 2",
            subjPaths: [
                [
                    FixVec(0, 20480),
                    FixVec(9216, 1024),
                    FixVec(26624, -7168),
                    FixVec(14336, -15360),
                    FixVec(-14336, -15360),
                    FixVec(-25600, -7168),
                ].map({ $0.cgPoint }),
                [
                    FixVec(-2048, -2048),
                    FixVec(-4096, -5120),
                    FixVec(9216, 1024),
                    FixVec(2048, -11264),
                    FixVec(5120, -9216),
                ].map({ $0.cgPoint })
            ],
            clipPaths: [
                []
            ]
        ),
    ]
    
}
