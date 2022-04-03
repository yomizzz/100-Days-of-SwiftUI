//
//  BookwormApp.swift
//  Bookworm
//
//  Created by yomizzz on 2022/4/3.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) // step 3: prepared the Core Data model for use with SwiftUI
        }
    }
}
