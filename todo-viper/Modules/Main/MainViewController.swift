//
//  MainViewController.swift
//  todo-viper
//
//  Created by Umut Konmuş on 5.02.2025.
//

// View -> Presenter (Task #1)
// Presenter (Task #1) -> Interactor
// Interactor (Task #1) -> DataManager
// Complated (Success or Error)
// -------------------------
// Interactor (update view) -> Presenter
// Presenter (update yourself) -> View
//
//
//
// View(#1) <-> Presenter(#1)
//
// Interactor(#1) <-> Presenter(#1)
//
// Presenter(#1) <-> View(#1)
// Presenter(#1) <-> Interactor(#1)
// Presenter(#1) <-> Router(#1)



import UIKit

protocol TodoViewInterface: ViewInterface {
    func reloadData()
}

final class MainViewController: UIViewController, TodoViewInterface, Storyboarded {
    
    static var storyboardName: StoryboardNames {
        .main
    }
    
    var presenter: TodoPresenterInterface!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func prepareUI(){
        tableView.register(UINib(nibName: ToDoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ToDoTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Todo List Viper"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
    }
    
    @objc func addTodo(){
        presenter.addTodoButtonTapped()
    }

}

//MARK: TableView Delegate and DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        guard let cellData = presenter.cellData(at: indexPath) else { return UITableViewCell() }
        
        cell.label.text = cellData.title
        cell.isCompleted = cellData.isCompleted
        cell.selectionStyle = .none
        cell.updateButtonState()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

//MARK: TableView Delete
extension MainViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            self.presenter.didTrailingSwipeAction(at: indexPath)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: TableView Update
extension MainViewController {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let updateAction = UIContextualAction(style: .normal, title: "Update") { _, _, completionHandler in
            self.presenter.didLeadingSwipeAction(at: indexPath)
            completionHandler(true)
        }
        updateAction.image = UIImage(systemName: "pencil")
        return UISwipeActionsConfiguration(actions: [updateAction])
    }
}
