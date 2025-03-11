//
//  Router.swift
//  todo-viper
//
//  Created by Umut Konmuş on 15.02.2025.
//

import UIKit

protocol EditRouterInterface: RouterInterface {
    
}

final class EditRouter : EditRouterInterface {
    weak var navigationController: UINavigationController?
    weak var presenter: EditPresenter?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func createModule(navigationController: UINavigationController, todoItem: TodoItem) -> UIViewController {
        let view = EditViewController.instantiate()
        let presenter = EditPresenter()
        let interactor = EditInteractor()
        
        //let navigationController = UINavigationController(rootViewController: view)
        
        let router = EditRouter(navigationController: navigationController)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.todoItem = todoItem
        
        view.presenter = presenter
        
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
    func showSavedAlert(todoItem: TodoItem) {
        guard let title = todoItem.title else {return}
        let alert = UIAlertController(title: "Saved", message: "\(title) Saved Successfully", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                self.navigateToBack()
            }
        
        alert.addAction(okAction)

        self.navigationController?.present(alert, animated: true)
    }
    
    func navigateToBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
