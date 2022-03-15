//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by yomizzz on 2022/3/6.
//

import Foundation

// https://www.hackingwithswift.com/books/ios-swiftui/using-generics-to-load-any-kind-of-codable-data
// 使用 generics 让代码更具普适性，针对任意结构的json文件，都可以进行解码
// 将解码代码，作为 Bundle 的一个扩展，方便调用
extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        // 告诉 docoder 实例 json 文件中日期的格式，以正确地将其解码为 Date 类型数据
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failde to decode \(file) from bundle.")
        }
        
        return loaded // 以不同格式返回解码后的数据，如列表，字典等等均可
    }
}
