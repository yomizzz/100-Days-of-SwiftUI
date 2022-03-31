//
//  Order.swift
//  CupcakeCorner
//
//  Created by yomizzz on 2022/3/31.
//

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"] // 用 Array 存储蛋糕种类
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false { // false 表示选项处于关闭状态
        didSet { // 当需要额外配料的选项被关闭后，两种配料选项也恢复到关闭状态
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool { // 判断递送信息是否完整填写，如有其中一个未填写，则 Check out 选项处于灰色状态，无法点击进入下一页面
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double { // 计算花费金额
        var cost = Double(quantity) * 2 // 每个蛋糕2块钱
        
        cost += (Double(type) / 2) * Double(quantity) // 蛋糕种类后一种比前一种每个多0.5元
        
        if extraFrosting { // 加糖霜多1元
            cost += Double(quantity)
        }
        
        if addSprinkles { // 加巧克力屑多0.5元
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
}
