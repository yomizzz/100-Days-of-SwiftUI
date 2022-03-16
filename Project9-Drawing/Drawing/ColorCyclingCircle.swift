//
//  ColorCyclingCircle.swift
//  Drawing
//
//  Created by yomizzz on 2022/3/16.
//

import Foundation
import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    //.strokeBorder(color(for: value, brightness: 1), lineWidth:2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup() // 使用 Metal（可以直接使用 GPU） 而不是 Core Animation 来进行图形绘制，可以加快速度。但这个不能常用，对于一些简单图形的绘制，使用屏幕外渲染可能会拖慢速度。只有当遇到真正的性能问题时再使用 Metal
    }
}
