//
//  ViewController.swift
//  RxSwift👷🏻
//
//  Created by Kuliza-369 on 04/09/17.
//  Copyright © 2017 Mohit Anand. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let labelValue: Variable<String> = Variable("2 way binding")
        
        _ = textField.rx.textInput <-> labelValue
        
        labelValue.asObservable().subscribe(onNext: { val in
            print(val)
            self.label.text = val
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

