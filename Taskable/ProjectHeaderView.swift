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
        VStack {
            HStack {
                Text(project.projectTitle)
                
                ProgressView(value: project.completionAmount)
                    .padding(.trailing)
                    .accentColor(Color(project.projectColor))
        
                NavigationLink(destination: ProjectEditView(project: project)) {
                    Image(systemName: "pencil")
                        .font(.title3)
                        .padding(.vertical)
                }
            }
        }
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
