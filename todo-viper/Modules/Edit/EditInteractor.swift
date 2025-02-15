//
//  Interactor.swift
//  todo-viper
//
//  Created by Umut Konmuş on 15.02.2025.
//

protocol EditInteractorInterface {
    
}

protocol EditInteractorOutput: AnyObject {
    
}

final class EditInteractor: EditInteractorInterface {
    
    weak var output: EditInteractorOutput?
    
}
