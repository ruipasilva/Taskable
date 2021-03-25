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
    
    @State private var title: String
    
    init(project: Project) {
        self.project = project
        _title = State(wrappedValue: project.projectTitle)
    }
    
    
    var projectHeader: some View {
        HStack {
            ProgressView(value: project.completionAmount)
                .progressViewStyle(GaugeProgressStyle(project: project))
                .accentColor(Color(project.projectColor))
                .frame(width: 20, height: 20)
                .padding(.trailing, 6)
            VStack(alignment: .leading) {
                TextField("Title", text: $title.onChange(update))
                    .font(.title)
                    .foregroundColor(.primary)
                
                Text("\(project.projectItems.count) items")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(project.label)
        .padding(.bottom, 1)
        
    }
    
    var projectOverviewList: some View {
        VStack {
            List {
                ForEach (project.projectItems(using: sortOrder)) { item in
                    NavigationLink(destination: ItemEditView(item: item)) {
                        Label {
                            Text("\(item.title ?? "New Item")")
                        } icon : {
                            if item.completed == true {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(Color(item.project?.color ?? "Light Blue").opacity(1))
                                    .padding(.trailing, 1)
                            } else {
                                Image(systemName: "circle")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(.secondary)
                                    .padding(.trailing, 1)
                            }
                        }
                        
                        .onTapGesture(perform: {
                            withAnimation {
                                item.project?.objectWillChange.send()
                                item.completed.toggle()
                                dataController.save()
                            }
                        })
                        }
                }
                .onDelete { offsets in
                    delete(offsets, from: project)
                }
                Button {
                    addItem(to: project)
                } label: {
                    Text("Add Item")
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
    
    func update() {
        project.objectWillChange.send()
        project.title = title
        dataController.save()
    }
}

struct ProjectOverview_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOverview(project: Project.example)
    }
}
