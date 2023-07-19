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
    private let graphScene = SGraphScene(id: 1)
    private let splitScene = SplitScene(id: 2)
    private let angleSortScene = AngleSortScene(id: 3)
    private var testStore: TestStore?

    private (set) var pIndex = PersistInt(key: "TestIndex", nilValue: 0)
    
    lazy var scenes: [SceneHandler] = [
        degScene.handler,
        graphScene.handler,
        splitScene.handler,
        angleSortScene.handler
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
            graphScene.makeView()
        case 2:
            splitScene.makeView()
        case 3:
            angleSortScene.makeView()
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
            testStore = graphScene.testStore
        case 2:
            testStore = splitScene.testStore
        case 3:
            testStore = angleSortScene.testStore
        default:
            break
        }
        
        tests = testStore?.tests ?? []
    }
}
