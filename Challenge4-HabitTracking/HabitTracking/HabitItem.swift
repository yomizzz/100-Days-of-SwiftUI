//
//  HabitItem.swift
//  HabitTracking
//
//  Created by yomizzz on 2022/3/29.
//

import Foundation

struct HabitItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var count = 0
}
