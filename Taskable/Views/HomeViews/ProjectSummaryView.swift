//
//  ProjectSummaryView.swift
//  Taskable
//
//  Created by Rui Silva on 17/02/2021.
//

import SwiftUI

struct ProjectSummaryView: View {
    
    @ObservedObject var project: Project
    
    var body: some View {
        NavigationLink(destination: ProjectOverview(project: project)) {
            VStack(alignment: .leading) {
                Text("\(project.projectItems.count) items")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(project.projectTitle)
                    .font(.title2)
                    .foregroundColor(.primary)
                
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }
            .padding()
            .background(Color.secondaryGroupedBackground)
            .cornerRadius(10)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(project.label)
        }
    }
}

struct ProjectSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSummaryView(project: Project.example)
    }
}
