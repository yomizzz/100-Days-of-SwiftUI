//
//  ContentView.swift
//  Drawing
//
//  Created by yomizzz on 2022/3/15.
//

import SwiftUI

// path 和 shape 的区别：path 只能用一次，而 shape 可以复用并接收参数来进行定制
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path { // 苹果设计画弧线的程序逻辑有点反常识，其水平向右是0度，且角度顺时针为正，画弧线时顺时针其实是逆时针
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape { // 使 Arc 类型遵从 InsettableShape 协议
        var arc = self
        arc.insetAmount += amount
        
        return arc
    }
}

struct ContentView: View {
    var body: some View {
        /*
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            //path.closeSubpath() // 将三角形最后一个角闭合
        }
        //.fill(.blue) // 将三角形填充为蓝色
        .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)) // 将三角形边填充为蓝色，并将线条粗细设置为10，将三角形最后一个角闭合
         */
        
        /*
        Triangle()
            //.fill(.red)
            .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 300)
         */
        
        /*
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            .stroke(.blue, lineWidth: 10)
            .frame(width: 300, height: 300)
         */
        
        /*
        Circle()
            //.stroke(.blue, lineWidth: 40) // 圆的两侧边缘被切掉了一块，这是因为当你用一支粗铅笔描细铅笔画的圆，就会将原来的线作为中心线来画，粗铅笔画的线一半在圆里，一半在圆外
            .strokeBorder(.blue, lineWidth: 40) // 这样可以避免上面这种情况, Circle 遵从 InsettableShape 协议（可嵌入的形状）
         */
        
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(.blue, lineWidth: 40) // 此处不能直接使用，strokeBorder 只能用于 InsettableShape，需要让 Arc 也遵从 InsettableShape 协议才可使用
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
