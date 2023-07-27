//
//  AngleClockWiseTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 26.07.2023.
//

import iDebug
import CoreGraphics

struct AngleClockWiseTest {
    let name: String
    let path: [CGPoint]
}

final class AngleClockWiseTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: AngleClockWiseTestStore.self), nilValue: 0)
    
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
            name: "Test 1",
            path: [
                CGPoint(x:   0, y:   0),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10)
            ]),
        .init(
            name: "Test 2",
            path: [
                CGPoint(x:   0, y:   0),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y: -10)
            ]),
        .init(
            name: "Test 3",
            path: [
                CGPoint(x:   0, y:   0),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y: -10),
                CGPoint(x:   0, y: -20),
                CGPoint(x:   0, y:  20)
            ])
    ]
}
