//
//  ToDoService.swift
//  ToDoChallenge
//
//  Created by Keaton Swoboda on 1/9/20.
//  Copyright © 2020 Keaton Swoboda. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class ToDoService {
    private let realm = try! Realm()
    
    func retrieveToDos() -> [ToDoList] {
        let toDoListResults = realm.objects(ToDoList.self)
        let toDoLists = Array(toDoListResults)
        return toDoLists
    }
    
    func addList(named: String) {
        let toDoList = ToDoList()
        toDoList.name = named
        try! realm.write {
            realm.add(toDoList)
        }
    }
    
    func deleteList(toDoList: ToDoList) {
        try! realm.write {
            realm.delete(toDoList)
        }
    }
    
    func addTasks(to toDoList: ToDoList, name: String) {
        try! self.realm.write {
            toDoList.tasks.append(name)
        }
    }
    
    func deleteTask(from toDoList: ToDoList, row: Int) {
        try! self.realm.write {
            toDoList.tasks.remove(at: row)
        }
    }
    
    func updateTask(toDoList: ToDoList, row: Int, name: String) {
        try! self.realm.write {
            toDoList.tasks[row] = name
        }
    }
}
