//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by yomizzz on 2022/3/21.
//

import Foundation
import SwiftUI

struct ColorCyclingRectangle: View { // challenge 3 渐变矩形
    var amount = 0.0
    var steps = 100
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness) // 色调，饱和度，亮度
        
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle ()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(gradient: Gradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5)
                                                                  
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                        ),
                        lineWidth: 0.5
                    )
            }
        }
    }
}
