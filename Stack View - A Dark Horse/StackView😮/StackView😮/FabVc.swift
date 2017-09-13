//
//  FabVc.swift
//  StackView😮
//
//  Created by Kuliza-369 on 28/08/17.
//  Copyright © 2017 Kuliza-369. All rights reserved.
//

import UIKit

class FabVc: UIViewController {
    
    var textField: AckoTextField! {
        didSet {
            let rule: [Rule] = [(regex: "^[a-zA-Z.'-]+(?: +[a-zA-Z.'-]+)+$", message: "Full Name required")]
            
            textField.prepareTextField(delegate: self, placeHolderText: "Enter your Full Name", font: UIFont.systemFont(ofSize: 14), textColor: UIColor.black, floatingText: "Name", floatingTextColor: UIColor.darkGray, floatingTextFont: UIFont.systemFont(ofSize: 12), lineColor: UIColor.gray, selectedLineColor: UIColor.darkGray, errorColor: UIColor.red, textAlignment: .left, borderStyle: .none, mode: .write, rules: rule, rightView: createTickView())
        }
    }
    
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
        createTextField()
    }
    
    private func createCustomFabMenu() {
        fabMenuButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        fabMenuButton.layer.cornerRadius = 25
        fabMenuButton.backgroundColor = UIColor.red
        fabMenuButton.setTitle("F", for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FabVc.fabMenuTapped(_:)))
        fabMenuButton.addGestureRecognizer(tapGesture)
    }
    
    func createTextField() {
        textField = AckoTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
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
        textField.resignFirstResponder()
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
    
    private func createTickView() -> UIButton {
        let tickButton = UIButton.init(frame: CGRect(origin: .zero, size: CGSize(width: 15, height: 30)))
        tickButton.setTitle("✓", for: .normal)
        tickButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        tickButton.setTitleColor(UIColor.black, for: .normal)
        tickButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        tickButton.isHidden = true
        return tickButton
    }
}

extension FabVc: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Editing Begin")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Editing End")
    }
    
}
