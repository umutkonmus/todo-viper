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
    
    static func createModule(navigationController: UINavigationController) -> UIViewController {
        let view = EditViewController.instantiate()
        let presenter = EditPresenter()
        let interactor = EditInteractor()
        
        //let navigationController = UINavigationController(rootViewController: view)
        
        let router = EditRouter(navigationController: navigationController)
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
