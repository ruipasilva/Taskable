//
//  HomeView.swift
//  Taskable
//
//  Created by Rui Silva on 01/02/2021.
//

import CoreData
import SwiftUI

struct HomeView: View {
    
    static let tag: String? = "Home"
    
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: true)], predicate: NSPredicate(format: "closed = false")) var projects: FetchedResults<Project>
    
    let items: FetchRequest<Item>
    
    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }
    
    init() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "completed = false")
        
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.priority, ascending: false)
        ]
        
        request.fetchLimit = 10
        items = FetchRequest(fetchRequest: request)
    }
    
//    var toolBarItemTrailing: some ToolbarContent {
//        ToolbarItem(placement: .navigationBarTrailing) {
//            HStack {
//                Button {
//                    try?dataController.createSampleData()
//                } label: {
//                    Text("Button")
//                        .padding(.horizontal, 4)
//                }
//            }
//        }
//    }

    
    var body: some View {
        NavigationView {
            if _projects.wrappedValue.isEmpty {
                HomeEmptyView()
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: projectRows) {
                                ForEach(projects) { project in
                                    ProjectSummaryView(project: project)
                                }
                            }
                            .padding([.horizontal, .top])
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        VStack(alignment: .leading) {
                            ItemListView(title: "Up next", items: items.wrappedValue.prefix(3))
                            ItemListView(title: "More to explore", items: items.wrappedValue.dropFirst(3))
                        }
                        .padding(.horizontal)
                    }
                }
                .background(Color.systemGroupedBackground.ignoresSafeArea())
                .navigationTitle("Home")
//                .toolbar {
//                    toolBarItemTrailing
//                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//Button("Add Tasks") {
//    dataController.deleteAll()
//    try? dataController.createSampleData()
//}
