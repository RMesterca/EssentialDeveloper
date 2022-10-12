//
//  Singleton.swift
//  EssentialDeveloper
//
//  Created by Raluca Mesterca on 12.10.2022.
//

import UIKit

// Singleton by the book (GOF)
let client1 = ApiClient1.getInstance()

class ApiClient1 {

    // the key point is that this class needs to have a single point of access
    private static let instance = ApiClient1()

    private init() { }

    static func getInstance() -> ApiClient1 {
        return instance
    }
}


// Singleton in Swift


// in Swift we can just use static let because it cannot be mutate
// the type system already enforces that for us - simple implementation
let client2 = ApiClient2.instance

class ApiClient2 {

    // the key point is that this class needs to have a single point of access
    static let instance = ApiClient2()

    private init() { }
}


// Singleton in Swift - final class


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


/// ----------------------------------------------------------------------------------
/// ----------------------------------------------------------------------------------

// singleton
/* URLSession.shared
From docs:
Discussion

For basic requests, the URLSession class provides a shared singleton session object that gives you a reasonable default behavior for creating tasks. Use the shared session to fetch the contents of a URL to memory with just a few lines of code.

Unlike the other session types, you don’t create the shared session; you merely access it by using this property directly. As a result, you don’t provide a delegate or a configuration object.

 NOTE: - Even though the documentation specifies that the the URLSession class provides a shared singleton, we can still create separate instances of URLSession - with different configurations

 This is just a convenience but it breaks the whole contract that the Singleton design pattern specifies (GOF book)

 URLSession.shared - only getter, cannot set the shared to point to another instance; you still have this unique instance per application run

 // but you can still create your own if you want to
 URLSession()
 URLSession(configuration: URLSessionConfiguration)

 Singleton - defined by GOF book
 singleton - URLSession.shared

*/

// APIClient1,2,3 - Singleton
// URLSession.shared - singleton

