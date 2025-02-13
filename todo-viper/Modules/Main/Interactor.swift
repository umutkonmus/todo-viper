//
//  Interactor.swift
//  todo-viper
//
//  Created by Umut Konmuş on 6.02.2025.
//

import Foundation

protocol TodoInteractorInterface {
    func fetchTodos()
    func saveTodo(title: String)
    func deleteTodo(todo: TodoItem)
    //func getTodoTitle(at index: Int) -> String
    //func getTodoIsCompleted(at index: Int) -> Bool
    //func getTodoCount() -> Int
    func updateTodo(todo: TodoItem)
}

protocol TodoInteractorOutput: AnyObject {
    func fetchTodosOnResponseRecieved(_ result: Result<[TodoItem], Error>)
    
}

final class TodoInteractor: TodoInteractorInterface {
    weak var output : TodoInteractorOutput?
    
    func fetchTodos() {
        do{
            let todos = try CoreDataManager.shared.fetchTodos()
            output?.fetchTodosOnResponseRecieved(.success(todos))
        } catch {
            output?.fetchTodosOnResponseRecieved(.failure(error))
        }
    }
    
    func saveTodo(title: String) {
        CoreDataManager.shared.addTodo(title: title)
        fetchTodos()
    }
    
    func deleteTodo(todo: TodoItem) {
        CoreDataManager.shared.deleteTodo(todo: todo)
        fetchTodos()
    }
    
    func updateTodo(todo: TodoItem) {
        CoreDataManager.shared.save()
        fetchTodos()
    }
}
