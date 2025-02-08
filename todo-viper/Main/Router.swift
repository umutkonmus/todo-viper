//
//  Router.swift
//  todo-viper
//
//  Created by Umut Konmuş on 6.02.2025.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func startExecution() -> AnyRouter
}

class TodoRouter : AnyRouter {
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        
        let router = TodoRouter()
        
        var view: AnyView = MainViewController()
        var presenter: AnyPresenter =  TodoPresenter()
        var interactor: AnyInteractor = TodoInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
