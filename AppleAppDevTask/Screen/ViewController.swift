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
    
    init(presenter: ViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
