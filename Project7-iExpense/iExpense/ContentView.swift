//
//  ContentView.swift
//  iExpense
//
//  Created by yomizzz on 2022/2/26.
//

import SwiftUI

/*
class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}
*/

/*
 // showing and hiding views - how to use sheet
struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}
 */

// archiving Swift objects with Codable
struct User: Codable {
    let firstName: String
    let lastName: String
}


struct ContentView: View {
    //@StateObject var user = User()
    //@State private var showingSheet = false
    /*
    // delete items using onDelete()
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
     */
    
    /*
    // storing user settings with UserDefaults
    //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0
    */
    
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        /*
        // showing SwiftUI state with @StateObject
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
         */
        
        /*
        // showing and hiding views - how to use sheet
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            // contents of the sheet
            SecondView()
        }
         */
        
        /*
         // delete items using onDelete()
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
            }
        }
         */
        
        /*
        // storing user settings with UserDefaults
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            //UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
         */
        
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
