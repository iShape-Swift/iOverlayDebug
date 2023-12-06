//
//  ScanBeamListView.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 04.12.2023.
//

import SwiftUI
import iDebug

struct ScanBeamListView: View {
 
    @ObservedObject
    var viewer: ScanBeamListViewer
    
    var body: some View {
        ZStack {
            ForEach(viewer.baskets) { basket in
                ZStack {
                    Path { path in
                        path.addLines(basket.points)
                    }.foregroundColor(basket.color)
                    Text("\(basket.id)").foregroundColor(.black)
                }
            }
        }
    }

}
