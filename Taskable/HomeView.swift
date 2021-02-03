//
//  HomeView.swift
//  Taskable
//
//  Created by Rui Silva on 01/02/2021.
//

import SwiftUI

struct HomeView: View {
    
    static let tag: String? = "Home"
    
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add Tasks") {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                }
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem {

                        Menu {
                            Section {
                            Button(action: { }) {
                                Text("Optimised")
                            }
                            }
                            Button(action: { }) {
                                Text("Date")
                            }
                            Button(action: { }) {
                                Text("Title")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
