//
//  Assembly.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 11.05.2023.
//

import UIKit

final class Assembly {
    
    static func assemble() -> UINavigationController {
        let tableView = UITableView()
        let tableManager = TableManager(tableView: tableView)
        let networkService = NetworkService()
        let presenter = Presenter(networkSevice: networkService, tableManager: tableManager)
        tableManager.presenter = presenter
        let view = ViewController(presenter: presenter, tableView: tableView)
        presenter.view = view
        return view.embedInNavigationController()
    }
}
