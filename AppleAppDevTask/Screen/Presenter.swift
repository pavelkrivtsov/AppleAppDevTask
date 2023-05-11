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

final class Presenter {
    
    weak var view: ViewInput?
    private let networkSevice: NetworkServiceOutput
   
    init(networkSevice: NetworkServiceOutput) {
        self.networkSevice = networkSevice
    }
}

extension Presenter: ViewOutput {
    
    func getAllCompanies() {
        networkSevice.getAllCompanies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                print(items)
            case .failure(let error):
                print(error)
            }
        }
    }
}
