import UIKit

protocol MyProtocol {
    func extensionMethod()
}
struct MyStruct: MyProtocol {
}
extension MyStruct {
    func extensionMethod() {
        print("In Struct")
    }
}
extension MyProtocol {
    func extensionMethod() {
        print("In Protocol")
    }
}

let myStruct = MyStruct()
let proto: MyProtocol = myStruct

myStruct.extensionMethod() // -> “In Struct”
proto.extensionMethod() // -> “In Protocol”


//class MyClass {
//}
//extension MyClass {
//    func extensionMethod() {}
//}
//
//class SubClass: MyClass {
//    override func extensionMethod() {}
//}


class Animal {
    init() {
        print("Animal Created")
    }

    func makeNoise() {
        fatalError("Must Override to get specific Noise")
    }
}

class Cat : Animal {
    override init() {
        print("Cat created")
    }

    override func makeNoise() {
        print("Mews")
    }
}

let cat = Cat()
cat.makeNoise()
