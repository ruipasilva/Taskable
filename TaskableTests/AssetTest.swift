//
//  AssetTest.swift
//  TaskableTests
//
//  Created by Rui Silva on 22/02/2021.
//

import XCTest
@testable import Taskable

class AssetTest: XCTestCase {
    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from asset catalog")
        }
    }
    
    func testJSONLoadCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load awards from JSON")
    }
}
