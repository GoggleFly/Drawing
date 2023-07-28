//
//  ColorCyclingCircle.swift
//  Drawing
//
//  Created by David Ash on 27/07/2023.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    let steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(gradient: Gradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5)
                        ]), startPoint: .top, endPoint: .bottom),
                        lineWidth: 2)
            }
        }
        .drawingGroup() // hands off to Metal for offscreen render
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingCircle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingCircle()
    }
}
