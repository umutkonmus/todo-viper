//
//  Interactor.swift
//  todo-viper
//
//  Created by Umut Konmuş on 15.02.2025.
//

protocol EditInteractorInterface {
    func updateTodo(todoItem: TodoItem, title: String, isCompleted: Bool )
}

protocol EditInteractorOutput: AnyObject {
    func didUpdateTodo()
}

final class EditInteractor: EditInteractorInterface {
    
    weak var output: EditInteractorOutput?
    
    func updateTodo(todoItem: TodoItem, title: String, isCompleted: Bool) {
        CoreDataManager.shared.editTodo(todo: todoItem, newTitle: title, isCompleted: isCompleted)
        output?.didUpdateTodo()
    }
    
}
