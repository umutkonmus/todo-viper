//
//  Presenter.swift
//  todo-viper
//
//  Created by Umut Konmuş on 6.02.2025.
//

import Foundation


protocol PresenterInterface{
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func viewWillEnterForeground()
    func viewDidLayoutSubviews()
}

extension PresenterInterface {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    func viewWillEnterForeground() {}
    func viewDidLayoutSubviews() {}
}

protocol TodoPresenterInterface : PresenterInterface {
    var numberOfRowsInSection: Int { get }
    func cellData(at indexPath: IndexPath) -> TodoItem?
    func didSelectRow(at indexPath: IndexPath)
    func didTrailingSwipeAction(at indexPath: IndexPath)
    func addTodoButtonTapped()
}

final class TodoPresenter {
    
    private var todos : [TodoItem] = []
    
    var router: TodoRouter!
    var interactor: TodoInteractorInterface!
    weak var view: TodoViewInterface?
    
    func saveTodo(title: String){
        interactor?.saveTodo(title: title)
    }
}

extension TodoPresenter: TodoPresenterInterface {

    func viewDidLoad() {
        interactor?.fetchTodos()
        view?.prepareUI()
    }
    
    var numberOfRowsInSection: Int {
        return todos.count
    }
    
    func addTodoButtonTapped() {
        router.showNewTodoAlert()
    }
    
    func cellData(at indexPath: IndexPath) -> TodoItem? {
        guard indexPath.row < todos.count else { return nil }
        return todos[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < todos.count else { return }
        let todoItem = todos[indexPath.row]
        todoItem.isCompleted.toggle()
        interactor?.updateTodo(todo: todoItem)
    }
    
    func didTrailingSwipeAction(at indexPath: IndexPath) {
        guard indexPath.row < todos.count else { return }
        let todoItem = todos[indexPath.row]
        interactor?.deleteTodo(todo: todoItem)
    }
    
}

extension TodoPresenter : TodoInteractorOutput{
    func fetchTodosOnResponseRecieved(_ result: Result<[TodoItem], any Error>) {
        switch result {
        case .success(let todos):
            self.todos = todos
        case .failure(let error):
            print(error)
            self.todos = []
        }
        view?.reloadData()
    }
}
