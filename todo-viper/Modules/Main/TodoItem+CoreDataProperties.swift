//
//  ToDoItem.swift
//  todo-mvvm
//
//  Created by Umut Konmuş on 5.02.2025.
//
import CoreData

@objc(TodoItem)
class TodoItem : NSManagedObject {
    
}

extension TodoItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var id: UUID?
}

