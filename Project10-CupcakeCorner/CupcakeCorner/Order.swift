//
//  Order.swift
//  CupcakeCorner
//
//  Created by yomizzz on 2022/3/31.
//

import Foundation

// 需要手动使得 Order 类遵从 Codable 协议，让 Swift 知道哪些参数需要编码，怎样编码以及怎样解码
// challenge 3 convert data model from a class to a struct
class Order: ObservableObject {
    @Published var orderitem: OrderItem
    
    enum CodingKeys: CodingKey {
        case orderitem
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderitem, forKey: .orderitem)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderitem = try container.decode(OrderItem.self, forKey: .orderitem)
    }
    
    init() {
        orderitem = OrderItem() // 如何表示包含默认参数的数据类型
    }
    
    
    /*
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
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    init() { }
    */
}
