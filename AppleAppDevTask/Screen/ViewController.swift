//
//  ViewController.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 11.05.2023.
//

import UIKit

protocol ViewInput: AnyObject {

}

final class ViewController: UIViewController {
    
    private let presenter: ViewOutput
    private let tableView: UITableView
    
    init(presenter: ViewOutput, tableView: UITableView) {
        self.presenter = presenter
        self.tableView = tableView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.backgroundColor = .blue
        tableView.frame = view.bounds
        presenter.getAllCompanies()
    }
}

extension ViewController: ViewInput {
    
}

// MARK: - UINavigationController
extension ViewController {
    
    func embedInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.topItem?.title = "TEST"
        return navigationController
    }
}
