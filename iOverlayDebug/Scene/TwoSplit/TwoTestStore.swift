//
//  TwoSplitTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.07.2023.
//

import iDebug
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
            ])
    ]
    
}
