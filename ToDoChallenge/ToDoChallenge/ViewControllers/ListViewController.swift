//
//  ListViewController.swift
//  ToDoChallenge
//
//  Created by Keaton Swoboda on 1/7/20.
//  Copyright © 2020 Keaton Swoboda. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var viewModel: ListViewModel
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .blue
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.rightBarButtonTitle, style: .plain, target: self, action: #selector(rightNavButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = viewModel.tintColor
        navigationItem.title = viewModel.navTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .blueGreen
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func rightNavButtonPressed() {
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
        tv.tableFooterView = UIView()
        tv.backgroundColor = .blueGreen
        tv.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        return tv
    }()
}

extension ListViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        cell.textLabel?.text = viewModel.toDoLists[indexPath.row].name
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        
        cell.backgroundColor = .blueGreen
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDoListViewModel = viewModel.viewModel(row: indexPath.row)
        let listViewController = ToDoViewController(viewModel: toDoListViewModel)
        present(UINavigationController(rootViewController: listViewController), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewModel.deleteList(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
