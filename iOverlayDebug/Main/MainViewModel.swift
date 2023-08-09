//
//  MainViewModel.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.07.2023.
//

import SwiftUI
import iDebug

final class MainViewModel: ObservableObject {

    private let degScene = DegenerateScene(id: 0)
    private let segmentScene = SegmentScene(id: 1)
    private let splitScene = SplitScene(id: 2)
    private let fixScene = FixScene(id: 3)
    private let complexScene = ComplexScene(id: 4)
    private let twoSplitScene = TwoSplitScene(id: 5)
    private let angleSortScene = AngleSortScene(id: 6)
    private let angleClockWiseScene = AngleClockWiseScene(id: 7)
    private let starScene = StarScene(id: 8)
    private let twoSegmentScene = TwoSegmentScene(id: 9)
    private let intersectScene = IntersectScene(id: 10)
    private let unionScene = UnionScene(id: 11)
    private let differenceScene = DifferenceScene(id: 12)
    private let xorScene = XorScene(id: 13)
    private var testStore: TestStore?

    private (set) var pIndex = PersistInt(key: "TestIndex", nilValue: 0)
    
    lazy var scenes: [SceneHandler] = [
        degScene.handler,
        segmentScene.handler,
        splitScene.handler,
        fixScene.handler,
        complexScene.handler,
        twoSplitScene.handler,
        angleSortScene.handler,
        angleClockWiseScene.handler,
        starScene.handler,
        twoSegmentScene.handler,
        intersectScene.handler,
        unionScene.handler,
        differenceScene.handler,
        xorScene.handler
    ]

    @Published
    var sceneId: Int = 0 {
        didSet {
            self.update(id: sceneId)
        }
    }
    
    @Published
    var testId: Int = 0 {
        didSet {
            testStore?.testId = testId
        }
    }
    
    @Published
    var tests: [TestHandler] = []
    

    @ViewBuilder var sceneView: some View {
        switch sceneId {
        case 0:
            degScene.makeView()
        case 1:
            segmentScene.makeView()
        case 2:
            splitScene.makeView()
        case 3:
            fixScene.makeView()
        case 4:
            complexScene.makeView()
        case 5:
            twoSplitScene.makeView()
        case 6:
            angleSortScene.makeView()
        case 7:
            angleClockWiseScene.makeView()
        case 8:
            starScene.makeView()
        case 9:
            twoSegmentScene.makeView()
        case 10:
            intersectScene.makeView()
        case 11:
            unionScene.makeView()
        case 12:
            differenceScene.makeView()
        case 13:
            xorScene.makeView()
            
        default:
            fatalError("scene not set")
        }
    }
    
    func onAppear() {
        sceneId = pIndex.value
    }
    
    private func update(id: Int) {
        if sceneId != id {
            sceneId = id
        }
        
        if pIndex.value != id {
            pIndex.value = id
        }
        
        switch id {
        case 0:
            testStore = degScene.testStore
        case 1:
            testStore = segmentScene.testStore
        case 2:
            testStore = splitScene.testStore
        case 3:
            testStore = fixScene.testStore
        case 4:
            testStore = complexScene.testStore
        case 5:
            testStore = twoSplitScene.testStore
        case 6:
            testStore = angleSortScene.testStore
        case 7:
            testStore = angleClockWiseScene.testStore
        case 8:
            testStore = starScene.testStore
        case 9:
            testStore = twoSegmentScene.testStore
        case 10:
            testStore = intersectScene.testStore
        case 11:
            testStore = unionScene.testStore
        case 12:
            testStore = differenceScene.testStore
        case 13:
            testStore = xorScene.testStore
        default:
            break
        }
        
        tests = testStore?.tests ?? []
    }
}
