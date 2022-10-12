//
//  Singleton.swift
//  EssentialDeveloper
//
//  Created by Raluca Mesterca on 12.10.2022.
//

import UIKit

// singleton by the book (GOF)
let client1 = ApiClient1.getInstance()

class ApiClient1 {

    // the key point is that this class needs to have a single point of access
    private static let instance = ApiClient1()

    private init() { }

    static func getInstance() -> ApiClient1 {
        return instance
    }
}

// in Swift we can just use static let because it cannot be mutate
// the type system already enforces that for us - simple implementation
let client2 = ApiClient2.instance

class ApiClient2 {

    // the key point is that this class needs to have a single point of access
    static let instance = ApiClient2()

    private init() { }
}


// the books says you should not make a singleton a final class
// because it may be extended in the future
// pattern specifies we should allow extension
// i.e. adding more methods to the APIClient by having a subclass
let client3 = ApiClient3.instance

final class ApiClient3 {

    // the key point is that this class needs to have a single point of access
    static let instance = ApiClient3()

    private init() { }
}

//class MyApiClient: ApiClient3 {
//
//    // add more methods or override some behaviour
//}

// However in Swift we can use extensions - no need for subclassing

extension ApiClient3 {

    // trade off:
    // we cannot override behaviour, but we can still add more behaviour
}

// if you want to allow others to change the behavior you allow subclassing
// otherwise just use extensions






