//
//  ItemRowView.swift
//  Taskable
//
//  Created by Rui Silva on 02/02/2021.
//

import SwiftUI

struct ItemRowView: View {
    
    @ObservedObject var item: Item
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var title: String
    
    init(item: Item) {
        self.item = item
        _title = State(wrappedValue: item.itemTitle)
    }
    
    var icon: some View {
        if item.completed {
            return Image(systemName: "checkmark.circle.fill")
                .foregroundColor(Color(item.project?.projectColor ?? "Light Blue").opacity(1))
            
        } else {
            return Image(systemName: "circle")
                .foregroundColor(.secondary)
        }
    }
    
    var label: Text {
        if item.completed {
            return Text("\(item.itemTitle), Completed")
        } else if item.priority == 3 {
            return Text("\(item.itemTitle), High Priority")
        } else if item.priority == 2 {
            return Text("\(item.itemTitle), Medium Priority")
        } else if item.priority == 1 {
            return Text("\(item.itemTitle), Low Priority")
        } else {
            return Text("\(item.itemTitle)")
        }
    }
    
    var body: some View {
        NavigationLink(destination: ItemEditView(item: item)) {
            Label {
                Text(item.itemTitle)
            } icon: {
                icon
                    .font(.title2)
                    .onTapGesture(perform: {
                    item.completed.toggle()
                        update()
                    })
                    .onAppear(perform: {
                        update()
                    })
            }
            
        }
        .accessibilityLabel(label)
    }
    
    func update() {
        withAnimation {
        item.project?.objectWillChange.send()
        item.title = title
        dataController.save()
        }
    }
}

//struct ItemRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemRowView(item: Item.example)
//    }
//}
