//
//  CoreDataManager.swift
//  todo-mvvm
//
//  Created by Umut Konmuş on 5.02.2025.
//
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "todo_viper")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error while loading CoreData: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func addTodo(title: String) {
        let todo = TodoItem(context: context)
        todo.id = UUID()
        todo.title = title
        todo.isCompleted = false
        save()
    }

    func fetchTodos() throws -> [TodoItem] {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        return try context.fetch(request)
    }

    func deleteTodo(todo: TodoItem) {
        context.delete(todo)
        save()
    }
    
    func editTodo(todo: TodoItem, newTitle: String, isCompleted: Bool) {
        todo.title = newTitle
        todo.isCompleted = isCompleted
        save()
    }

    func save() {
        do {
            try context.save()
        } catch {
            print("Error while saving data: \(error)")
        }
    }
}
