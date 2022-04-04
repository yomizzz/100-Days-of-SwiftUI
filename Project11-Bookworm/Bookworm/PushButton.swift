//
//  PushButton.swift
//  Bookworm
//
//  Created by yomizzz on 2022/4/3.
//

import SwiftUI

struct PushButton: View { // 与本项目无关，练习使用
    let title: String
    @Binding var isOn: Bool // 使该值的改变能够传递到 ContentView 里
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors: offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}
