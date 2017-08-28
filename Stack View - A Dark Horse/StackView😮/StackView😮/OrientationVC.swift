//
//  OrientationVC.swift
//  StackView😮
//
//  Created by Kuliza-369 on 28/08/17.
//  Copyright © 2017 Kuliza-369. All rights reserved.
//

import UIKit

class OrientationVC: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeAlignmentTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5) { [unowned self] in
            if self.stackView.axis == .horizontal {
                self.stackView.axis = .vertical
            } else {
                self.stackView.axis = .horizontal
            }
        }
        
    }
    
}
