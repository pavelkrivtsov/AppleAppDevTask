//
//  TableManager.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 11.05.2023.
//

import UIKit

protocol TableManagerOutput {
    func appendItems(from items: [ResponseItem])
}

final class TableManager: NSObject {
    
    weak var presenter: TableManagerInput?
    private let tableView: UITableView
    private var dataSource: UITableViewDiffableDataSource<Int, ResponseItem>!
    private var items = [ResponseItem]()
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellIdentifier)
        
        dataSource = UITableViewDiffableDataSource<Int, ResponseItem>(tableView: self.tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellIdentifier,
                                                           for: indexPath) as? CustomCell else {
                fatalError("CustomCell is not registered for table view")
            }
            cell.configure(item: item)
            return cell
        }
    }
}

// MARK: - TableManagerOutput
extension TableManager: TableManagerOutput {
    
    func appendItems(from items: [ResponseItem]) {
        self.items += items
        var snapshot = NSDiffableDataSourceSnapshot<Int, ResponseItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UITableViewDelegate
extension TableManager: UITableViewDelegate {
    
}

