//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by David Ash on 15/08/2023.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var gradientStartPoint: UnitPoint = UnitPoint(x: 0.0, y: 0.0)
    var gradientEndPoint: UnitPoint = UnitPoint(x: 1.0, y: 1.0)
    
    var body: some View {
        ZStack {
            ForEach(0..<100) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(gradient: Gradient(
                            colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]), startPoint: gradientStartPoint, endPoint: gradientEndPoint), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangle()
    }
}
