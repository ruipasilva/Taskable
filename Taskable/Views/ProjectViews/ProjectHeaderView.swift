//
//  ProjectHeaderView.swift
//  Taskable
//
//  Created by Rui Silva on 02/02/2021.
//

import SwiftUI

struct ProjectHeaderView: View {
    
    @ObservedObject var project: Project
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var isExpanded = false
    
    @State var completion: Double
    
    init(project: Project) {
        self.project = project
        _completion = State(wrappedValue: project.completionAmount)
    }
    
    var body: some View {
        HStack {
                ProgressView(value: project.completionAmount)
                    .progressViewStyle(GaugeProgressStyle(project: project))
                    .accentColor(Color(project.projectColor))
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 6)
            NavigationLink(destination: ProjectEditView(project: project)) {
                HStack {
                    
                    Text(project.projectTitle)
                        .foregroundColor(.primary)
                        .font(.body)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "info.circle")
                        .font(.headline)
                }
            }
        }
        .padding()
        .accessibilityLabel(project.label)
        .accessibilityElement(children: .combine)
    }
    
    func update() {
        dataController.save()
    }
    
}
struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
