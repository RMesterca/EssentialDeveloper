//
//  singleton-testing.swift
//  EssentialDeveloper
//
//  Created by Raluca Mesterca on 13.10.2022.
//

import UIKit

// singleton -  an instance that is only created once and cannot be replaced, but you can still create your own and pass it along
class TestApiClient {
    static let instance = ImmutableSharedInstanceApiClient()
    func login(completion: (LoggedInUser) -> Void) { }
}

class MockTestApi: TestApiClient {
    // we can intercept here the request to the login function
    // and in this way we are able to test and not make an API call

}

class LoginViewController {
    var api = TestApiClient.instance
    func didTapLoginButton() {
        TestApiClient.instance.login() { user in
            // show feed
        }
    }
}
