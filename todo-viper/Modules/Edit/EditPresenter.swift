//
//  Presenter.swift
//  todo-viper
//
//  Created by Umut Konmuş on 15.02.2025.
//

import Foundation

protocol EditPresenterInterface: PresenterInterface{
    func getTodoItem() -> TodoItem
    func saveClicked(title: String, isCompleted: Bool)
    func isCompletedClicked()
    func getTitle() -> String
}

final class EditPresenter{
    var router: EditRouter!
    var interactor: EditInteractorInterface!
    weak var view: EditViewControllerInterface?
    var todoItem: TodoItem!
}

extension EditPresenter: PresenterInterface {
    
    func viewDidLoad() {
        view?.isCompleted = todoItem.isCompleted
        view?.prepareUI()
    }
}

extension EditPresenter: EditPresenterInterface {
    
    func getTodoItem() -> TodoItem {
        return todoItem
    }
    
    func getTitle() -> String {
        guard let title = todoItem.title else { return "" }
        return title
    }
    
    func saveClicked(title: String, isCompleted: Bool) {
        interactor.updateTodo(todoItem: todoItem, title:title , isCompleted: isCompleted)
    }
    
    func isCompletedClicked() {
        view?.isCompleted.toggle()
        view?.updateButtonImage()
    }
    
}

extension EditPresenter: EditInteractorOutput {
    func didUpdateTodo() {
        router.showSavedAlert(todoItem: todoItem)
    }
    
    
}
