//
//  FabVc.swift
//  StackView😮
//
//  Created by Kuliza-369 on 28/08/17.
//  Copyright © 2017 Kuliza-369. All rights reserved.
//

import UIKit

class FabVc: UIViewController {
    
    @IBOutlet weak var fabButton: UIStackView! {
        didSet {
            addButtonsToFab()
        }
    }
    
    @IBOutlet weak var fabMenuButton: UIButton! {
        didSet {
            createCustomFabMenu()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func createCustomFabMenu() {
        fabMenuButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        fabMenuButton.layer.cornerRadius = 25
        fabMenuButton.backgroundColor = UIColor.red
        fabMenuButton.setTitle("F", for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FabVc.fabMenuTapped(_:)))
        fabMenuButton.addGestureRecognizer(tapGesture)
    }
    
    private func addButtonsToFab() {
        
        for i in 1...3  {
            let circularButton = getCircularButton()
            circularButton.setTitle("\(i)", for: .normal)
            circularButton.isHidden = true
            fabButton.insertArrangedSubview(circularButton, at: 0)
        }
        
    }
    
    func fabMenuTapped(_ sender: UITapGestureRecognizer) {
        
        let fabMenuButton = sender.view as? UIButton
        if fabMenuButton?.titleLabel?.text == "F" {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                self.fabButton.arrangedSubviews.dropLast().forEach { $0.isHidden = false }
                fabMenuButton?.setTitle("X", for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                self.fabButton.arrangedSubviews.dropLast().forEach { $0.isHidden = true }
                fabMenuButton?.setTitle("F", for: .normal)
            }
        }
    }
    
    private func getCircularButton() -> UIButton {
        let circularButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        circularButton.layer.cornerRadius = 25
        circularButton.backgroundColor = UIColor.orange
        return circularButton
    }
    
}
