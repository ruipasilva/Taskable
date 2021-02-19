//
//  NewProjectView.swift
//  Taskable
//
//  Created by Rui Silva on 03/02/2021.
//

import SwiftUI

struct NewProjectView: View {
    
    let project: Project
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
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
            Section(header: Text("Basic Settings")) {
                TextField("Project Name", text: $title.onChange(update))
                TextField("Project Description", text: $detail.onChange(update))
            }
            
            Section(header: Text("Project Color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self) { item in
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
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Edit Project")
        .onDisappear(perform: dataController.save)
        .toolbar {
            ToolbarItem {
                Button {
                    presentationMode.wrappedValue.dismiss()
                    withAnimation {
                        let project = Project(context: managedObjectContext)
                        project.closed = false
                        project.creationDate = Date()
                        dataController.save()
                    }
                } label: {
                    Text("Done")
                }
            }
        }

    }
    
    func update() {
        project.title = title
        project.detail = detail
        project.color = color
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectView(project: Project.example)
    }
}
