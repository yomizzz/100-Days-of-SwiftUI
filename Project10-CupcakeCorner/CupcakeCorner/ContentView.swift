//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by yomizzz on 2022/3/30.
//

import SwiftUI


struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section { // 选择蛋糕种类和数量
                    Picker("Select your cake type", selection: $order.orderitem.type) {
                        ForEach(OrderItem.types.indices) { // 使用列表元素对应下标来选择元素并显示
                            Text(OrderItem.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.orderitem.quantity)", value: $order.orderitem.quantity, in: 3...20) // 选择蛋糕数量
                }
                
                Section { // 选择额外添加的配料
                    Toggle("Any sepcial requests?", isOn: $order.orderitem.specialRequestEnabled.animation())
                    
                    if order.orderitem.specialRequestEnabled { // 只有当需要添加额外配料的开关打开（true）后，才能选择配料
                        Toggle("Add extra frosting", isOn: $order.orderitem.extraFrosting)
                        
                        Toggle("Add extra sprinkle", isOn: $order.orderitem.addSprinkles)
                    }
                }
                
                Section { // 完成选择后进入外卖递送信息页面
                    NavigationLink {
                        AddressView(order: order) // 外卖递送信息页面
                    } label: {
                        Text("Delivery details")
                    }
                }
                
            }
            .navigationTitle("Cupcake Corner")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
