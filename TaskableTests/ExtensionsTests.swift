//
//  ExtensionsTests.swift
//  TaskableTests
//
//  Created by Rui Silva on 24/02/2021.
//

import XCTest
@testable import Taskable

class ExtensionsTests: XCTestCase {
    func testSequenceKeyPathSortingSelf() {
        let items = [1, 4, 5, 3, 2]
        let sortedItems = items.sorted(by: \.self)
        
        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "The sorted numbers must be ascending")
    }
    
    func testSequenceDescending() {
        let items = ["a", "c", "t", "x", "z"]
        let sortedItems = items.sorted(by: >)
        
        XCTAssertEqual(sortedItems, ["z", "x", "t", "c", "a"], "The sort order must be descending")
    }
}
