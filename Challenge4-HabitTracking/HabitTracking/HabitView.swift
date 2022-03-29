//
//  HabitView.swift
//  HabitTracking
//
//  Created by yomizzz on 2022/3/29.
//

import SwiftUI

struct HabitView: View { // 每个 habit 的详情页
    let habit: HabitItem
    @ObservedObject var habits: Habits
    
    //@State private var count = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(habit.title)
                    .font(.title.bold())
                    .padding(.bottom, 5)
                
                Text("Description: \(habit.description)")
                    .padding(.bottom, 5)
                
                Text("Completing Counts: \(habit.count)")
                
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Button("Finished!") {
                let item = HabitItem(title: habit.title, description: habit.description, count: habit.count + 1)
                let index = habits.items.firstIndex(of: habit) // 点击增加完成次数后，避免条目的增加
                habits.items[index ?? 0] = item
                //habits.items.append(item) // 每次点击，虽然完成次数增加了1次，但条目也增加了1条
                
            }
            .font(.title)
            .frame(width: 150, height: 50)
            .foregroundColor(.white)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habit: HabitItem(title: "Study Code", description: "Learning SwiftUI SwiftUI SwiftUI SwiftUI SwiftUI"), habits: Habits())
    }
}
