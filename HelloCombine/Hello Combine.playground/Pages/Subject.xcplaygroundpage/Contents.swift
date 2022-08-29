import Foundation
import Combine

// PassthroughSubject
let relay = PassthroughSubject<String, Never>()
let subscription1 = relay.sink { value in
    print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")

//relay.send("Here")
//relay.send("we")
//relay.send("go")



// CurrentValueSubject

let variable = CurrentValueSubject<String, Never>("") // 초기값을 넣어줘야 한다.

variable.send("Initial text")

let subscription2 = variable.sink { value in
    print("subscription2 received value: \(value)")
}

variable.send("More text")
variable.value // 확인할 수 있다.





let publisher = ["Here", "we", "go"].publisher
//publisher.subscribe(relay)
publisher.subscribe(variable)
