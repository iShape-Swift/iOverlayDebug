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
    private let angleSortScene = AngleSortScene(id: 5)
    private let angleClockWiseScene = AngleClockWiseScene(id: 6)
    private var testStore: TestStore?

    private (set) var pIndex = PersistInt(key: "TestIndex", nilValue: 0)
    
    lazy var scenes: [SceneHandler] = [
        degScene.handler,
        segmentScene.handler,
        splitScene.handler,
        fixScene.handler,
        complexScene.handler,
        angleSortScene.handler,
        angleClockWiseScene.handler
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
            angleSortScene.makeView()
        case 6:
            angleClockWiseScene.makeView()
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
            testStore = angleSortScene.testStore
        case 6:
            testStore = angleClockWiseScene.testStore
        default:
            break
        }
        
        tests = testStore?.tests ?? []
    }
}
