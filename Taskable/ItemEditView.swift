//
//  ItemEditView.swift
//  Taskable
//
//  Created by Rui Silva on 02/02/2021.
//

import SwiftUI

struct ItemEditView: View {
    
    let item: Item
    
    @EnvironmentObject var dataController: DataController //access to data controller to save changes as needed
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool
    
    init(item: Item) {
        self.item = item
        
        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
    }
    
    var body: some View {
        
            Form {
                Section(header: Text("Basic Settings")) {
                    
                    TextField("Item name", text: $title.onChange(update))
                    TextField("Description", text: $detail.onChange(update))
                }
                Section(header: Text("Priority")) {
                    Picker("Priority", selection: $priority.onChange(update)) {
                        Text("Low").tag(1)
                        Text("Medium").tag(2)
                        Text("High").tag(3)
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section() {
                    Toggle("Mark Completed", isOn: $completed.onChange(update))
                }
            }
            .navigationTitle("Edit Item")
            .onDisappear(perform: dataController.save)
            .toolbar {
                ToolbarItem {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
    }
    
    func update() {
        item.project?.objectWillChange.send()
        
        item.title = title
        item.detail = detail
        item.priority = Int16(priority)
        item.completed = completed
    }
}

struct ItemEditView_Previews: PreviewProvider {
    static var previews: some View {
        ItemEditView(item: Item.example)
    }
}
