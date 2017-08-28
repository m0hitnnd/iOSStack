//
//  CGFloatExtension.swift
//  StackView😮
//
//  Created by Kuliza-369 on 28/08/17.
//  Copyright © 2017 Kuliza-369. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(INT32_MAX)
    }
    
}
