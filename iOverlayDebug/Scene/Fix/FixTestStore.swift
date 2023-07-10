//
//  FixTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.07.2023.
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
    ]
    
}
