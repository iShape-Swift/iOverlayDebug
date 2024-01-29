//
//  GSegment.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 16.07.2023.
//

import SwiftUI
import iDebug
import iOverlay

struct SegmentData: Identifiable {

    let id: Int
    let start: CGPoint
    let end: CGPoint
    let fill: SegmentFill

}

struct SegmentView: View {

    static let fillRadius: CGFloat = 3
    static let strokeRadius: CGFloat = 2.5
    
    let seg: SegmentData
    
    var body: some View {
        ZStack() {
            Path { path in
                path.move(to: seg.start)
                path.addLine(to: seg.end)
            }.stroke(style: .init(lineWidth: 2)).foregroundColor(seg.color)
            if seg.fill.isFillSubjectTop {
                CircleView(position: seg.subjTopPos, radius: Self.fillRadius, color: .red)
            } else {
                CircleView(position: seg.subjTopPos, radius: Self.strokeRadius, color: .red, stroke: 1)
            }
            if seg.fill.isFillSubjectBottom {
                CircleView(position: seg.subjBottomPos, radius: Self.fillRadius, color: .red)
            } else {
                CircleView(position: seg.subjBottomPos, radius: Self.strokeRadius, color: .red, stroke: 1)
            }
            if seg.fill.isFillClipTop {
                CircleView(position: seg.clipTopPos, radius: Self.fillRadius, color: .blue)
            } else {
                CircleView(position: seg.clipTopPos, radius: Self.strokeRadius, color: .blue, stroke: 1)
            }
            if seg.fill.isFillClipBottom {
                CircleView(position: seg.clipBottomPos, radius: Self.fillRadius, color: .blue)
            } else {
                CircleView(position: seg.clipBottomPos, radius: Self.strokeRadius, color: .blue, stroke: 1)
            }
        }
    }
}


private extension SegmentData {
    
    var subjTopPos: CGPoint {
        let n = (start - end).normalize
        let o = CGPoint(x: -n.y, y: n.x)
        return 0.5 * (start + end) + 6 * o + 4 * n
    }
    
    var subjBottomPos: CGPoint {
        let n = (start - end).normalize
        let o = CGPoint(x:  n.y, y: -n.x)
        return 0.5 * (start + end) + 6 * o + 4 * n
    }
    
    var clipTopPos: CGPoint {
        let n = (start - end).normalize
        let o = CGPoint(x: -n.y, y: n.x)
        return 0.5 * (start + end) + 6 * o - 4 * n
    }
    
    var clipBottomPos: CGPoint {
        let n = (start - end).normalize
        let o = CGPoint(x: n.y, y: -n.x)
        return 0.5 * (start + end) + 6 * o - 4 * n
    }
    
    var color: Color {
        if fill.isFillClip && fill.isFillSubject {
            return .green
        } else if fill.isFillClip {
            return .blue
        } else if fill.isFillSubject {
            return .red
        } else {
            return .gray
        }
    }
    
}

extension SegmentFill {

    var isFillSubject: Bool {
        self & SegmentFill.subjBoth != 0
    }

    var isFillClip: Bool {
        self & SegmentFill.clipBoth != 0
    }

    var isFillSubjectTop: Bool {
        self & SegmentFill.subjTop == SegmentFill.subjTop
    }

    var isFillSubjectBottom: Bool {
        self & SegmentFill.subjBottom == SegmentFill.subjBottom
    }

    var isFillClipTop: Bool {
        self & SegmentFill.clipTop == SegmentFill.clipTop
    }

    var isFillClipBottom: Bool {
        self & SegmentFill.clipBottom == SegmentFill.clipBottom
    }

}
