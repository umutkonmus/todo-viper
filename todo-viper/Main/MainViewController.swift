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

protocol AnyView{
    var presenter: AnyPresenter? { get set }
    
    func update(with: [TodoItem])
}

class MainViewController: UIViewController, AnyView {
    var presenter: (any AnyPresenter)?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: ToDoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ToDoTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        setupNavigation()
    }
    
    func update(with: [TodoItem]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupNavigation(){
        navigationItem.title = "Todo List Viper"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
    }
    
    @objc func addTodo(){
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

        present(alert, animated: true)
    }

}

//MARK: TableView Delegate and DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getTodoCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifier) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        cell.label.text = presenter?.getTodoTitle(at: indexPath.row)
        cell.isCompleted = presenter?.getTodoIsCompleted(at: indexPath.row)
        cell.selectionStyle = .none
        cell.updateButtonState()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.toggleTodo(at: indexPath.row)
    }
}

//MARK: TableView Delete
extension MainViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { _, _, completionHandler in
            self.presenter?.deleteTodo(at: indexPath.row)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
