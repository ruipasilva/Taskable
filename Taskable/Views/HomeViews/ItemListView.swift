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
                .font(.headline)
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
        VStack(alignment: .leading) {
            Text(item.itemTitle)
                .font(.title2)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if item.itemDetail.isEmpty == false {
                Text(item.itemDetail)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
            }
            HStack {
                Image(systemName: "circle.fill")
                    .font(.caption)
                    .foregroundColor(Color(item.project?.projectColor ?? "grey"))
                Text(item.project?.projectTitle ?? "No Project")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
        .padding()
        .background(Color.secondaryGroupedBackground)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5)
    }
}
