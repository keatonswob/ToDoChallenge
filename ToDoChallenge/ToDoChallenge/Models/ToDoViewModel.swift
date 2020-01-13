//
//  ToDoViewModel.swift
//  ToDoChallenge
//
//  Created by Keaton Swoboda on 1/9/20.
//  Copyright © 2020 Keaton Swoboda. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol ToDoListViewModelDelegate: class {
    func toDoAlertDidClose()
}

final class ToDoListViewModel {
    var toDoList: ToDoList
    let service: ToDoService
    
    weak var delegate: ToDoListViewModelDelegate?
    
    var cellCount: Int {
           return items.count
       }
    
    var sectionCount: Int {
           return 1
       }
    
    var rightBarButtonTitle: String { return "Add Task" }
    var alertTitle: String { return "Add Task" }
    var alertTextFieldPlaceHolder: String { return "Task Name" }
    var alertAddTitle: String { return "Add" }
    var alertCancelTitle: String { return "Cancel" }
    
    var editAlertTitle: String { return "Edit or delete" }
    var editAlertSaveText: String { return "Save" }
    var editAlertDeleteText: String { return "Delete" }
    var editAlertCancelText: String { return "Cancel" }
    var tintColor: UIColor { return .white }
    func addToList(_ name: String) {
        service.addTasks(to: toDoList, name: name)
        items.append(name)
    }
    
    func deleteTask(at row: Int) {
        service.deleteTask(from: toDoList, row: row)
        self.items.remove(at: row)
        delegate?.toDoAlertDidClose()
    }
    
    func updateTask(at row: Int, text: String) {
        service.updateTask(toDoList: toDoList, row: row, name: text)
        self.items[row] = text
        delegate?.toDoAlertDidClose()
    }
    
    var title: String
    var items: [String]
    
    init(todoList: ToDoList, service: ToDoService) {
        self.toDoList = todoList
        self.service = service
        self.title = todoList.name
        self.items = Array(todoList.tasks)
    }
}
