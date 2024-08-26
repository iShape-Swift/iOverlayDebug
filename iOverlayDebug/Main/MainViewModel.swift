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
    private let vectorScene = VectorScene(id: 10)
    private let intersectScene = IntersectScene(id: 11)
    private let unionScene = UnionScene(id: 12)
    private let differenceScene = DifferenceScene(id: 13)
    private let inverseDifferenceScene = InverseDifferenceScene(id: 14)
    private let xorScene = XorScene(id: 15)
    private let subjScene = SubjScene(id: 16)
    private let starExtractScene = StarExtractScene(id: 17)
    private let scanBeamScene = ScanBeamScene(id: 18)
    private let edgeScene = EdgeScene(id: 19)
    private let randomSegmScene = RandomSegmScene(id: 20)
    private let spiralScene = SpiralScene(id: 21)
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
        vectorScene.handler,
        intersectScene.handler,
        unionScene.handler,
        differenceScene.handler,
        inverseDifferenceScene.handler,
        xorScene.handler,
        subjScene.handler,
        starExtractScene.handler,
        scanBeamScene.handler,
        edgeScene.handler,
        randomSegmScene.handler,
        spiralScene.handler
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
            vectorScene.makeView()
        case 11:
            intersectScene.makeView()
        case 12:
            unionScene.makeView()
        case 13:
            differenceScene.makeView()
        case 14:
            inverseDifferenceScene.makeView()
        case 15:
            xorScene.makeView()
        case 16:
            subjScene.makeView()
        case 17:
            starExtractScene.makeView()
        case 18:
            scanBeamScene.makeView()
        case 19:
            edgeScene.makeView()
        case 20:
            randomSegmScene.makeView()
        case 21:
            spiralScene.makeView()
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
            testStore = vectorScene.testStore
        case 11:
            testStore = intersectScene.testStore
        case 12:
            testStore = unionScene.testStore
        case 13:
            testStore = differenceScene.testStore
        case 14:
            testStore = inverseDifferenceScene.testStore
        case 15:
            testStore = xorScene.testStore
        case 16:
            testStore = subjScene.testStore
        case 17:
            testStore = starExtractScene.testStore
        case 18:
            testStore = scanBeamScene.testStore
        case 19:
            testStore = edgeScene.testStore
        case 20:
            testStore = randomSegmScene.testStore
        case 21:
            testStore = spiralScene.testStore
        default:
            break
        }
        
        tests = testStore?.tests ?? []
    }
}
