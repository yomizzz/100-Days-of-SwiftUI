//
//  ContentView.swift
//  Moonshot
//
//  Created by yomizzz on 2022/3/2.
//

import SwiftUI

/*
struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}
 */

struct ContentView: View {
    var body: some View {
        /*
        GeometryReader { geo in
            Image("Example")
                .resizable()
                .scaledToFit() // 整张图片在框内，可能会有留空
                //.scaledToFill() // 整个框被填满，图片显示可能会超出框外
                .frame(width: geo.size.width * 0.8)
                .frame(width: geo.size.width, height: geo.size.height) // 把上述内容放在框内并居中
        }
         */
        
        /*
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) { // 使得视图显示的时候才被创建
                ForEach(0..<100) {
                    CustomText("Item \($0)") // 在 ScrollView 里的视图会马上被创建，而不是等你滚动的时候再创建
                        .font(.title)
                }
            }
            //.frame(maxWidth: .infinity)
        }
        */
        
        /*
        NavigationView {
            List(0..<100) { row in
                NavigationLink {
                    Text("Detail \(row)") // 点击后显示的内容，类似于点击设置-通用后显示的内容
                } label: {
                    Text("Row \(row)") // 点击的内容，类似于设置里的“通用”字样
                }
            }
            .navigationTitle("SwiftUI")
        }
        */
        
        /*
        Button("Decode JSON") { // 创建的 struct 个数和层级结构需要和 json 文件内的层级结构相匹配
            struct User: Codable {
                let name: String
                let address: Address
            }
            
            struct Address: Codable {
                let street: String
                let city: String
            }
            
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
         */
        
        let layout = [
            GridItem(.adaptive(minimum: 10, maximum: 120)),
        ]
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
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
