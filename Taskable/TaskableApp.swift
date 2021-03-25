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
                // swiftUI to read coreData Values
                .environment(\.managedObjectContext, dataController.container.viewContext)
                // our own code to read coreData values - whatever we did by hand, saving, writing, etc
                .environmentObject(dataController)
                // Automatically save when we detect that we are no longer the foreground app.
                // Use this rather then the scene phase API so we can port to macOS, where scene phase
                // won't detect our app losing focus as of macOS 11.1.
                .onReceive(NotificationCenter.default.publisher(for:UIApplication.willResignActiveNotification), perform: save)
        }
    }
    func save(_ note: Notification) {
        dataController.save()
    }
}
