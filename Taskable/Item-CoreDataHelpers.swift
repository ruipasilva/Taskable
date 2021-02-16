//
//  Item-CoreDataHelpers.swift
//  Taskable
//
//  Created by Rui Silva on 01/02/2021.
//

import Foundation

extension Item {
    
    enum SortOrder {
        case optimised, title, creationDate
    }
    
    var itemTitle: String {
        title ?? NSLocalizedString("New Item", comment: "Vreate a new item")
    }
    
    var itemDetail: String {
        detail ?? ""
    }
    
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    
    static var example: Item {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let item = Item(context: viewContext)
        item.title = "Example Item"
        item.detail = "Example detail"
        item.priority = 3
        item.creationDate = Date()
        
        return item
    }
}
