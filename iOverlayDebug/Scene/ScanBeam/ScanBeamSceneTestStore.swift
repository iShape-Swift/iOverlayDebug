//
//  ScanBeamSceneTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 03.12.2023.
//

import iDebug
import CoreGraphics

struct ScanBeamSceneTest {
    let name: String
    let path: [CGPoint]
}

final class ScanBeamSceneTestStore: TestStore {
    
    private (set) var pIndex = PersistInt(key: String(describing: ScanBeamSceneTestStore.self), nilValue: 0)
    
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
    
    var test: ScanBeamSceneTest {
        data[testId]
    }
    
    let data: [ScanBeamSceneTest] = [
        .init(
            name: "Test 1",
            path: [
                CGPoint(x:   0, y:   0),
                CGPoint(x:  10, y:  10),
            ]),
        .init(
            name: "Test 2",
            path: [
                CGPoint(x:   0, y:   0),
                CGPoint(x:  10, y:  10),
            ]),
        .init(
            name: "Test 3",
            path: [
                CGPoint(x:   0, y:   0),
                CGPoint(x:  10, y:  10),
            ]),
        .init(
            name: "Test 4",
            path: [
                CGPoint(x:   0, y:   0),
                CGPoint(x:   0, y: -10),
            ])
    ]
}
