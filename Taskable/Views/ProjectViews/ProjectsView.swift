//
//  ProjectsView.swift
//  Taskable
//
//  Created by Rui Silva on 01/02/2021.
//

import SwiftUI

struct ProjectsView: View {
    
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    let showClosedProjects: Bool

    @State private var isShowingClosedTasks = false
    @State private var isShowingSortOptions = false
    @State private var itemsAreExpanded = false
    
    @State private var sortOrder = Item.SortOrder.optimised
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProjects))  }
    
    var projectsList: some View {
        List {
            ForEach(projects.wrappedValue) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: sortOrder)) { item in
                        ItemRowView(item: item)
                    }
                    .onDelete { offsets in
                        delete(offsets, from: project)
                    }
                    Button {
                        addItem(to: project)
                    }label: {
                        Label("Add New Item", systemImage: "plus")
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    var toolBarItemTrailing: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button {
                    isShowingSortOptions.toggle()
                } label: {
                    Text("Sort")
                        .padding(.horizontal, 4)
                }
                Button(action: addProject) {
                    // In iOS 14.3 VoiceOver has a glitch that reads the label "Add Project as "Add"
                    // no matter what accessibility label we give this toobal button when using a label
                    // As a result, when VoiceOver is running, we use a text view for the button isntead,
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
            }}
    }
    
    var body: some View {
        NavigationView {
            Group {
                if projects.wrappedValue.isEmpty {
                    ProjectsEmptyView()
                } else {
                    projectsList
                }
            }
            .navigationTitle(showClosedProjects ? "Closed Tasks" : "Tasks")
            .toolbar {
                toolBarItemTrailing
                toolbarItemLeading
            }
            .actionSheet(isPresented: $isShowingSortOptions) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Priority")) { sortOrder = .optimised },
                    .default(Text("Creation Date")) { sortOrder = .creationDate },
                    .default(Text("Title")) { sortOrder = .title },
                    .cancel()
                ])
            }
            ProjectsEmptyView()
            
        }
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
        let allItems = project.projectItems(using: sortOrder)
        
        for offset in offsets {
            let item = allItems[offset]
            dataController.delete(item)
        }
        dataController.save()
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
    }
}
