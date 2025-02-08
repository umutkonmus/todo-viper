//
//  Presenter.swift
//  todo-viper
//
//  Created by Umut Konmuş on 6.02.2025.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view : AnyView? { get set }
    func saveTodo(title: String)
    func interactorDidFetchTodos(todos: [TodoItem])
    func deleteTodo(at index: Int)
    func getTodoTitle(at index: Int) -> String
    func getTodoIsCompleted(at index: Int) -> Bool
    func getTodoCount() -> Int
    func toggleTodo(at index: Int)
}

class TodoPresenter: AnyPresenter {
    
    var router: (any AnyRouter)?
    var interactor: (any AnyInteractor)? {
        didSet{
            interactor?.fetchTodos()
        }
    }
    var view: AnyView?
    
    func interactorDidFetchTodos(todos: [TodoItem]) {
        view?.update(with: todos)
    }
    
    func saveTodo(title: String){
        interactor?.saveTodo(title: title)
    }
    
    func deleteTodo(at index: Int) {
        interactor?.deleteTodo(at: index)
    }
    
    func getTodoTitle(at index: Int) -> String {
        return interactor?.getTodoTitle(at: index) ?? ""
    }
    
    func getTodoIsCompleted(at index: Int) -> Bool {
        return interactor?.getTodoIsCompleted(at: index) ?? false
    }
    
    func getTodoCount() -> Int {
        return interactor?.getTodoCount() ?? 0
    }
    
    func toggleTodo(at index: Int) {
        interactor?.toggleTodo(at: index)
    }
}
