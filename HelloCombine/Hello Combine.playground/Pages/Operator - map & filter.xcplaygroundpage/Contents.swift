//: [Previous](@previous)

import Foundation
import Combine

// Transform - Map
let numPublisher = PassthroughSubject<Int, Never>()
let subscription = numPublisher
    .map { $0 * 2 }
    .sink { value in
        print("Transformed Value: \(value)")
    }

numPublisher.send(10)
numPublisher.send(20)
numPublisher.send(30)
subscription.cancel()

// Filter
let stringPublisher = PassthroughSubject<String, Never>()
let subscription2 = stringPublisher
    .filter { $0.contains("a") }
    .sink { value in
        print("Filterd Value: \(value)")
    }

stringPublisher.send("abc")
stringPublisher.send("Kim")
stringPublisher.send("Jinsoo")
stringPublisher.send("Dindoo")
stringPublisher.send("Jason")

subscription2.cancel()


//: [Next](@next)
