//
//  Router.swift
//  todo-viper
//
//  Created by Umut Konmuş on 6.02.2025.
//

import Foundation
import UIKit

protocol TodoRouterInterface: RouterInterface {
    func showNewTodoAlert()
}

final class TodoRouter : TodoRouterInterface {
    weak var navigationController: UINavigationController?
    
    weak var presenter: TodoPresenter?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func showNewTodoAlert() {
        let alert = UIAlertController(title: "New Task", message: "Give a name", preferredStyle: .alert)
        alert.addTextField()
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let title = alert.textFields?.first?.text, !title.isEmpty {
                self.presenter?.saveTodo(title: title)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(addAction)
        alert.addAction(cancelAction)

        self.navigationController?.present(alert, animated: true)
    }
    
    static func createModule() -> UINavigationController {
        
        let view = MainViewController.instantiate()
        let presenter =  TodoPresenter()
        let interactor = TodoInteractor()
        
        let navigationController = UINavigationController(rootViewController: view)
        
        let router = TodoRouter(navigationController: navigationController)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        
        router.presenter = presenter
        interactor.output = presenter
        
        return navigationController
    }
    
    func navigateToEdit(todoItem: TodoItem) {
        let editVC = EditRouter.createModule(navigationController: self.navigationController!)
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}
