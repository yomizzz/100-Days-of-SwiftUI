//
//  User.swift
//  CupcakeCorner
//
//  Created by yomizzz on 2022/3/30.
//

import Foundation

// 将数据编码后用于发送，将数据解码后方便读取
class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey { // 声明我们想要写入的数据的属性名
        case name
    }
    
    @Published var name = "Paul Hudson"
    
    required init(from decoder: Decoder) throws { // 将储存的属性数据解码，用于读取
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws { // 将属性数据编码，便于储存，发送
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
