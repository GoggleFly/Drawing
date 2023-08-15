//
//  Arrow.swift
//  Drawing
//
//  Created by David Ash on 15/08/2023.
//

import SwiftUI

struct ArrowShape: Shape {
    var insetAmount: Double
    
    var animatableData: Double { // required to enable animation of custom shape
        get { insetAmount }
        set {
            if newValue > 0.0 && newValue <= 1.0 {
                insetAmount = newValue
            } else {
                insetAmount = 0.5
            }
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let safeInsetAmount = insetAmount <= 1.0 ? insetAmount : 0.5
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - (rect.midX * safeInsetAmount), y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - (rect.midX * safeInsetAmount), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rect.midX * safeInsetAmount), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rect.midX * safeInsetAmount), y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arrow: View {
    @State private var insetAmount = 0.5
    
    var body: some View {
        ArrowShape(insetAmount: insetAmount)
            .frame(width: 200, height: 400)
            .onTapGesture {
                withAnimation { // relies on animatableData property
                    insetAmount = Double.random(in: 0.0...1.0)
                }
            }
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow()
    }
}
