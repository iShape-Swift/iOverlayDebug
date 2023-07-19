//
//  GSegment.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 16.07.2023.
//

import SwiftUI
import iDebug

struct GSegment: Identifiable {

    let id: Int
    let start: CGPoint
    let end: CGPoint
    let leftColor: Color
    let rightColor: Color
    let depth: CGFloat
    let title: String?
    
}


struct GSegmentView: View {
    
    let seg: GSegment
    
    var body: some View {
        ZStack() {
            Path { path in
                path.addLines(seg.leftLine)
            }.stroke(style: .init(lineWidth: seg.depth)).foregroundColor(seg.leftColor)
            Path { path in
                path.addLines(seg.rightLine)
            }.stroke(style: .init(lineWidth: seg.depth)).foregroundColor(seg.rightColor)
            if let title = seg.title {
                Text(title)
                    .position(seg.titlePos)
                    .foregroundColor(.black)
            }
        }
    }
}


private extension GSegment {
    
    var titlePos: CGPoint {
        let dir = (start - end).normalize
        let n = CGPoint(x: -dir.y, y: dir.x)
        
        return 0.5 * (start + end) + 10 * n
    }

    var leftLine: [CGPoint] {
        let dir = (start - end).normalize
        let n = CGPoint(x: -dir.y, y: dir.x)
        let r = 0.5 * depth
        let a0 = start + r * n
        let a1 = end + r * n
        
        return [a0, a1]
    }
    
    var rightLine: [CGPoint] {
        let dir = (start - end).normalize
        let n = CGPoint(x: dir.y, y: -dir.x)
        let r = 0.5 * depth
        let a0 = start + r * n
        let a1 = end + r * n
        
        return [a0, a1]
    }
}
