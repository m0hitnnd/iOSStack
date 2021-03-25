//
//  TmdbTabBarViewController.swift
//  Hollywoo
//
//  Created by Mohitnnd on 23/03/21.
//

import UIKit

final class TmdbTabBarViewController: UITabBarController {
    
    private let viewModel: TmdbTabBarViewModel
    
    init(viewModel: TmdbTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

}

extension TmdbTabBarViewController {
    func setupBindings() {
        viewModel.items.bindAndFire { [weak self] items in
            self?.setViewControllers(items)
        }
    }
}

extension TmdbTabBarViewController {
    func setViewControllers(_ items: [TmdbTabBarViewModel.Item]) {
        var controllers: [UIViewController] = []
        for item in items {
            let controller = item.getController()
            controller.tabBarItem = item.tabBarItem()
            controllers.append(controller)
        }
        self.viewControllers = controllers
    }
}
