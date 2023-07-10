//
//  DegenerateTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.07.2023.
//

import iDebug
import CoreGraphics

struct DegenerateTest {
    let name: String
    let path: [CGPoint]
}

final class DegenerateTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: DegenerateTestStore.self), nilValue: 0)
    
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
    
    var test: DegenerateTest {
        data[testId]
    }
    
    let data: [DegenerateTest] = [
        .init(
            name: "Square",
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
            name: "Same dots 1",
            path: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -10)
            ]),
        .init(
            name: "Same dots 2",
            path: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -10)
            ]),
        .init(
            name: "Test 1",
            path: [
                CGPoint(x: -10, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -10, y:  10),
                CGPoint(x:   0, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y: -10),
                CGPoint(x: -10, y:  -5)
            ])
    ]
    
}
