//
//  Presenter.swift
//  todo-viper
//
//  Created by Umut Konmuş on 15.02.2025.
//

import Foundation

protocol EditPresenterInterface: PresenterInterface{
    
}

final class EditPresenter{
    var router: EditRouter!
    var interactor: EditInteractorInterface!
    weak var view: EditViewControllerInterface?
    
}

extension EditPresenter: EditPresenterInterface {
    
}

extension EditPresenter: EditInteractorOutput {
    
}
