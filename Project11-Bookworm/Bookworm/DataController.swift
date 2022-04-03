//
//  DataController.swift
//  Bookworm
//
//  Created by yomizzz on 2022/4/3.
//

import CoreData
import SwiftUI

class DataController: ObservableObject { // step 2: loaded the Core Data model
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
