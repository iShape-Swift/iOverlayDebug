//
//  AngleClockWiseScene.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 26.07.2023.
//
import SwiftUI
import iDebug
import iOverlay
import iFixFloat
import iShape


final class AngleClockWiseScene: ObservableObject, SceneContainer {

    let id: Int
    let title = "AngleClockWise"
    
    let angleSortTestStore = AngleSortTestStore()
    var testStore: TestStore { angleSortTestStore }
    let editor = PointsEditor(showIndex: true)
    private (set) var dots: [TextDot] = []
    private (set) var vectors: [Vector] = []
    
    var isClockWise: Bool = true {
        didSet {
            solve()
        }
    }
    
    private var matrix: Matrix = .empty
    
    init(id: Int) {
        self.id = id
        angleSortTestStore.onUpdate = self.didUpdateTest
        
        editor.onUpdate = { [weak self] _ in
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
    
    func makeView() -> AngleClockWiseSceneView {
        AngleClockWiseSceneView(scene: self)
    }

    func editorView() -> PointsEditorView {
        editor.makeView(matrix: matrix)
    }

    func didUpdateTest() {
        let test = angleSortTestStore.test
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.editor.set(points: test.path)
            self.solve()
        }
    }
    
    func didUpdateEditor() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.solve()
        }
    }
    
    func onAppear() {
        didUpdateTest()
    }

    func solve() {
        dots.removeAll()
        vectors.removeAll()
        
        defer {
            self.objectWillChange.send()
        }
        
        var points = editor.points.map({ $0.fixVec })
        guard !points.isEmpty else {
            return
        }
        
        let center = points.removeFirst()
        let start = points.removeFirst()

        let pCenter = matrix.screen(worldPoint: center.cgPoint)
        let pStart = matrix.screen(worldPoint: start.cgPoint)
        
        dots.append(.init(
            id: 0,
            center: pCenter,
            radius: 5,
            color: .red,
            text: "center"
        ))
        
        dots.append(.init(
            id: 1,
            center: pStart,
            radius: 5,
            color: .red,
            text: "start"
        ))
        
        vectors.append(Vector(id: 0, start: pCenter, end: pStart, color: .red, lineWidth: 5, arrowColor: .red))
        
        let index = points.findNearestVectorTo(center: center, startingVector: start, inClockWise: isClockWise)
        let min = points[index]

        let pMin = matrix.screen(worldPoint: min.cgPoint)
        
        vectors.append(Vector(id: 1, start: pCenter, end: pMin, color: .green, lineWidth: 5, arrowColor: .green))
 
    }
    
    func printTest() {
        print("path: \(editor.points.prettyPrint())")
    }
    
}

private extension Array where Element == FixVec {
    
    func findNearestVectorTo(center: FixVec, startingVector: FixVec, inClockWise: Bool) -> Int {
        let v0 = startingVector - center
        
        var minIndex = 0
        var minVec = self[0] - center
        var i = 1
        while i < count {
            let vi = self[i] - center

            if v0.isCloserInRotation(to: vi, comparedTo: minVec, inClockWise: inClockWise) {
                minVec = vi
                minIndex = i
            }
            i += 1
        }
        
        return minIndex
    }
    
}

private extension FixVec {
    
    // v, a, b vectors are multidirectional
    func isCloserInRotation(to a: FixVec, comparedTo b: FixVec, inClockWise: Bool) -> Bool {
        let crossA = self.unsafeCrossProduct(a)
        let crossB = self.unsafeCrossProduct(b)

        guard crossA != 0 && crossB != 0 else {
            // vectors are collinear
            if crossA == 0 {
                // a is opposite to self, so based on crossB
                return crossB > 0
            } else {
                // b is opposite to self, so based on crossA
                return crossA < 0
            }
        }
        
        let sameSide = crossA > 0 && crossB > 0 || crossA < 0 && crossB < 0
        
        guard sameSide else {
            return crossA < 0
        }

        let crossAB = a.unsafeCrossProduct(b)
        
        return crossAB < 0
    }

}
