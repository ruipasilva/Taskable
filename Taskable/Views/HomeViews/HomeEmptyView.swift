//
//  HomeEmptyView.swift
//  Taskable
//
//  Created by Rui Silva on 15/02/2021.
//

import SwiftUI

struct HomeEmptyView: View {
    
    @EnvironmentObject var dataController: DataController
    
    /// This trailing app adds a button that creates sample data for testing
    var toolBarItemTrailing: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button("Add Data") {
                    try?dataController.createSampleData()
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image("empty_state_overview")
                    .padding(.bottom, 20)
                Text("Your progress will appear here once you add Projects and Items.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(width: 260, alignment: .center)
                    .multilineTextAlignment(.center)     
            }
            .offset(y: -20)
            .navigationTitle("Overview")
        }
    }
}
