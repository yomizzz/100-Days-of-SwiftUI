//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by yomizzz on 2022/1/28.
//

import SwiftUI

/*
struct Watermark: ViewModifier {
    var text: String  // 如需要参数，则要添加属性
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}
 */

struct largeText: ViewModifier { // custom modifiers
    
    func body(content: Content) -> some View { // 默认语句
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largetext() -> some View { // 建立函数
        modifier(largeText())
    }
}

struct ContentView: View {
    var body: some View {
        
        /*
        VStack {
            Text("Yomizzz")
                .font(.largeTitle)
                .frame(width: 200, height: 200)
                .background(.indigo)
                .watermarked(with: "Hacking with Swift")
        }
         */
        
        Text("Yomizzz")
            .largetext()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
