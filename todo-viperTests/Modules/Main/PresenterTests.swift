//
//  PresenterTests.swift
//  todo-viper
//
//  Created by Umut Konmuş on 11.03.2025.
//

import Testing
@testable import todo_viper
import UIKit

class MockView: TodoViewInterface {
    
    weak var presenter: TodoPresenter?
    
    var isDataReloaded = false
    var isUIPrepared = false
    
    func reloadData() {
        isDataReloaded = true
    }
    
    func prepareUI() {
        isUIPrepared = true
    }
    
}

class MockInteractor: TodoInteractorInterface {
    
    weak var output : TodoInteractorOutput?
    var isTodosSaved = false
    var isTodosDeleted = false
    var isTodosUpdated = false
    var shouldSucceed = false
    
    func fetchTodos() {
        if shouldSucceed {
            let todos = [TodoItem]()
            output?.fetchTodosOnResponseRecieved(.success(todos))
        }else {
            output?.fetchTodosOnResponseRecieved(.failure(NSError(domain: "MockError", code: -1, userInfo: nil)))
        }
        
    }
    
    func saveTodo(title: String) {
        isTodosSaved = true
        shouldSucceed = true
        fetchTodos()
    }
    
    func deleteTodo(todo: todo_viper.TodoItem) {
        isTodosDeleted = true
    }
    
    func updateTodo(todo: todo_viper.TodoItem) {
        isTodosUpdated = true
    }
    
    
}

class MockRouter: TodoRouterInterface {
    
    weak var presenter: TodoPresenter?
    
    var isNavigatedToEdit = false
    var isShowedNewTodoAlert = false
    
    func navigateToEdit(todoItem: todo_viper.TodoItem) {
        isNavigatedToEdit = true
    }
    
    func showNewTodoAlert() {
        isShowedNewTodoAlert = true
    }
    
    var navigationController: UINavigationController?
    
}

struct PresenterTests {
    
    let presenter: TodoPresenter
    let interactor: MockInteractor
    let view: MockView
    let router: MockRouter
    
    init() {
        
        interactor = MockInteractor()
        view = MockView()
        router = MockRouter()
        
        presenter = TodoPresenter()
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        view.presenter = presenter
        
        router.presenter = presenter
        
        interactor.output = presenter
    }
    
    @Test("Fetch Todos on Response Recieved - Success")
    func testFetchTodosOnResponseRecieved_Success() {
        interactor.shouldSucceed = true
        interactor.fetchTodos()
        #expect(view.isDataReloaded)
    }
    
    @Test("Fetch Todos on Response Recieved - Failure")
    func testFetchTodosOnResponseRecieved_Failure() {
        interactor.shouldSucceed = false
        interactor.fetchTodos()
        #expect(!view.isDataReloaded)
    }
    
    @Test("Save Todo")
    func testSaveTodo() {
        interactor.saveTodo(title: "MockTodo")
        #expect(view.isDataReloaded)
    }
    
    
}
