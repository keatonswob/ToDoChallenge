//
//  ToDoViewController.swift
//  ToDoChallenge
//
//  Created by Keaton Swoboda on 1/9/20.
//  Copyright © 2020 Keaton Swoboda. All rights reserved.
//

import UIKit

final class ToDoViewController: UIViewController, ToDoListViewModelDelegate {
    private var viewModel: ToDoListViewModel
    
    init(viewModel: ToDoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        viewModel.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.rightBarButtonTitle, style: .plain, target: self, action: #selector(rightNavButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = viewModel.tintColor
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .blueGreen
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func toDoAlertDidClose() {
        tableView.reloadData()
    }
    
    @objc func rightNavButtonPressed() {
        let alertController = UIAlertController(title: viewModel.alertTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { (txtField) in
            txtField.placeholder = self.viewModel.alertTextFieldPlaceHolder
            txtField.becomeFirstResponder()
        }
        
        let addListAction = UIAlertAction(title: viewModel.alertAddTitle, style: .default) { action in
            guard let text = alertController.textFields?.first?.text else { return }
            self.viewModel.addToList(text)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: viewModel.alertCancelTitle, style: .cancel)
        
        alertController.addAction(addListAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .white
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        return tv
    }()
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        cell.textLabel?.text = viewModel.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: viewModel.editAlertTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { (txtField) in
            txtField.text = self.viewModel.items[indexPath.row]
        }
        
        let deleteAction = UIAlertAction(title: viewModel.editAlertDeleteText, style: .destructive) { (action) in
            self.viewModel.deleteTask(at: indexPath.row)
        }
        
        let saveAction = UIAlertAction(title: viewModel.editAlertSaveText, style: .default) { (action) in
            guard let text = alertController.textFields?.first?.text else { return }
            self.viewModel.updateTask(at: indexPath.row, text: text)
        }
        
        let cancelAction = UIAlertAction(title: viewModel.editAlertCancelText, style: .cancel)
        
        alertController.addAction(saveAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
