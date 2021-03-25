//
//  ProjectEditView.swift
//  Taskable
//
//  Created by Rui Silva on 02/02/2021.
//

import SwiftUI

struct ProjectEditView: View {
    
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
            Section {
                TextField("Project name", text: $title)
                    .modifier(TextFieldClearButton(text: $title))
            }
            Section(header: Text("Notes")) {
                TextEditor(text: $detail)
                    .modifier(TextFieldClearButton(text: $detail))
            }
            
            Section(header: Text("Project Color")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self) { item in
                        colorButton(for: item)
                    }
                }
                .padding(.vertical, 4)
                .onTapGesture(perform: { dataController.save()} )
            }
            Section(footer: Text("Closing a project moves it from Open to Closed; deleting it removes the project entirely.")) {
                Button(project.closed ? "Reopen project" : "Archive project") {
                    project.closed.toggle()
                    update()
                }
                .foregroundColor(.blue)
                Button("Delete project") {
                    showingDeleteConfirmation.toggle()
                }
                .accentColor(.red)
            }
        }
        .navigationBarTitle("Edit Project", displayMode: .inline)
        .onDisappear(perform: {update()})
            .alert(isPresented: $showingDeleteConfirmation) {
                Alert(title: Text("Delete Project?"), message: Text("Are you sure you want to delete this project? You will also delete all the items it contains."), primaryButton: .destructive(Text("Delete"), action: delete), secondaryButton: .cancel())
            }
    }
    func update() {
        project.objectWillChange.send()
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

struct ProjectEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectEditView(project: Project.example)
    }
}
