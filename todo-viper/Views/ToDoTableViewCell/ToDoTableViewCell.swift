//
//  ToDoTableViewCell.swift
//  todo-mvvm
//
//  Created by Umut Konmuş on 5.02.2025.
//

import UIKit

enum ButtonState : String {
    case Complated = "checkmark.circle.fill"
    case UnComplated = "circle"
    
    var image: UIImage? {
        return UIImage(systemName: self.rawValue)
    }
}

class ToDoTableViewCell: UITableViewCell {
    static let identifier = "ToDoTableViewCell"

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    var isCompleted: Bool!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        /*isCompleted.toggle()
        updateButtonState()*/
    }
    
    func updateButtonState() {
        if (isCompleted) {
            button.setImage(ButtonState.Complated.image, for: .normal)
        }else {
            button.setImage(ButtonState.UnComplated.image,for: .normal)
        }
    }
    
}
