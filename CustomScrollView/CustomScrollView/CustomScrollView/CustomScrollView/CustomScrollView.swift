//
//  CustomScrollView.swift
//  CustomScrollView
//
//  Created by Mohitnnd on 09/03/21.
//

import UIKit

class CustomScrollView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        startListeningToPanGesture()
        self.isUserInteractionEnabled = true
    }
    
    private func startListeningToPanGesture() {
        let gesture = UIPanGestureRecognizer()
        gesture.addTarget(self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(gesture)
    }
    
}

extension CustomScrollView {
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)
        let currentBounds = self.bounds
        
        print("pan - currentBounds - \(currentBounds)")
        print("pan - translation - \(translation)")
        
    }
}
