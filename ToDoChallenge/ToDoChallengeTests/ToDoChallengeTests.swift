//
//  ToDoChallengeTests.swift
//  ToDoChallengeTests
//
//  Created by Keaton Swoboda on 1/7/20.
//  Copyright © 2020 Keaton Swoboda. All rights reserved.
//

import XCTest
@testable import ToDoChallenge


class ToDoChallengeTests: XCTestCase {
    let service = ToDoService()

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
