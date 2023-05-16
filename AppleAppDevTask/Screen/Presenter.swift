//
//  Presenter.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 11.05.2023.
//

import Foundation


protocol ViewOutput: AnyObject {
    func getAllCompanies()
}

protocol TableManagerInput: AnyObject {
    func appendCompanies()
}

final class Presenter {
    
    weak var view: ViewInput?
    private let networkSevice: NetworkServiceOutput
    private let tableManager: TableManagerOutput
   
    init(networkSevice: NetworkServiceOutput, tableManager: TableManagerOutput) {
        self.networkSevice = networkSevice
        self.tableManager = tableManager
    }
    
    private func stratActivityIndicator() {
        tableManager.startActivityIndicator()
    }
}

// MARK: - ViewOutput
extension Presenter: ViewOutput {
    
    func getAllCompanies() {
        stratActivityIndicator()
        networkSevice.getAllCompanies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.tableManager.appendItems(from: items)
            case .failure(let error):
                view?.showAlert(error)
                self.tableManager.cancelActivityIndicator()
            }
        }
    }
}

// MARK: - TableManagerInput
extension Presenter: TableManagerInput{
    func appendCompanies() {
        getAllCompanies()
    }
}
