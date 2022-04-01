//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by yomizzz on 2022/3/31.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else { // 将 order 数据编码
            print("Failed to encode order")
            return
        }
        
        // 确定数据发往的地方，如网站，服务器等等，以及发送数据的条件，如数据的类型
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do { // 发送数据并返回信息
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
        }
        
    }
    
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
                
                Button("Place Order") { // 此处还需补充一个函数，用于将我们的预定信息转换为 JSON 文件，发送出去并得到响应
                    Task { // 使 Button 支持异步操作的函数
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) { // 提交数据到网站后，反馈信息的提醒
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
