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
    
}

final class Presenter {
    
    weak var view: ViewInput?
    private let networkSevice: NetworkServiceOutput
    private let tableManager: TableManagerOutput
   
    init(networkSevice: NetworkServiceOutput, tableManager: TableManagerOutput) {
        self.networkSevice = networkSevice
        self.tableManager = tableManager
    }
}

// MARK: - ViewOutput
extension Presenter: ViewOutput {
    
    func getAllCompanies() {
        networkSevice.getAllCompanies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                tableManager.appendItems(from: items)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - TableManagerInput
extension Presenter: TableManagerInput{
    
}
