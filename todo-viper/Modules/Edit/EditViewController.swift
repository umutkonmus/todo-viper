//
//  EditViewController.swift
//  todo-viper
//
//  Created by Umut Konmuş on 15.02.2025.
//

import UIKit

protocol EditViewControllerInterface: ViewInterface {
    
}

final class EditViewController: UIViewController, EditViewControllerInterface, Storyboarded {
    
    static var storyboardName: StoryboardNames {
        .edit
    }
    
    var presenter: EditPresenterInterface!
    
    func prepareUI() {
        
    }
    
    
}
