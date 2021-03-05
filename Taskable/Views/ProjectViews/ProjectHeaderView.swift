//
//  ProjectHeaderView.swift
//  Taskable
//
//  Created by Rui Silva on 02/02/2021.
//

import SwiftUI

struct ProjectHeaderView: View {
    
    @ObservedObject var project: Project
    
    @State private var isExpanded = false
    
    var body: some View {
        NavigationLink(destination: ProjectEditView(project: project)) {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(project.projectTitle)
                            .foregroundColor(.primary)
                            .font(.body)
                            .fontWeight(.bold)
                        Text("\(project.projectItems.count) items")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "info.circle")
                        .font(.headline)
                }
                ProgressView(value: project.completionAmount)
                    
                    .accentColor(Color(project.projectColor))
                
            }
        }
        .padding()
        .accessibilityLabel(project.label)
        .accessibilityElement(children: .combine)
    }
}
struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
