//
//  ViewController.swift
//  CustomScrollView
//
//  Created by Mohitnnd on 09/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: CustomScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addViewsToScrollView()
    }


}

extension ViewController {
    func addViewsToScrollView() {
        let view1 = UIView.init(frame: CGRect.init(x: 20, y: 20, width: 100, height: 100))
        view1.backgroundColor = UIColor.systemRed
        scrollView.addSubview(view1)
        
        let view2 = UIView.init(frame: CGRect.init(x: 150, y: 160, width: 150, height: 200))
        view2.backgroundColor = UIColor.systemBlue
        scrollView.addSubview(view2)
        
        let view3 = UIView(frame: CGRect.init(x: 40, y: 400, width: 200, height: 150))
        view3.backgroundColor = UIColor.systemPink
        scrollView.addSubview(view3)
        
        let view4 = UIView(frame: CGRect.init(x: 100, y: 600, width: 180, height: 150))
        view4.backgroundColor = UIColor.systemTeal
        scrollView.addSubview(view4)
        
        let view5 = UIView(frame: CGRect.init(x: 100, y: 800, width: 180, height: 150))
        view5.backgroundColor = UIColor.systemGray
        scrollView.addSubview(view5)
        
    }
}

