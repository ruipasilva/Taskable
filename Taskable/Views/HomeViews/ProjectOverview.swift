//
//  ProjectOverview.swift
//  Taskable
//
//  Created by Rui Silva on 01/03/2021.
//

import SwiftUI

struct ProjectOverview: View {
    
    @ObservedObject var project: Project
    
    @State private var sortOrder = Item.SortOrder.optimised
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var dataController: DataController
    
    var projectHeader: some View {
        VStack(alignment: .leading) {
            Text(project.projectTitle)
                .font(.title)
                .foregroundColor(.primary)
            
            Text("\(project.projectItems.count) items")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text("\(project.projectDetail)")
                .padding(.top, 2)
            
            ProgressView(value: project.completionAmount)
                .accentColor(Color(project.projectColor))
        }
        .padding()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(project.label)
        .padding(.bottom, 1)
    }
    
    var projectOverviewList: some View {
        VStack {
            List {
                ForEach (project.projectItems(using: sortOrder)) { items in
                    HStack {
                        if items.completed == true {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(Color(items.project?.color ?? "Light Blue").opacity(1))
                                .shadow(color: Color.black.opacity(0.2), radius: 5)
                                .padding(.trailing, 1)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(Color(items.project?.color ?? "Light Blue").opacity(1))
                                .shadow(color: Color.black.opacity(0.2), radius: 5)
                                .padding(.trailing, 1)
                        }
                        Text("\(items.title ?? "New Item")")
                    }
                }
                .onDelete { offsets in
                    delete(offsets, from: project)
                }
                Button {
                    addItem(to: project)
                } label: {
                    Label("Add New Item", systemImage: "plus")
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            projectHeader
            projectOverviewList
        }
        .padding(.top)
        .background(Color.systemGroupedBackground.ignoresSafeArea())
        .navigationBarTitle("Project Overview", displayMode: .inline)
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
    
    func addItem(to project: Project) {
        withAnimation {
            let item = Item(context: managedObjectContext)
            item.project = project
            item.creationDate = Date()
            dataController.save()
        }
    }
    
    func delete(_ offsets: IndexSet, from project: Project) {
        let allItems = project.projectItems(using: sortOrder)
        
        for offset in offsets {
            let item = allItems[offset]
            dataController.delete(item)
        }
        dataController.save()
    }
}

struct ProjectOverview_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOverview(project: Project.example)
    }
}
