//
//  EditViewController.swift
//  todo-viper
//
//  Created by Umut Konmuş on 15.02.2025.
//

import UIKit

protocol EditViewControllerInterface: ViewInterface {
    var isCompleted: Bool { get set }
    func updateButtonImage()
}

final class EditViewController: UIViewController, EditViewControllerInterface, Storyboarded {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompletedButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var isCompleted: Bool = false
    
    static var storyboardName: StoryboardNames {
        .edit
    }
    
    var presenter: EditPresenterInterface!
    
    func prepareUI() {
        titleTextField.text = presenter.getTitle()
        updateButtonImage()
    }
    
    func updateButtonImage() {
        if isCompleted {
            isCompletedButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        }else {
            isCompletedButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func isCompletedButtonClicked(_ sender: Any) {
        presenter.isCompletedClicked()
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let title = titleTextField.text else {return}
        presenter.saveClicked(title: title, isCompleted: isCompleted)
    }
    
}
