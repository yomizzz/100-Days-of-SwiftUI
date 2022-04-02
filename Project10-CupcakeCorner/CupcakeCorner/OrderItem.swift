//
//  OrderItem.swift
//  CupcakeCorner
//
//  Created by yomizzz on 2022/4/2.
//

import Foundation

struct OrderItem: Codable { // challenge 3 convert data model from a class to a struct
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"] // 用 Array 存储蛋糕种类
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false { // false 表示选项处于关闭状态
        didSet { // 当需要额外配料的选项被关闭后，两种配料选项也恢复到关闭状态
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool { // 判断递送信息是否完整填写，如有其中一个未填写，则 Check out 选项处于灰色状态，无法点击进入下一页面
        // challenge 1 识别输入文本中有空格，算输入无效
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
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
