//
//  ViewController.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 11.05.2023.
//

import UIKit
import SnapKit

protocol ViewInput: AnyObject {
    func showAlert(_ error: NetworkResponse)
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
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.frame = view.bounds
        presenter.getAllCompanies()
    }
    
    private lazy var alert: UIAlertController = {
        var alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        return alert
    }()
}

// MARK: - ViewInput
extension ViewController: ViewInput {
    
    func showAlert(_ error: NetworkResponse) {
        self.alert.title = error.localizedDescription
        self.present(alert, animated: true)
    }
}

// MARK: - UINavigationController
extension ViewController {
    
    func embedInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.topItem?.title = "Управление картами"
        return navigationController
    }
}
