//: [Previous](@previous)

import Foundation
import UIKit
import Combine

final class SomeViewModel {
    @Published var name: String = "Dindoo"
    var age: Int = 27
}

final class Label {
    var text: String = ""
}

let label = Label()
let vm = SomeViewModel()
print("text: \(label.text)")

vm.$name.assign(to: \.text, on: label)
print("text: \(label.text)")

vm.name = "Kim"
print("text: \(label.text)")

vm.name = "Jinsoo"
print("text: \(label.text)")

vm.age = 40
label.text = "\(vm.age)"
print("text: \(label.text)")
//: [Next](@next)
