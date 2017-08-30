//
//  AckoTextField.swift
//  StackView😮
//
//  Created by Pushpendra Khandelwal on 29/08/17.
//  Copyright © 2017 Kuliza-369. All rights reserved.
//

import UIKit

typealias Rule = (regex: String, message: String)

class AckoTextField: UIStackView {

    var textField: UITextField! {
        didSet {
            textField.borderStyle = .none
            self.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
            self.textField.addTarget(self, action: #selector(editingEnd), for: .editingDidEnd)
            self.textField.addTarget(self, action: #selector(editingBegin), for: .editingDidBegin)
        }
    }
    
    // Error Label
    fileprivate var errorLabel: UILabel! {
        didSet {
            errorLabel.isHidden = true
            errorLabel.textAlignment = .left
        }
    }
    
    // Error Label Property
    fileprivate var errorColor: UIColor! {
        didSet {
            errorLabel.textColor = errorColor
        }
    }
    
    // Error Label Property
    fileprivate var errorFont: UIFont! {
        didSet {
            errorLabel.font = errorFont
        }
    }
    
    // Error Property
    var hasErrorMessage:Bool! {
        get {
            return self.errorMessage != ""
        }
    }
    
    // Floating Label
    fileprivate var floatLabel: UILabel! {
        didSet {
            floatLabel.isHidden = true
            floatLabel.textAlignment = .left
        }
    }
    
    // Floating Label Property
    fileprivate var floatingTextColor: UIColor! {
        didSet {
            floatLabel.textColor = floatingTextColor
        }
    }
    
    // Floating Label Property
    fileprivate var floatingTextFont: UIFont! {
        didSet {
            floatLabel.font = floatingTextFont
        }
    }
    
    // TextField property
    weak var delegate: UITextFieldDelegate? {
        didSet {
            self.textField.delegate = delegate
        }
        
    }
    
    // TextField property
    var text: String? {
        get {
            return textField.text
        }
        set {
            self.textField.text = newValue
            textField.sendActions(for: .editingDidEnd)
        }
    }
    
    // TextField property
     var font: UIFont? {
        get {
            return textField.font
        }
        set {
            self.textField.font = newValue
        }
    }
    
    // TextField property
    var textColor : UIColor? {
        get {
            return textField.textColor
        }
        set {
            self.textField.textColor = newValue
        }
    }
    
    // TextField property
    var textAlignment: NSTextAlignment {
        get {
            return textField.textAlignment
        }
        set {
            self.textField.textAlignment = newValue
        }
    }
    
    // TextField property
    var placeHolder: String? {
        get {
            return self.textField.placeholder
        }
        set {
            self.textField.placeholder = newValue
        }
    }
    
    // Custom Line View
    var lineView: UIView!
    
    // Custom Line View property
    var lineHeight:CGFloat = 0.5 {
        didSet {
            self.updateLineView()
            self.setNeedsDisplay()
        }
    }
    
    // Custom Line View property
    var lineColor:UIColor = UIColor.lightGray {
        didSet {
            self.updateLineView()
        }
    }
    
    var borderStyle: UITextBorderStyle! {
        didSet {
            textField.borderStyle = borderStyle
        }
    }
    
    // Custom Line View property
    var selectedLineHeight:CGFloat = 1.0 {
        didSet {
            self.updateLineView()
            self.setNeedsDisplay()
        }
    }
    
    // Custom Line View property
    var selectedLineColor:UIColor = UIColor.black {
        didSet {
            self.updateLineView()
        }
    }
    
    var editingOrSelected:Bool {
        get {
            return textField.isEditing || textField.isSelected;
        }
    }
    
    // Update color
    open func updateColors() {
        self.updateLineView()
        self.updateTextColor()
    }
    

    // Custom Line View function
    fileprivate func updateLineView() {
        if let lineView = self.lineView {
            lineView.frame = self.lineViewRectForBounds(self.bounds, editing: self.editingOrSelected)
            self.updateLineColor()
        }
        
    }
    
    fileprivate func updateTextColor() {
        if self.hasErrorMessage {
            textField.textColor = self.errorLabel.textColor
        } else {
            textField.textColor = self.textColor
        }
    }
    
    fileprivate func updateLineColor() {
        if self.hasErrorMessage {
            self.lineView.backgroundColor = self.errorColor
        } else {
            self.lineView.backgroundColor = self.editingOrSelected ? self.selectedLineColor : self.lineColor
        }
    }
    
    func lineViewRectForBounds(_ bounds:CGRect, editing:Bool) -> CGRect {
        let lineHeight:CGFloat = editing ? CGFloat(self.selectedLineHeight) : CGFloat(self.lineHeight)
        return CGRect(x: 0, y: bounds.size.height - lineHeight, width: bounds.size.width, height: lineHeight);
    }
    
    // Float label Property
    var floatingText: String? {
        didSet {
            if floatingText != nil {
                self.floatLabel.text = floatingText
            } else {
                self.floatLabel.text = placeHolder
            }
        }
    }
    
    // Error label Property
    var errorMessage: String = "" {
        didSet {
            if errorMessage == "" {
                hideError(true)
            } else {
                errorLabel.text = errorMessage
                hideError(false)
            }
        }
    }
    
    // Error label Property
    var attributedErrorMessage: NSAttributedString = NSAttributedString.init(string: "") {
        didSet {
            if attributedErrorMessage.string == "" {
                hideError(true)
            } else {
                errorLabel.attributedText = attributedErrorMessage
                hideError(false)
            }
        }
    }
    
    // TextField Mode - Read or Write
    fileprivate var mode: Mode! {
        didSet {
            if mode == .read {
                UIView.animate(withDuration: 0.25) { [unowned self] in
                    self.textField.isEnabled = false
                    self.textField.borderStyle = .none
                    self.hideLineView(true)
                    self.axis = .horizontal
                }
            } else {
                UIView.animate(withDuration: 0.25) { [unowned self] in
                    self.textField.isEnabled = true
                    self.textField.borderStyle = self.borderStyle
                    self.hideLineView(false)
                    self.axis = .vertical
                }
            }
        }
    }
    
    fileprivate var rules: [Rule]?
    var success: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 4
        
        createTextField()
    }
    
    func createTextField() {
        
        textField = UITextField()
        errorLabel = UILabel()
        floatLabel = UILabel()

        self.addArrangedSubview(floatLabel)
        self.addArrangedSubview(textField)
        self.addArrangedSubview(errorLabel)
    }
    
    func prepareTextField(delegate: UITextFieldDelegate?, placeHolderText: String, font: UIFont, textColor: UIColor? = .black, floatingText: String?, floatingTextColor: UIColor? = .black, floatingTextFont: UIFont?, lineColor: UIColor? = .gray, selectedLineColor: UIColor? = .black, errorColor: UIColor? = .red, textAlignment: NSTextAlignment = .left, borderStyle: UITextBorderStyle, mode: Mode? = .write, rules: [Rule]? = nil) {
        
        self.delegate = delegate
        self.placeHolder = placeHolderText
        self.font = font
        self.textColor = textColor!
        
        self.floatingText = floatingText
        self.floatingTextColor = floatingTextColor!
        
        if let floatFont = floatingTextFont {
            self.floatingTextFont = floatFont
        } else {
            self.floatingTextFont = font
        }
        
        self.lineColor = lineColor!
        self.selectedLineColor = selectedLineColor!

        
        self.errorColor = errorColor!
        self.floatingTextColor = floatingTextColor!
        self.textAlignment = textAlignment
        
        self.borderStyle = borderStyle
        if borderStyle == .none {
            createLineView()
        }
        
        self.mode = mode!
        self.rules = rules
    }
    
    fileprivate func createLineView() {
        
        if self.lineView == nil {
            let lineView = UIView()
            lineView.isUserInteractionEnabled = false
            self.lineView = lineView
            self.configureDefaultLineHeight()
        }
        lineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        self.textField.addSubview(lineView)
    }
    
    fileprivate func configureDefaultLineHeight() {
        let onePixel:CGFloat = 1.0 / UIScreen.main.scale
        self.lineHeight = 2.0 * onePixel
        self.selectedLineHeight = 2.0 * self.lineHeight
    }
    
    func hideLineView(_ flag: Bool) {
        if let lineView = self.lineView {
            lineView.isHidden = flag
        }
    }
    
    func hideError(_ flag: Bool) {
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.errorLabel.isHidden = flag
        }
    }
    
    func editingBegin() {
        self.updateColors()
    }
    
    func editingChanged() {
        self.errorMessage = ""
        let text = textField.text ?? ""
        if text != "" {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                self.floatLabel.isHidden = false
                }
        } else {
            UIView.animate(withDuration: 0.25) { [unowned self] in
                self.floatLabel.isHidden = true
            }
        }
    }
    
    func editingEnd() {
        
        if let nonOpRules = rules {
         
            for rule in nonOpRules {
                let regEx = rule.regex
                let regTest = NSPredicate(format: "SELF MATCHES %@", regEx)
                let textResult = regTest.evaluate(with: self.textField.text)
                if textResult == false {
                    success = false
                    errorMessage = rule.message
                    break
                } else {
                    success = true
                }
            }
        }
        updateColors()
    }
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
}
