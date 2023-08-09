//
//  FixTestStore.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 107.2023.
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
            name: "Simple 0",
            path: [
                CGPoint(x: -20, y:   0),
                CGPoint(x: -10, y:  15),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  20, y:   0)
            ]),
        .init(
            name: "Simple 1",
            path: [
                CGPoint(x: -20, y:   0),
                CGPoint(x:  10, y:  15),
                CGPoint(x: -10, y: -15),
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
        .init(
            name: "Simple 3",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:   0, y:  20),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  -5, y:   0),
                CGPoint(x:   0, y:  10),
                CGPoint(x:   5, y:   0),
                CGPoint(x:   0, y: -10)
            ]),
        .init(
            name: "Simple 4",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:   0, y:  10),
                CGPoint(x:  10, y:   0)
            ]),
        .init(
            name: "Simple 5",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y:  10)
            ]),
        .init(
            name: "Simple 6",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:  10),
                CGPoint(x:   0, y:  10)
            ]),
        .init(
            name: "Simple 7",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:   0, y:  20),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  -4, y:  -6),
                CGPoint(x:   0, y:  10),
                CGPoint(x:   5, y:   0),
                CGPoint(x:   0, y: -10)
            ]),
        .init(
            name: "Simple 8",
            path: [
                CGPoint(x:   0, y:   5),
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   5, y:  -5),
                CGPoint(x:   5, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:  -5, y:   5)
            ]),
        .init(
            name: "Simple 9",
            path: [
                CGPoint(x:   0, y:   5),
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   5, y:  -5),
                CGPoint(x:   5, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -10, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:   5, y: -10)
            ]),
        .init(
            name: "Simple 10",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:   5, y: -20),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 11",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:  -5, y:  -2),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 12",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y: -10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:  -1, y:  -2),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 13",
            path: [
                CGPoint(x:  -5, y:   0),
                CGPoint(x:   0, y:  10),
                CGPoint(x:  12, y:  -3),
                CGPoint(x: -10, y: -13),
                CGPoint(x: -16, y:  -2),
                CGPoint(x: -10, y: -13),
                CGPoint(x:  12, y:  -3),
                CGPoint(x:   7, y:   9)
            ]),
        .init(
            name: "Simple 14",
            path: [
                CGPoint(x:  0, y: -10),
                CGPoint(x:  0, y:   5),
                CGPoint(x: -5, y: -15),
                CGPoint(x: -5, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x: 10, y: -15),
                CGPoint(x: -5, y: -15),
                CGPoint(x: -5, y: -20),
                CGPoint(x: -5, y: -10),
                CGPoint(x: 10, y: -10),
                CGPoint(x:  2, y: -15),
                CGPoint(x: -5, y: -15),
                CGPoint(x: 10, y: -15),
                CGPoint(x: -5, y: -10)
            ]),
        .init(
            name: "Simple 15",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x: -12, y:  24),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  20, y:  -3),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:  -1, y:  19),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 16",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x:  -5, y:  37),
                CGPoint(x: -10, y:  -1),
                CGPoint(x:  10, y:  -1),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:   7, y:  -5),
                CGPoint(x: -10, y:  -1),
                CGPoint(x:  10, y:  -1),
                CGPoint(x:  -5, y:  37),
                CGPoint(x: -10, y:  -1),
                CGPoint(x:  18, y:  19),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 17",
            path: [
                CGPoint(x:  -2, y:   5),
                CGPoint(x:  -2, y: -20),
                CGPoint(x:   5, y: -20),
                CGPoint(x:   5, y:   0),
                CGPoint(x:   7, y: -20),
                CGPoint(x:  -4, y: -20),
                CGPoint(x:   9, y:  10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  -7, y: -20),
                CGPoint(x:  10, y: -20)
            ]),
        .init(
            name: "Simple 18",
            path: [
                CGPoint(x:  -5, y:  20),
                CGPoint(x:  -5, y:   0),
                CGPoint(x:   0, y:   0),
                CGPoint(x:   5, y:   5),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  20, y:   0),
                CGPoint(x:  20, y:  15),
                CGPoint(x: -15, y:   0),
                CGPoint(x:  15, y:   0)
            ]),
        .init(
            name: "Simple 19",
            path: [
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:   5, y:   0),
                CGPoint(x:   5, y:  10),
                CGPoint(x:   0, y:  10),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y:  10),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  15, y:   5),
                CGPoint(x:  15, y:  10)
            ]),
        .init(
            name: "Simple 20",
            path: [
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:  20),
                CGPoint(x:   0, y:  10)
            ]),
        .init(
            name: "Simple 21",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x: -12, y:  24),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  20, y:  -3),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -20),
                CGPoint(x:  -1, y:  19),
                CGPoint(x:   5, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -12, y:  24),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 22",
            path: [
                CGPoint(x:  15, y:  25),
                CGPoint(x: -12, y:  20),
                CGPoint(x:  -5, y:   0),
                CGPoint(x:  -5, y:  -9),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y: -22),
                CGPoint(x:  -5, y: -25),
                CGPoint(x:   0, y: -25),
                CGPoint(x:   0, y:  30),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -11, y:   0),
                CGPoint(x: -12, y:  20),
                CGPoint(x:  15, y:  20)
            ]),
        .init(
            name: "Simple 23",
            path: [
                CGPoint(x:  15, y:  25),
                CGPoint(x: -12, y:  20),
                CGPoint(x:  -5, y:   0),
                CGPoint(x:   0, y:  30),
                CGPoint(x:  10, y:  10),
                CGPoint(x:  10, y:   0),
                CGPoint(x: -11, y:   0),
                CGPoint(x: -12, y:  20),
                CGPoint(x:  15, y:  20)
            ]),
        .init(
            name: "Simple 24",
            path: [
                CGPoint(x:  10, y:  20),
                CGPoint(x: -10, y:   0),
                CGPoint(x: -10, y:  10),
                CGPoint(x:   0, y:  10),
                CGPoint(x:   0, y: -10),
                CGPoint(x: -10, y:   0),
                CGPoint(x:  10, y:   0)
            ]),
        .init(
            name: "Simple 25",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x:  -5, y:  21),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  20, y:   5),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:   0, y: -20),
                CGPoint(x:   0, y:  21),
                CGPoint(x:  10, y:  14),
                CGPoint(x: -10, y:  14),
                CGPoint(x: -10, y:  -7),
                CGPoint(x:  10, y:   5),
                CGPoint(x:  10, y:  -5)
            ]),
        .init(
            name: "Simple 26",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x:  -2, y: -26),
                CGPoint(x:  -2, y:   5),
                CGPoint(x:  20, y:   5),
                CGPoint(x:  20, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:   0, y: -20),
                CGPoint(x:   0, y:  25),
            ]),
        .init(
            name: "Simple 27",
            path: [
                CGPoint(x:   5, y:  -5),
                CGPoint(x:  -2, y: -26),
                CGPoint(x:  -2, y:   5),
                CGPoint(x:  20, y:   5),
                CGPoint(x:  20, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:   0, y: -20),
                CGPoint(x:   0, y:  -5),
            ]),
        .init(
            name: "Simple 28",
            path: [
                CGPoint(x: 15.0, y: -4.0),
                CGPoint(x: -5.0, y: -24.0),
                CGPoint(x: -5.0, y: 5.0),
                CGPoint(x: 20.0, y: 5.0),
                CGPoint(x: 20.0, y: -15.0),
                CGPoint(x: -9.0, y: -10.0),
                CGPoint(x: -1, y: -20.0),
                CGPoint(x: -1, y: 25.0)
            ]),
        .init(
            name: "Same Line 1",
            path: [
                CGPoint(x:   5, y:   5),
                CGPoint(x:  15, y:   5),
                CGPoint(x:  15, y:  -5),
                CGPoint(x:   5, y:  -5),
                CGPoint(x:   5, y: -15),
                CGPoint(x:  -5, y: -15),
                CGPoint(x:  -5, y:  -5),
                CGPoint(x: -15, y:  -5),
                CGPoint(x: -15, y:   5),
                CGPoint(x:  -5, y:   5),
                CGPoint(x:  -5, y:  15),
                CGPoint(x:   5, y:  15),
            ]),
        .init(
            name: "Same Line 2",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  10, y:   5),
                CGPoint(x:  10, y:  15),
                CGPoint(x: -10, y:  15),
                CGPoint(x: -10, y: -15),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  10, y:  -5),
            ]),
        .init(
            name: "Same Line 3",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  10, y:   5),
                CGPoint(x:  10, y:  15),
                CGPoint(x:   0, y:  15),
                CGPoint(x:   0, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y: -10),
                CGPoint(x:   0, y: -10),
                CGPoint(x:   0, y: -15),
                CGPoint(x:  10, y: -15),
                CGPoint(x:  10, y:  -5),
            ]),
        .init(
            name: "Same Line 4",
            path: [
                CGPoint(x:   0, y:  -5),
                CGPoint(x:   0, y:   5),
                CGPoint(x:  10, y:   5),
                CGPoint(x:  10, y:  15),
                CGPoint(x:   0, y:  15),
                CGPoint(x:   0, y:  10),
                CGPoint(x: -10, y:  10),
                CGPoint(x: -10, y: -15),
                CGPoint(x:   0, y: -15),
                CGPoint(x:   0, y: -10),
                CGPoint(x:  10, y: -10),
                CGPoint(x:  10, y:  -5),
            ]),
        .init(
            name: "Random 0",
            path: [
                CGPoint(x: -5921, y: -17504),
                CGPoint(x: 16517, y:  17652),
                CGPoint(x:  1040, y:    578),
//                CGPoint(x:  6858, y:   3006),
//                CGPoint(x:-18899, y:  -9376),
//                CGPoint(x:  3945, y:   3128),
//                CGPoint(x: -7136, y: -12690),
//                CGPoint(x: 12838, y:  12745),
//                CGPoint(x: 16687, y:   4512),
//                CGPoint(x: 16618, y: -16966),
//                CGPoint(x:-19185, y: -18324),
//                CGPoint(x: -2209, y:  -3951),
//                CGPoint(x: -2153, y:  -5184),
//                CGPoint(x:  2098, y:  -1090),
//                CGPoint(x:  7089, y: -17719),
//                CGPoint(x: -2231, y:  11889),
//                CGPoint(x: -5185, y:   6559),
//                CGPoint(x:-10318, y:  16648),
//                CGPoint(x:-17529, y:   9327),
//                CGPoint(x: 11601, y:  13637),
//                CGPoint(x: -7968, y: -10988),
//                CGPoint(x:-17694, y:  -3389),
//                CGPoint(x: -2794, y:   4444),
//                CGPoint(x:  9400, y:   2867),
//                CGPoint(x: 15122, y: -16557),
//                CGPoint(x:-20226, y:   -106),
//                CGPoint(x: 15231, y: -14430),
//                CGPoint(x:-18841, y:  17970),
//                CGPoint(x: 13198, y:  19690),
//                CGPoint(x: -8366, y: -18573),
//                CGPoint(x:   428, y:  17834),
//                CGPoint(x:-11554, y:   1484),
//                CGPoint(x:-18980, y:  16404),
//                CGPoint(x: -1343, y:   1033),
//                CGPoint(x: -5504, y:    691),
//                CGPoint(x:  8373, y:  15312),
//                CGPoint(x:-14908, y:   9479),
//                CGPoint(x:   436, y:   2190),
//                CGPoint(x: -4623, y:  19934),
//                CGPoint(x: 12630, y:  19623),
//                CGPoint(x: -5652, y:   3306),
//                CGPoint(x:-10259, y:   4939),
//                CGPoint(x: 17874, y:  20401),
//                CGPoint(x: 18463, y: -11892),
//                CGPoint(x:-18885, y: -13607),
//                CGPoint(x:  7960, y:    427),
//                CGPoint(x:-17661, y:   2547),
//                CGPoint(x:-17910, y: -12465),
//                CGPoint(x: -7538, y:  -4494),
//                CGPoint(x:-17017, y:   4592)
            ])
    ]
}
