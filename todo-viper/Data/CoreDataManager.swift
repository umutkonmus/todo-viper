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
        persistentContainer = NSPersistentContainer(name: "todo_mvvm2")
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

    func fetchTodos() -> [TodoItem] {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error while fetching data: \(error)")
            return []
        }
    }

    func deleteTodo(todo: TodoItem) {
        context.delete(todo)
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
