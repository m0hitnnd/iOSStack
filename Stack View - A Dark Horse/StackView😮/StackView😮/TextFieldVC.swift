//
//  TextFieldVC.swift
//  StackView😮
//
//  Created by Pushpendra Khandelwal on 28/08/17.
//  Copyright © 2017 Kuliza-369. All rights reserved.
//

import UIKit

enum Mode: Int {
    case read = 0
    case write
}

class TextFieldVC: UIViewController {

    var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.placeholder = "Enter Your Mobile Number"
            textField.borderStyle = .line
        }
    }
    
    fileprivate var errorLabel: UILabel! {
        didSet {
            errorLabel.textColor = UIColor.red
            errorLabel.font = UIFont.systemFont(ofSize: 12)
            errorLabel.isHidden = true
        }
    }
    
    fileprivate var floatLabel: UILabel! {
        didSet {
            floatLabel.textColor = UIColor.darkGray
            floatLabel.font = UIFont.systemFont(ofSize: 12)
            floatLabel.isHidden = true
            floatLabel.textAlignment = .left
        }
    }
    
    fileprivate var stackView: UIStackView! {
        didSet {
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fillProportionally
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 4
        }
    }
    
    fileprivate var button: UIButton! {
        didSet {
            button.setTitle("Toogle TextField", for: .normal)
            button.setTitleColor(UIColor.brown, for: .normal)
            button.addTarget(self, action: #selector(changeMode), for: .touchUpInside)
        }
    }
    
    var floatingText: String = "" {
        didSet {
            if floatingText != "" {
                self.floatLabel.text = floatingText
            } else {
                self.floatLabel.text = textField.placeholder
            }
        }
    }
    
    var errorMessage: String = "" {
        didSet {
            if errorMessage == "" {
                errorLabel.isHidden = true
            } else {
                errorLabel.isHidden = false
                errorLabel.text = errorMessage
            }
        }
    }
    
    var attributedErrorMessage: NSAttributedString = NSAttributedString.init(string: "") {
        didSet {
            if attributedErrorMessage.string == "" {
                errorLabel.isHidden = true
            } else {
                errorLabel.isHidden = false
                errorLabel.attributedText = attributedErrorMessage
            }
        }
    }

    fileprivate var mode: Mode = .write {
        didSet {
            if mode == .read {
                UIView.animate(withDuration: 0.5) { [unowned self] in
                    self.textField.isEnabled = false
                    self.textField.borderStyle = .none
                    self.stackView.axis = .horizontal
                }
            } else {
                UIView.animate(withDuration: 0.5) { [unowned self] in
                    self.textField.isEnabled = true
                    self.textField.borderStyle = .line
                    self.stackView.axis = .vertical
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTextField()
        createToggleButton()
        self.floatingText = "Mobile Number"
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tap)
    }
    
    func viewTapped() {
        self.textField.resignFirstResponder()
    }
    
    func createTextField() {
        
        textField = UITextField()
        errorLabel = UILabel()
        floatLabel = UILabel()
        
        stackView = UIStackView()
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(floatLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(errorLabel)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
    }
    
    func createToggleButton() {
        button = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.stackView.bottomAnchor,constant: 30),
            self.button.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor)
            ])
    }
    
    func changeMode() {
            if mode == .read {
                mode = .write
            } else {
                mode = .read
            }
    }

}

// MARK: TextField Delegate
extension TextFieldVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.floatLabel.isHidden = false
            self.errorMessage = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.characters.count != 10 {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.errorLabel.isHidden = false
                self.errorMessage = "Invalid Mobile Number"
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let enteredText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        
        if enteredText == "" {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.floatLabel.isHidden = true
            }
        } else {
            UIView.animate(withDuration: 0.5) { [unowned self] in
                self.floatLabel.isHidden = false
            }
        }
        
        return true
    }

}

