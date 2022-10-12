//
//  Singleton.swift
//  EssentialDeveloper
//
//  Created by Raluca Mesterca on 12.10.2022.
//

import UIKit

// singleton by the book (GOF)
let client = ApiClient1.getInstance()

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
let client = ApiClient2.instance

class ApiClient2 {

    // the key point is that this class needs to have a single point of access
    private static let instance = ApiClient2()

    private init() { }
}



