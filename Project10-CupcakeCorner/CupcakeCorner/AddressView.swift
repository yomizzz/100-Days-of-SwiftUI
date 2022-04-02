//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by yomizzz on 2022/3/31.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.orderitem.name)
                TextField("Street Address", text: $order.orderitem.streetAddress)
                TextField("City", text: $order.orderitem.city)
                TextField("Zip", text: $order.orderitem.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order) // 点击跳转到结算页面
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.orderitem.hasValidAddress == false) // 只有当外卖递送信息填写完整，才能点击 Check out 选项
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
