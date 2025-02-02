//
//  TodoListController.swift
//  HomeWork-Ios
//
//  Created by Евгений Фомичев on 05.01.2025.
//

import UIKit

class TodoListController: UIViewController, TodoListViewProtocol {
    
    var presenter: TodoListPresenterProtocol?
    
    private let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        return table
    }()
    
    private var containerConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(table)
        configureTableView()
        setupConstraints()
        setaper()
        table.rowHeight = 80
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(openAlert))
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moveContentUp),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moveContentDown),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    private func moveContentUp(notification: NSNotification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            print("Ошибка")
            return
        }
        let keyBoardFrame = keyboardSize.cgRectValue
        let keyboardHeight = keyBoardFrame.height
        
        UIView.animate(withDuration: 0.3) {
            self.containerConstraint?.constant = -keyboardHeight
        }
    }
    
    @objc
    private func moveContentDown(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.containerConstraint?.constant = 0
        }
    }
    
    @objc
    private func openAlert() {
        let alert = UIAlertController(title: "Create todo", message: "", preferredStyle: .alert)
        alert.addTextField()
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textName = alert.textFields?.first?.text else { return }
            self.presenter?.addTodo(title: textName, subTitle: "")
        }
        
        alert.addAction(saveButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // Mark : создание линии
    private func setaper() {
        let apperance = UINavigationBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.backgroundColor = .white
        apperance.shadowColor = .black
        
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
    }
    
    private func configureTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(CustomTableCell.self, forCellReuseIdentifier: CustomTableCell.cellIdentifier)
        table.allowsSelectionDuringEditing = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func addTodo(index: Int) {
        table.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func remove(index: Int) {
        table.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

extension TodoListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.todos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableCell.cellIdentifier,
                                                       for: indexPath) as? CustomTableCell,
              let todoItem = presenter?.todos[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(with: todoItem)
        cell.delegate = self
        
        return cell
    }
    
    // delete:
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completionHandler in
            self.presenter?.remove(at: indexPath.row)
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension TodoListController: CustomCellDelegate {
    
    func tapStatusButton(cell: CustomTableCell, isSelected selected: Bool) {
        
        guard let indexPath = table.indexPath(for: cell) else { return }
        
        presenter?.todos[indexPath.row].isSelected = selected
        
        table.reloadRows(at: [indexPath], with: .automatic)
    }
}
