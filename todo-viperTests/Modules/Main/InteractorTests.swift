//
//  InteractorTests.swift
//  todo-viper
//
//  Created by Umut Konmuş on 15.02.2025.
//

import Testing
@testable import todo_viper
class MockPresenter: TodoInteractorOutput {
    var interactor: TodoInteractor!
    var receivedTodos: [TodoItem]?
    var receivedError: Error?
    
    func fetchTodosOnResponseRecieved(_ result: Result<[TodoItem], any Error>) {
    switch result {
        case .success(let todos):
            receivedTodos = todos
        case .failure(let error):
            receivedError = error
        }
    }
}

struct InteractorTests {
    let interactor: TodoInteractor!
    let mockPresenter: MockPresenter!
    
    init() {
        self.interactor = TodoInteractor()
        self.mockPresenter = MockPresenter()
        self.interactor.output = self.mockPresenter
        self.mockPresenter.interactor = self.interactor
    }
    
    @Test
    func testFetchTodosOnResponseRecieved_Success() {
        
        interactor.fetchTodos()
        
        #expect(mockPresenter.receivedTodos != nil)
    }
    
}
