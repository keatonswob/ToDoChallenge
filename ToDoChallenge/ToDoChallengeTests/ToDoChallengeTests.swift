//
//  ToDoChallengeTests.swift
//  ToDoChallengeTests
//
//  Created by Keaton Swoboda on 1/7/20.
//  Copyright © 2020 Keaton Swoboda. All rights reserved.
//

import XCTest
@testable import ToDoChallenge
import Realm
import RealmSwift

class ToDoChallengeTests: XCTestCase {
    let service = ToDoService()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testAddingToDoList() {
        service.addList(named: "Test List")
        let toDoLists = service.retrieveToDos()
        XCTAssertTrue(toDoLists.first(where: { $0.name == "Test List" }) != nil)
    }
    
    func testDeleteToDoLists() {
        service.addList(named: "Test Delete")
        let todoLists = service.retrieveToDos()
        guard let deleteList = todoLists.first(where: { $0.name == "Test Delete" }) else { return }
        service.deleteList(toDoList: deleteList)
        let afterToDoLists = service.retrieveToDos()
        XCTAssertTrue(afterToDoLists.first(where: { $0.name == "Test Delete" }) == nil)
    }
    
}
