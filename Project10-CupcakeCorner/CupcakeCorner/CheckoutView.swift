//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by yomizzz on 2022/3/31.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                // 在线获取图片，并按照自定义的规格显示
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView() // 加载图片时转圈圈
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "CNY"))")
                    .font(.title)
                
                Button("Place Order", action: { }) // 此处还需补充一个函数，用于将我们的预定信息转换为 JSON 文件，发送出去并得到响应
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
