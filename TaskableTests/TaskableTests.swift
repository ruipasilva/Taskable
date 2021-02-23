//
//  TaskableTests.swift
//  TaskableTests
//
//  Created by Rui Silva on 22/02/2021.
//

import CoreData
import XCTest
@testable import Taskable

class TaskableTests: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
