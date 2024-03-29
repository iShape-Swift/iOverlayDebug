//
//  ScanBeamListViewer.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 04.12.2023.
//

import SwiftUI
import iDebug

struct ScanBasket: Identifiable {
    
    let id: Int
    let points: [CGPoint]
    let color: Color

}


final class ScanBeamListViewer: ObservableObject {

    public var matrix: Matrix = .empty
    var baskets: [ScanBasket] = []
    
    func makeView() -> ScanBeamListView {
        ScanBeamListView(viewer: self)
    }
    
    func set(level: Int) {

    }
    
    func set(ids: [Int]) {
        
    }
}
