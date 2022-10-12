//
//  Singleton-vs-singleton-vs-global-mutable-state-testing.swift
//  EssentialDeveloper
//
//  Created by Raluca Mesterca on 13.10.2022.
//

// How to test code that has a singleton
// you can use singletons and still have testable code

import UIKit

struct LoggedInUser {}

final class FinalApiClient {
    static let instance = FinalApiClient()
    private init() { }

    func login(completion: (LoggedInUser) -> Void) { }
}

class LoginViewController1 {

    // this would be hard to test
    func didTapLoginButton() {
        FinalApiClient.instance.login() { user in
            // do something, i.e. show next screen
        }
    }
}

// You want to test the Login View Controller is working properly
// but you don't want to make an API Request
// so how can you override this call?
// how to replace the APIClient with a mocked one?
// probably in Objc you could swizzle the getter and get a mocked one, but in this case since you cannot subclass the ApiClient and the instance is a let you cannot do it in Swift

// but there are other choices we can make here:

// 1 - I want to be able to at least subclass it
class SubclassableApiClient{
    static let instance = SubclassableApiClient()
    private init() { }

    func login(completion: (LoggedInUser) -> Void) { }
}

class MockApi1: SubclassableApiClient {
    // we can intercept here the request to the login function
    // and in this way we are able to test
    // and not make an API call

    //
}

class LoginViewController2 {

    // we can use property injection
    var apiClient = SubclassableApiClient.instance

    func didTapLoginButton() {
        apiClient.login() { user in }
    }
}

//2 - breaks the singleton pattern, but we can also do it this way
class SetabbleApiClient{
    // var instead of let
    static var instance = SetabbleApiClient()
    private init() { }

    func login(completion: (LoggedInUser) -> Void) { }
}

//SetabbleApiClient.instance = MockApi1()

class LoginViewController3 {
    func didTapLoginButton() {
        SetabbleApiClient.instance.login() { user in }
    }
}

/*  now we introduced global state for the test target
// in the setup - setup the mock client
 and in the tear down - remember to replace it back

 but this is not a singleton or Singleton anymore
 this is global mutable state
 but some still call it singleton because the syntax is very similar - looks like a singleton but it doesn't act like a singleton

 if developers see instance, sharedInstance, shared - they assume it's a singleton
 */

class MutableApiClient {
    // var instead of let
    static var instance = MutableApiClient()

    // no point for private init anymore since it's a global mutable state
    init() { }

    // no point in keeping the var if the init is not private
    // and it becomes an immutable shared instance

    func login(completion: (LoggedInUser) -> Void) { }
}

// no point in keeping the var if the init is not private
// and it becomes an immutable shared instance
class ImmutableSharedInstanceApiClient {
    static let instance = ImmutableSharedInstanceApiClient()
    func login(completion: (LoggedInUser) -> Void) { }
    // this global state is contained now
    // and this is back to lower case singleton
    // an instance that is only created once and cannot be replaced
    // but you can still create your own and pass it along
}

class MockApi2: ImmutableSharedInstanceApiClient {
    // we can intercept here the request to the login function
    // and in this way we are able to test
    // and not make an API call
}

class LoginViewController4 {
    var api = ImmutableSharedInstanceApiClient.instance
    func didTapLoginButton() {
        ImmutableSharedInstanceApiClient.instance.login() { user in

        }
    }
}


