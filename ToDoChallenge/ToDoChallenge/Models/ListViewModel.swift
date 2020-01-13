//
//  ListViewModel.swift
//  ToDoChallenge
//
//  Created by Keaton Swoboda on 1/8/20.
//  Copyright © 2020 Keaton Swoboda. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift

class ToDoList: Object {
    @objc dynamic var name = ""
    let tasks: List<String> = List<String>()
}

class ListViewModel {
    let service = ToDoService()
    var toDoLists: [ToDoList]
        
    var cellCount: Int {
        return toDoLists.count
    }
    
    var sectionCount: Int {
        return 1
    }
    
    var navTitle: String { return "Lists" }
    var rightBarButtonTitle: String { return "Add List" }
    var alertTitle: String { return "Add List" }
    var alertTextFieldPlaceHolder: String { return "List Name" }
    var alertAddTitle: String { return "Add" }
    var alertCancelTitle: String { return "Cancel" }
    var tintColor: UIColor { return .white}
    
    func addToList(_ name: String) {
        service.addList(named: name)
        toDoLists = service.retrieveToDos()
    }
    
    func deleteList(at row: Int) {
        service.deleteList(toDoList: toDoLists[row])
        toDoLists.remove(at: row)
    }
    
    func viewModel(row: Int) -> ToDoListViewModel {
        return ToDoListViewModel(todoList: toDoLists[row], service: service)
    }
    
    init() {
        self.toDoLists = service.retrieveToDos()
    }
}
