//
//  ComplexTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.07.2023.
//

import iDebug
import CoreGraphics

struct ComplexTest {
    let name: String
    let paths: [[CGPoint]]
}

final class ComplexTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: ComplexTestStore.self), nilValue: 0)
    
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
    
    var test: ComplexTest {
        data[testId]
    }
    
    let data: [ComplexTest] = [
        .init(
            name: "Square",
            paths: [
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
            name: "2 Squares",
            paths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ],
                [
                    CGPoint(x:   0, y: -10),
                    CGPoint(x:   0, y:  10),
                    CGPoint(x:  20, y:  10),
                    CGPoint(x:  20, y: -10)
                ]
            ]),
        .init(
            name: "2 Squares",
            paths: [
                [
                    CGPoint(x: -10, y: -10),
                    CGPoint(x: -10, y:  10),
                    CGPoint(x:  10, y:  10),
                    CGPoint(x:  10, y: -10)
                ],
                [
                    CGPoint(x:  -5, y:  -5),
                    CGPoint(x:  -5, y:  15),
                    CGPoint(x:  15, y:  15),
                    CGPoint(x:  15, y:  -5)
                ]
            ])
    ]
    
}
