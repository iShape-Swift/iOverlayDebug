//
//  TwoSplitTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 28.07.2023.
//

import iDebug
import iFixFloat
import CoreGraphics
@testable import iOverlay

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
    
    let data: [TwoTest] = {
        let overlayTests = OverlayTestBank().loadAll()
        var result = [TwoTest]()
        result.reserveCapacity(overlayTests.count)
        for i in 0..<overlayTests.count {
            let test = overlayTests[i]
            let clipPaths = test.clipPaths.map { $0.map { $0.cgPoint } }
            let subjPaths = test.subjPaths.map { $0.map { $0.cgPoint } }
            result.append(
                TwoTest(
                    name: "test_\(i)",
                    subjPaths: subjPaths,
                    clipPaths: clipPaths
                )
            )
        }
        return result
    }()

}
