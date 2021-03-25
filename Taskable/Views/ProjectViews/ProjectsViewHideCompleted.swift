//
//  ProjectsView.swift
//  Taskable
//
//  Created by Rui Silva on 01/02/2021.
//

import SwiftUI
import UIKit

struct PProjectsViewHideCompleted: View {
    
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    let showClosedProjects: Bool
    
    @StateObject var project = Project()
    
    @State private var isShowingClosedTasks = false
    @State private var isShowingSortOptions = false
    @State private var sortOrder = Item.SortOrder.optimised
    @State private var filteredText = ""
    @State private var showingCompleted = false
    
    let filteredItems = Project.self
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }
    
    var projectsList: some View {
        List {
            //.filter... to add to future searchBar
            ForEach(projects.wrappedValue.filter({filteredText.isEmpty ? true : $0.projectTitle.localizedCaseInsensitiveContains(filteredText)})) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: sortOrder)) { item in
                        ItemRowView(item: item)
                            .foregroundColor(.primary)
                    }
                    
                    .onDelete { offsets in
                        delete(offsets, from: project)
                    }
                    Button {
                        addItem(to: project)
                    }label: {
                        Text("Add Item")
                            .padding(.leading, 2)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    var toolBarItemTrailing: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button(action: {
                    showingCompleted.toggle()
                }) {
                    Text(showingCompleted ? "Show Completed" : "Hide Completed")
                }
                .disabled(projects.wrappedValue.isEmpty)
                
                Button {
                    isShowingSortOptions.toggle()
                } label: {
                    Text("Sort")
                        .padding(.horizontal, 4)
                }
                .disabled(projects.wrappedValue.isEmpty)
                
                Button(action: addProject) {
                    // In iOS 14.3 VoiceOver has a glitch that reads the label "Add Project as "Add"
                    // no matter what accessibility label we give this toolbar button when using a label
                    // As a result, when VoiceOver is running, we use a text view for the button instead,
                    // forcing a correct reading wuthout losing the original layout.
                    if UIAccessibility.isVoiceOverRunning {
                        Text("Add Project")
                    } else {
                        Label("Add Project", systemImage: "plus")
                    }
                }
                
            }
        }
    }
    
    var toolbarItemLeading: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                self.isShowingClosedTasks.toggle()
            }) {
                Image(systemName: "archivebox")
            }.sheet(isPresented: $isShowingClosedTasks) {
                ClosedProjectsView(showClosedProjects: true)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if projects.wrappedValue.isEmpty {
                    ProjectsEmptyView()
                } else  if showingCompleted == true {
                    projectsList
                } else if showingCompleted == false {
                    projectsList
                }
            }
            .navigationTitle("Projects")
            .toolbar {
                toolBarItemTrailing
                toolbarItemLeading
            }
        }
        .actionSheet(isPresented: $isShowingSortOptions) {
            ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                .default(Text("Priority")) { sortOrder = .optimised },
                .default(Text("Creation Date")) { sortOrder = .creationDate },
                .default(Text("Title")) { sortOrder = .title },
                .cancel()
            ])
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func delete() {
        dataController.delete(project)
    }
    
    func save() {
        dataController.save()
    }
    
    func addProject() {
        withAnimation {
            let project = Project(context: managedObjectContext)
            project.closed = false
            project.creationDate = Date()
            dataController.save()
        }
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
        withAnimation {
        let allItems = project.projectItems(using: sortOrder)
        
        for offset in offsets {
            let item = allItems[offset]
            dataController.delete(item)
        }
        dataController.save()
        }
    }
    
    func search() {
    }
    
    func cancel() {
    }
    
}

struct ProjectsViewHideCompleted_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
    }
}
//TextField("Type to Filter", text: $filteredText)

//.filter({filteredText.isEmpty ? true : $0.projectTitle.localizedCaseInsensitiveContains(filteredText)})
