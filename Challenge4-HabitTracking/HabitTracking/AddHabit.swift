//
//  AddHabit.swift
//  HabitTracking
//
//  Created by yomizzz on 2022/3/29.
//

import SwiftUI

struct AddHabit: View {
    @State private var title = ""
    @State private var description = ""
    
    @ObservedObject var habits: Habits
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                TextField("Description", text: $description)
            }
            .navigationTitle("AddHabit")
            .toolbar {
                Button("Save") {
                    let item = HabitItem(title: title, description: description)
                    habits.items.append(item)
                    dismiss() // 点击 Save 按钮后，添加条目页面自动关闭
                }
            }
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
