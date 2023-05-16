//
//  TableManager.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 11.05.2023.
//

import UIKit
import SnapKit

protocol TableManagerOutput {
    func appendItems(from items: [ResponseItem])
    func startActivityIndicator()
    func cancelActivityIndicator()
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
        self.tableView.allowsSelection = false
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

    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: .init(x: 0,
                                             y: 0,
                                             width: self.tableView.frame.width,
                                             height: self.tableView.frame.width / 5))
        
        let loadlabel = UILabel()
        footerView.addSubview(loadlabel)
        loadlabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(3)
        }
        loadlabel.text = "Подгрузка компаний"
        loadlabel.textAlignment = .center
        let spinner = UIActivityIndicatorView(style: .large)
        footerView.addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.centerX.top.equalToSuperview()
            $0.bottom.equalTo(loadlabel.snp.top)
        }
        spinner.startAnimating()
        
        return footerView
    }
}

// MARK: - TableManagerOutput
extension TableManager: TableManagerOutput {
    
    func appendItems(from items: [ResponseItem]) {
        guard !items.isEmpty else { return }
        self.items += items
        var snapshot = NSDiffableDataSourceSnapshot<Int, ResponseItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func startActivityIndicator() {
        tableView.tableFooterView = createSpinnerFooter()
    }
    
    func cancelActivityIndicator() {
        tableView.tableFooterView = nil
    }
}

// MARK: - UITableViewDelegate
extension TableManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case items.count - 1:
            presenter?.appendCompanies()
            tableView.tableFooterView = createSpinnerFooter()
        default:
            tableView.tableFooterView = nil
        }
    }
}

