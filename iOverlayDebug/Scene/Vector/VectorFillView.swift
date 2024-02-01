//
//  VectorFillView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 30.01.2024.
//

import SwiftUI
import iDebug
import iOverlay

struct VectorFillData: Identifiable {

    let id: Int
    let start: CGPoint
    let end: CGPoint
    let normalize: CGPoint
    let fill: SideFill
    let arrow: Arrow
    let color: Color
    
    init(id: Int, start: CGPoint, end: CGPoint, fill: SideFill) {
        self.id = id
        self.start = start
        self.end = end
        self.fill = fill
        self.color = fill.color
        self.normalize = (start - end).normalize
        self.arrow = Arrow(id: id, start: start, end: end, arrowColor: color, tailColor: color, lineWidth: 2, radius: 12)
    }

}

struct VectorFillView: View {

    static let fillRadius: CGFloat = 3
    static let strokeRadius: CGFloat = 2.5
    
    let vec: VectorFillData
    
    var body: some View {
        ZStack() {
            ArrowView(arrow: vec.arrow)
            
            if vec.fill.isFillSubjectLeft {
                CircleView(position: vec.subjLeftPos, radius: Self.fillRadius, color: .red)
            } else {
                CircleView(position: vec.subjLeftPos, radius: Self.strokeRadius, color: .red, stroke: 1)
            }
            
            if vec.fill.isFillSubjectRight {
                CircleView(position: vec.subjRightPos, radius: Self.fillRadius, color: .red)
            } else {
                CircleView(position: vec.subjRightPos, radius: Self.strokeRadius, color: .red, stroke: 1)
            }
            
            if vec.fill.isFillClipLeft {
                CircleView(position: vec.clipLeftPos, radius: Self.fillRadius, color: .blue)
            } else {
                CircleView(position: vec.clipLeftPos, radius: Self.strokeRadius, color: .blue, stroke: 1)
            }
            
            if vec.fill.isFillClipRight {
                CircleView(position: vec.clipRightPos, radius: Self.fillRadius, color: .blue)
            } else {
                CircleView(position: vec.clipRightPos, radius: Self.strokeRadius, color: .blue, stroke: 1)
            }
        }
    }
}


private extension VectorFillData {
    
    var subjLeftPos: CGPoint {
        let n = self.normalize
        let o = CGPoint(x: -n.y, y: n.x)
        return 0.5 * (start + end) + 6 * o + 4 * n
    }
    
    var subjRightPos: CGPoint {
        let n = self.normalize
        let o = CGPoint(x:  n.y, y: -n.x)
        return 0.5 * (start + end) + 6 * o + 4 * n
    }
    
    var clipLeftPos: CGPoint {
        let n = self.normalize
        let o = CGPoint(x: -n.y, y: n.x)
        return 0.5 * (start + end) + 6 * o - 4 * n
    }
    
    var clipRightPos: CGPoint {
        let n = self.normalize
        let o = CGPoint(x: n.y, y: -n.x)
        return 0.5 * (start + end) + 6 * o - 4 * n
    }
}

private extension SideFill {

    var isFillSubjectLeft: Bool {
        self & .subjLeft == .subjLeft
    }
    
    var isFillSubjectRight: Bool {
        self & .subjRight == .subjRight
    }

    var isFillClipLeft: Bool {
        self & .clipLeft == .clipLeft
    }
    
    var isFillClipRight: Bool {
        self & .clipRight == .clipRight
    }
    
    
    var isFillSubject: Bool {
        self & SideFill.subjLeftAndRight != 0
    }
    
    var isFillClip: Bool {
        self & SideFill.clipLeftAndRight != 0
    }
    
    var isFillBoth: Bool {
        self.isFillSubject && self.isFillClip
    }
    
    var color: Color {
        if self.isFillBoth {
            return .green
        } else if self.isFillClip {
            return .blue
        } else if self.isFillSubject {
            return .red
        } else {
            return .gray
        }
    }

}
