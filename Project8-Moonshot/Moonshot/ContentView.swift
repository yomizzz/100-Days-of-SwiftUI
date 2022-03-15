//
//  ContentView.swift
//  Moonshot
//
//  Created by yomizzz on 2022/3/2.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = false // 用于切换主界面显示样式
    
    var body: some View {
        NavigationView {
            Group { // 不能直接将 modifier 添加给 if 语句，故需要在外面加一个 Group
                if showingGrid {
                    MissionGrid(missions: missions, astronauts: astronauts)
                } else {
                    MissionList(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark) // 视图始终为夜间模式，故 Moonshot 字体颜色始终为白色
            .toolbar { // 在导航栏增加一个按钮，切换主界面显示样式，默认在右上方
                Button {
                    showingGrid.toggle()
                } label: { // 用于显示按钮内容
                    Text("Change View")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
