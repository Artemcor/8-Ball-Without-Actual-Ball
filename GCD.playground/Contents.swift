import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - 1. DEADLOCK WITH TWO QUEUES:

let firstSerialQueue = DispatchQueue(label: "com.gcd.firstSerialQueue")

firstSerialQueue.async {
    print("first flow")
    DispatchQueue.main.sync {
        print("This string will never be printed")
    }
}
firstSerialQueue.sync {
    print("This one also will never be executed")
}

// MARK: - 2. CENCELLATION OF DISPATCHWORKITEM

let backgroundQueue = DispatchQueue(label: "com.gcd.backgroundqueue", attributes: .concurrent)
let workItem = DispatchWorkItem {
    while true, !workItem.isCancelled {
        print("0")
    }
}
backgroundQueue.async(execute: workItem)
backgroundQueue.asyncAfter(deadline: .now() + .seconds(2)) {
    workItem.cancel()
}
