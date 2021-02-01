 //
//  TaskableApp.swift
//  Taskable
//
//  Created by Rui Silva on 01/02/2021.
//

import SwiftUI

@main
struct TaskableApp: App {
    
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) // swiftUI to read coreData Values
                .environmentObject(dataController) // our own code to read coreData values - whatever we did by hand, saving, writing, etc
        }
    }
}
