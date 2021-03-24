//
//  NowPlayingViewController.swift
//  TMDB
//
//  Created by Mohitnnd on 24/03/21.
//

import UIKit

final class NowPlayingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension NowPlayingViewController {
    func setupUI() {
        self.view.backgroundColor = UIColor.systemBackground
    }
}
