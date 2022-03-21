//
//  ContentView.swift
//  Drawing
//
//  Created by yomizzz on 2022/3/15.
//

import SwiftUI

struct Arrow: Shape { // challenge 1 画箭头
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 3 / 4, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 3 / 4, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        
        return path
    }
}

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

struct Flower: Shape {
    var petalOffset: Double = -20 //
    
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi / 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number) // 花瓣旋转的距离幅度
            
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2)) // 花瓣以哪个点为轴进行旋转
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2)) // 构建花瓣形状
            
            let rotatedPetal = originalPetal.applying(position) // 返回旋转后的花瓣
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct Trapezoid: Shape { // 画梯形，演示简单图形的动画化，使用 animatableData，只适用于单个数据，且 SwiftUI 不能在整数之间插值
    var insetAmount: Double
    
    var animatableData: Double { // 使 insetAmount 数据可缓慢增加到目标值，同时在这个过程中随之动画化
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct Checkerboard: Shape { // 画黑白格， 演示复杂图形的动画化，使用 AnimatablePair 实现，如数据超过2个，需要嵌套
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> { // 动画过程中， rows 和 columns 是以1为单位增加的
        get {
            AnimatablePair(Double(rows), Double(columns)) // 将 Int 数据转换为 Double 数据，使 SwiftUI 可在数据之间插值并实现动画化
        }
        
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}


struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    
    @State private var amount = 0.0
    
    @State private var insetAmount = 50.0
    
    @State private var rows = 4
    @State private var columns = 4
    
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
        
        /*
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(.blue, lineWidth: 40) // 此处不能直接使用，strokeBorder 只能用于 InsettableShape，需要让 Arc 也遵从 InsettableShape 协议才可使用
         */
        
        /*
        VStack { // 画花朵
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .stroke(.red, lineWidth: 1)
                //.fill(.red)
                //.fill(.red, style: FillStyle(eoFill: true)) // 当重叠区域的形状个数为奇数时，该重叠区域会被着色
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
         */
        
        /*
        Text("Hello World")
            .frame(width: 300, height: 300)
            //.border(.red, width: 30)
            //.background(Image("Example"))
            //.border(Image("Example"), width: 30) // 不能生效，需要 Image 遵从 ShapeStyle 协议
            .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.2), width: 30) // 使用 ImagePaint 可以让图片作为绘制 border 的背景元素，就像颜色一样；其可以用在任意大小的背景，线条，边框中。
         */
        
        /*
        Capsule()
            .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
            .frame(width: 300, height: 200)
         */
        
        /*
        VStack { // 颜色渐变环，测试 Metal 框架和 Core Animation 框架在性能上的差异
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
        */
        
        /*
        ZStack { // 测试 blendMode .multiply 是单纯的颜色值相乘
            Image("PaulHudson")
            /*
            Rectangle()
                .fill(Color(red: 0, green: 1, blue: 0))
           */
            
            Rectangle()
                .fill(Color(red: 1, green: 0, blue: 0))
                .blendMode(.multiply)
        }
        .frame(width: 400, height: 500)
        .clipped()
         */
        
        /*
        Image("PaulHudson")
            .colorMultiply(.red)
         */
        
        /*
        VStack {
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen) // 三原色的合成原理
                
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
         
         Image("PaulHudson")
             .resizable()
             .scaledToFit()
             .frame(width: 200, height: 200)
             .saturation(amount) // 饱和度
             .blur(radius: (1 - amount) * 20) // 不透明度
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 将以上两个视图合在一起
        .background(.black)
        .ignoresSafeArea()
        */
        
        /*
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }
            }
         */
        
        /*
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
         */
        
        /*
        VStack {
            Arrow()
                .stroke(.red, style: StrokeStyle(lineWidth: amount * 20, lineCap: .square, lineJoin: .round))
                .frame(width: 200, height: 400)
            
            Slider(value: $amount) // challenge 2 改变箭头线条粗细
                .padding()
        }
        */
        
        VStack { // challenge 3 渐变矩形
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 200)
            
            Slider(value: $colorCycle)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
