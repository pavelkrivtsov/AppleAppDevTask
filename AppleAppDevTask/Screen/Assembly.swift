//
//  Assembly.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 11.05.2023.
//

import UIKit

final class Assembly {
    
    static func assemble() -> UINavigationController {

        let networkService = NetworkService()
        let presenter = Presenter(networkSevice: networkService)
        let view = ViewController(presenter: presenter)
        presenter.view = view
        return view.embedInNavigationController()
    }
}
