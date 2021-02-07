//
//  ItemRowView.swift
//  Taskable
//
//  Created by Rui Silva on 02/02/2021.
//

import SwiftUI

struct ItemRowView: View {
    
    @ObservedObject var project: Project
    @ObservedObject var item: Item
    
    var icon: some View {
        if item.completed {
            return Image(systemName: "checkmark.circle")
                .foregroundColor(Color(project.projectColor))
        } else if item.priority == 3 {
            return Image(systemName: "exclamationmark.octagon")
                .foregroundColor(.red)
        } else if item.priority == 2 {
            return Image(systemName: "exclamationmark.triangle")
                .foregroundColor(.yellow)
        } else if item.priority == 1 {
            return Image(systemName: "exclamationmark.circle")
                .foregroundColor(.green)
        } else {
            return Image(systemName: "checkmark")
                .foregroundColor(.clear)
        }
    }
    
    var body: some View {
        NavigationLink(destination: ItemEditView(item: item)) {
            Label {
                Text(item.itemTitle)
            } icon: {
                icon.font(.title3)
            }
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(project: Project.example, item: Item.example)
    }
}
