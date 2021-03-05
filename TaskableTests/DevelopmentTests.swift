//
//  DevelopmentTests.swift
//  TaskableTests
//
//  Created by Rui Silva on 23/02/2021.
//

import CoreData
import XCTest
@testable import Taskable

class DevelopmentTests: TaskableTests {
    func testSampleDataCreationWorks() throws {
        try dataController.createSampleData()
        
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5, "There should be 5 sample Projects")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 25, "There should be 25 sample Items")
    }
    
    func testDeleteAllClearsEverything() throws {
        try dataController.createSampleData()
        
        dataController.deleteAll()
        
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0, "There should be 0 Projects after delete All")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "There should be 0 Items after delete All")
    }
    
    func testExampleIsClosed() {
        let project = Project.example
        
        XCTAssertTrue(project.closed, "The example project should be closed")
    }
    
    func testExampleItemIsHighPriority() {
        let item = Item.example
        
        XCTAssertEqual(item.priority, 3, "The example item should be high priority")
    }
}
