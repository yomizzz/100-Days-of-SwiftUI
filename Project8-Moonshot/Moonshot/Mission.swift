//
//  Mission.swift
//  Moonshot
//
//  Created by yomizzz on 2022/3/6.
//

import Foundation

/*
struct CrewRole: Codable {
    let name: String
    let role: String
}
 */

struct Mission: Codable, Identifiable {
    // 调用时使用 Mission.CrewRole，当程序中有很多定制类型时，这样可以更好地组织代码
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    // 将解码得到的 Date 类型的 launchDate 格式化为 string 类型，如其值不存在，则输出 “N/A”
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
