//
//  MissionGrid.swift
//  Moonshot
//
//  Created by yomizzz on 2022/3/14.
//

import Foundation
import SwiftUI

struct MissionGrid: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100) // 调整视图的大小
                                .padding() // 在视图上下增加空白
                            
                            VStack { // 增加这个 VStack 可以将图片内容和文字内容分隔开，方便分别进行样式修改
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5)) // 字体颜色为白色半透明
                            }
                            .padding() // 给文字上下增加空白
                            .frame(maxWidth: .infinity) // 文字视图宽度达到能实现的最大值
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10)) // 将整个 VStack 视图调整为圆角矩形
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground) // 为 VStack 视图添加框线
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom]) // 为 LazyVGrid 视图两侧和底部添加空白
        }
    }
}

struct MissionGrid_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionGrid(missions: missions, astronauts: astronauts)
    }
}
