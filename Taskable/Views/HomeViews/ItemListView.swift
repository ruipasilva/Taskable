//
//  ItemListView.swift
//  Taskable
//
//  Created by Rui Silva on 17/02/2021.
//

import SwiftUI

struct ItemListView: View {
    
    let title: LocalizedStringKey
    let items: FetchedResults<Item>.SubSequence
    
    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            Text(title)
                .font(.title3)
                .foregroundColor(.secondary)
                .padding(.top)
            ForEach(items) { item in
                NavigationLink(destination: ItemEditView(item: item)) {
                    itemsList(item: item)
                }
            }
        }
    }
    
    func itemsList(item: Item) -> some View {
        HStack {
            VStack {
                Image(systemName: "circle.fill")
                    .font(.caption)
                    .foregroundColor(Color(item.project?.projectColor ?? "grey"))
                    .unredacted()
            }
            VStack(alignment: .leading) {
                Text(item.itemTitle)
                    .font(.title2)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(item.project?.projectTitle ?? "No Project")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.trailing)
            }
            Spacer()
        }
        .padding()
        .background(Color.secondaryGroupedBackground)
        .cornerRadius(10)
    }
}
