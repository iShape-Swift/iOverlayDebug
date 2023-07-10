//
//  PinScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 10.07.2023.
//

import SwiftUI
import iDebug
import iShape
import iOverlay
import iFixFloat

final class PinScene: ObservableObject, SceneContainer {

    static let colorA: Color = .red
    static let colorB: Color = .blue
    
    let id: Int
    let title = "Pin"
    let pinTestStore = PinTestStore()
    var testStore: TestStore { pinTestStore }
    let editorA = ContourEditor(showIndex: true, color: PinScene.colorA)
    let editorB = ContourEditor(showIndex: true, color: PinScene.colorB)
    private (set) var pins = [PinVector]()
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        pinTestStore.onUpdate = self.didUpdateTest
        
        editorA.onUpdate = { [weak self] _ in
            self?.didUpdateEditor()
        }
        editorB.onUpdate = { [weak self] _ in
            self?.didUpdateEditor()
        }
    }
    
    func initSize(screenSize: CGSize) {
        if !matrix.screenSize.isIntSame(screenSize) {
            matrix = Matrix(screenSize: screenSize, scale: 10, inverseY: true)
            DispatchQueue.main.async { [weak self] in
                self?.solve()
            }
        }
    }
    
    func makeView() -> PinSceneView {
        PinSceneView(scene: self)
    }

    func editorAView() -> ContourEditorView {
        editorA.makeView(matrix: matrix)
    }
    
    func editorBView() -> ContourEditorView {
        editorB.makeView(matrix: matrix)
    }
    
    func didUpdateTest() {
        let test = pinTestStore.test
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // TODO validate convex
            self.editorA.set(points: test.pA)
            self.editorB.set(points: test.pB)
            self.solve()
        }
    }
    
    func didUpdateEditor() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // TODO validate convex
            self.solve()
        }
    }
    
    func onAppear() {
        didUpdateTest()
    }

    func solve() {
        defer {
            self.objectWillChange.send()
        }
        
        let pA = editorA.points.map({ $0.fixVec })
        let pB = editorB.points.map({ $0.fixVec })

        guard !pA.isEmpty && !pB.isEmpty else { return }
        
        pins.removeAll()

        editorA.set(stroke: 1, color: PinScene.colorA)
        editorB.set(stroke: 1, color: PinScene.colorB)

        let solver = ABCrossSolver()
        let abCross = solver.safeCross(pathA: pA, pathB: pB)
        guard abCross.layout != .apart else {
            return
        }
        
        let scrA = matrix.screen(worldPoints: editorA.points)
        
        var i = 0
        for p in abCross.navigator.pins {
            let a: CGPoint
            let b: CGPoint
            let c = matrix.screen(worldPoint: p.p.point)
            if p.mA.offset != 0 {
                a = scrA[p.mA.index]
                b = scrA[(p.mA.index + 1) % scrA.count]
            } else {
                a = scrA[(p.mA.index - 1 + scrA.count) % scrA.count]
                b = scrA[(p.mA.index + 1) % scrA.count]
            }
            let n = (b - a).normalize

            let title: String?
            let arrowColor: Color
            let tailColor: Color
            
            switch p.type {
            case .empty:
                title = "_ a0: \(p.a0), a1: \(p.a1)"
                tailColor = .gray
                arrowColor = .gray
            case .into:
                title = "in a0: \(p.a0), a1: \(p.a1)"
                tailColor = .red
                arrowColor = .red
            case .out:
                title = "out a0: \(p.a0), a1: \(p.a1)"
                tailColor = .blue
                arrowColor = .blue
            case .into_empty:
                title = "in_ a0: \(p.a0), a1: \(p.a1)"
                tailColor = .red
                arrowColor = .gray
            case .empty_into:
                title = "_in a0: \(p.a0), a1: \(p.a1)"
                tailColor = .gray
                arrowColor = .red
            case .out_empty:
                title = "out_ a0: \(p.a0), a1: \(p.a1)"
                tailColor = .blue
                arrowColor = .gray
            case .empty_out:
                title = "_out a0: \(p.a0), a1: \(p.a1)"
                tailColor = .gray
                arrowColor = .blue
            case .into_out:
                title = "into_out a0: \(p.a0), a1: \(p.a1)"
                tailColor = .red
                arrowColor = .blue
            case .out_into:
                title = "out_into a0: \(p.a0), a1: \(p.a1)"
                tailColor = .blue
                arrowColor = .red
                
            }
            
            let arrow = Arrow(id: i, start: c - 6 * n, end: c + 6 * n, arrowColor: arrowColor, tailColor: tailColor, lineWidth: 4)

            let offset: CGPoint = i % 2 == 0 ? CGPoint(x: 16, y: 12) : CGPoint(x: -16, y: -12)
            
            pins.append(PinVector(arrow: arrow, title: title, titlePos: c + offset))
            i += 1
        }
    }
    
    func printTest() {
        print("A: \(editorA.points.prettyPrint())")
        print("B: \(editorB.points.prettyPrint())")
    }
    
}
