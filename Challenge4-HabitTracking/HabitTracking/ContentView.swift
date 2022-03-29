//
//  ContentView.swift
//  HabitTracking
//
//  Created by yomizzz on 2022/3/29.
//

import SwiftUI


struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabit = false
    
    func removeItems(at offsets: IndexSet) { // 删除列表中条目的函数
        habits.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                    NavigationLink { // 点击条目进入详情页
                        HabitView(habit: item, habits: habits)
                    } label: {
                        Text(item.title)
                    }
                }
                .onDelete(perform: removeItems) // 删除列表中的条目
            }
            .navigationTitle("HabitTracking")
            .toolbar { // 往列表中添加条目
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabit(habits: habits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
