//
//  ViewController.swift
//  StackView😮
//
//  Created by Kuliza-369 on 21/08/17.
//  Copyright © 2017 Kuliza-369. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    fileprivate var dataSource = ["Orientation Magic 🎩", "Fab Button 🙄", "TextField 😎"]
    
    fileprivate let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "defaultCell"
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        }
        
        cell?.textLabel?.text = dataSource[indexPath.row]
        
        return cell!
        
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let orientationVc = mainStoryboard.instantiateViewController(withIdentifier: "OrientationVC")
            navigationController?.pushViewController(orientationVc, animated: true)
        case 1:
            let fabVc = mainStoryboard.instantiateViewController(withIdentifier: "FabVc")
            navigationController?.pushViewController(fabVc, animated: true)
        case 2:
            let textfieldVc = mainStoryboard.instantiateViewController(withIdentifier: "TextFieldVC")
            navigationController?.pushViewController(textfieldVc, animated: true)
            
        default:
            print("invalide case")
        }
    }
}

