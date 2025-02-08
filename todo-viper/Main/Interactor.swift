//
//  Interactor.swift
//  todo-viper
//
//  Created by Umut Konmuş on 6.02.2025.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func fetchTodos()
    func saveTodo(title: String)
    func deleteTodo(at index: Int)
    func getTodoTitle(at index: Int) -> String
    func getTodoIsCompleted(at index: Int) -> Bool
    func getTodoCount() -> Int
    func toggleTodo(at index: Int)
}

class TodoInteractor: AnyInteractor {
    
    var presenter: (any AnyPresenter)?
    
    private var todos: [TodoItem] = []
    
    func fetchTodos() {
        todos = CoreDataManager.shared.fetchTodos()
        presenter?.interactorDidFetchTodos(todos: todos)
    }
    
    func saveTodo(title: String) {
        CoreDataManager.shared.addTodo(title: title)
        fetchTodos()
    }
    
    func deleteTodo(at index: Int) {
        CoreDataManager.shared.deleteTodo(todo: todos[index])
        fetchTodos()
    }
    
    func getTodoTitle(at index: Int) -> String {
        return todos[index].title ?? ""
    }
    
    func getTodoIsCompleted(at index: Int) -> Bool {
        return todos[index].isCompleted
    }
    
    func getTodoCount() -> Int {
        return todos.count
    }
    
    func toggleTodo(at index: Int) {
        todos[index].isCompleted.toggle()
        CoreDataManager.shared.save()
        fetchTodos()
    }
}
