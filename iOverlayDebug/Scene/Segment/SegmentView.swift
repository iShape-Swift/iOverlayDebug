//
//  GSegment.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 16.07.2023.
//

import SwiftUI
import iDebug

struct SegmentData: Identifiable {

    let id: Int
    let start: CGPoint
    let end: CGPoint
    let isFillTop: Bool

}

struct SegmentView: View {
    
    let seg: SegmentData
    
    var body: some View {
        ZStack() {
            Path { path in
                path.move(to: seg.start)
                path.addLine(to: seg.end)
            }.stroke(style: .init(lineWidth: 2)).foregroundColor(.gray)
            CircleView(position: seg.circlePos, radius: 4, color: .red)
        }
    }
}


private extension SegmentData {
    
    var circlePos: CGPoint {
        let dir = (start - end).normalize
        let n: CGPoint
        if isFillTop {
            n = CGPoint(x: -dir.y, y: dir.x)
        } else {
            n = CGPoint(x: dir.y, y: -dir.x)
        }

        return 0.5 * (start + end) + 5 * n
    }
}
