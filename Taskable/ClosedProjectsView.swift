//
//  ClosedProjectsView.swift
//  Taskable
//
//  Created by Rui Silva on 03/02/2021.
//

import SwiftUI

struct ClosedProjectsView: View {
    
    let showClosedProjects: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    let projects: FetchRequest<Project>
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)], predicate: NSPredicate(format: "closed = %d", showClosedProjects))  }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(project.projectItems) { item in
                            ItemRowView(item: item)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Closed Tasks", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ClosedProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ClosedProjectsView(showClosedProjects: true)
    }
}
