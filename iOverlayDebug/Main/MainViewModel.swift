//
//  MainViewModel.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.07.2023.
//

import SwiftUI
import iDebug

final class MainViewModel: ObservableObject {

    private let pinScene = PinScene(id: 0)
    private let degScene = DegenerateScene(id: 1)
    private let fixScene = FixScene(id: 2)
    private let graphScene = FixGraphScene(id: 3)
    private var testStore: TestStore?

    private (set) var pIndex = PersistInt(key: "TestIndex", nilValue: 0)
    
    lazy var scenes: [SceneHandler] = [
        pinScene.handler,
        degScene.handler,
        fixScene.handler,
        graphScene.handler
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
            pinScene.makeView()
        case 1:
            degScene.makeView()
        case 2:
            fixScene.makeView()
        case 3:
            graphScene.makeView()
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
            testStore = pinScene.testStore
        case 1:
            testStore = degScene.testStore
        case 2:
            testStore = fixScene.testStore
        case 3:
            testStore = graphScene.testStore
        default:
            break
        }
        
        tests = testStore?.tests ?? []
    }
}
