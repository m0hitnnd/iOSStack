import UIKit
import SwiftUI

protocol CustomView {
    associatedtype Body: CustomView
    var body: Body { get }
}


struct CustomText: CustomView {
    typealias Body = CustomView
}

Text("add")
//View
//protocol CustomView {
//    associatedtype Body: CustomView
//    var body: Body { get }
//}

//let a: CustomView? = nil
`
