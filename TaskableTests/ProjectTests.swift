//
//  ProjectTests.swift
//  TaskableTests
//
//  Created by Rui Silva on 23/02/2021.
//

import CoreData
import XCTest
@testable import Taskable

class ProjectTests: TaskableTests {

    func testCreatingProjectsAndItems() {
        let targetCount = 10
        
        for _ in 0..<targetCount {
            let project = Project(context: managedObjectContext)
            
            for _ in 0..<targetCount {
                let item = Item(context: managedObjectContext)
                item.project = project
            }
        }
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), targetCount)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), targetCount * targetCount)
    }
    func testDeletingProjectCascadeItem() throws {
        try dataController.createSampleData()
        
        let request = NSFetchRequest<Project>(entityName: "Project")
        let projects = try managedObjectContext.fetch(request)
        
        dataController.delete(projects[0])
        
        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 4)
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 20)
    }
}
