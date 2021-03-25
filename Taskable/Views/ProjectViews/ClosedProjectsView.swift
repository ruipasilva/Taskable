//
//  ClosedProjectsView.swift
//  Taskable
//
//  Created by Rui Silva on 03/02/2021.
//

import SwiftUI

struct ClosedProjectsView: View {
    
    let showClosedProjects: Bool
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }
    var body: some View {
        
        if projects.wrappedValue.isEmpty {
            ClosedProjectsEmptyView()
        } else {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(project.projectItems) { item in
                            ItemRowView(item: item)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Archive", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .accentColor(Color("Tint"))
    }
    }
}

struct ClosedProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ClosedProjectsView(showClosedProjects: true)
    }
}
