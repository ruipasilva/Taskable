//
//  ProjectHeaderView.swift
//  Taskable
//
//  Created by Rui Silva on 02/02/2021.
//

import SwiftUI

struct ProjectHeaderView: View {
    
    @ObservedObject var project: Project
    
    var body: some View {
        NavigationLink(destination: ProjectEditView(project: project)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(project.projectTitle)
                        .foregroundColor(.secondary)
                    
                    ProgressView(value: project.completionAmount)
                        .padding(.trailing)
                        .accentColor(Color(project.projectColor))
                    
                }
                Image(systemName: "pencil")
                    .imageScale(.large)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .accessibilityElement(children: .combine)
    }
}
struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
