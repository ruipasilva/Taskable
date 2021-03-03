//
//  ProjectOverview.swift
//  Taskable
//
//  Created by Rui Silva on 01/03/2021.
//

import SwiftUI

struct ProjectOverview: View {
    
    @ObservedObject var project: Project
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var dataController: DataController
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    
    
    @State private var showingDeleteConfirmation = false
    
    let colorColumns = [
        GridItem(.adaptive(minimum: 44))
    ]
    
    init(project: Project) {
        self.project = project
        
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
        
    }
    
    var body: some View {
        Form {
                List {
                    ForEach(project.projectItems) { items in
                        Text("\(items.title ?? "New Item")")
                    }
                }
            
        }
        .background(Color.systemGroupedBackground.ignoresSafeArea())
        .navigationBarTitle("Project Overview", displayMode: .inline)
        .onDisappear(perform: update)
        
    }
    func update() {
        project.title = title
        project.detail = detail
        project.color = color
        dataController.save()
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
    
    func colorButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(10)
            
            if item == color {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        .onTapGesture {
            color = item
            update()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(
            item == color ? [.isButton, .isSelected] : .isButton
        )
        .accessibilityLabel(LocalizedStringKey(item))
    }
}

struct ProjectOverview_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOverview(project: Project.example)
    }
}
