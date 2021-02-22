//
//  HomeEmptyView.swift
//  Taskable
//
//  Created by Rui Silva on 15/02/2021.
//

import SwiftUI

struct HomeEmptyView: View {
    
    @EnvironmentObject var dataController: DataController
    
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
        Text("Please add projects and items to find more info here.")
            .italic()
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .toolbar {
                toolBarItemTrailing
            }
    }
}
