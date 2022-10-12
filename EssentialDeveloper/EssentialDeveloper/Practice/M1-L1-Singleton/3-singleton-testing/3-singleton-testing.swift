//
//  singleton-testing.swift
//  EssentialDeveloper
//
//  Created by Raluca Mesterca on 13.10.2022.
//

import UIKit

struct TestLoggedInUser {}
struct TestFeedItem {}

// singleton -  an instance that is only created once and cannot be replaced, but you can still create your own and pass it along
class TestApiClient1 {
    static let instance = TestApiClient1()

    func login(completion: (TestLoggedInUser) -> Void) { }
}

class MockTestApi1: TestApiClient1 {
    // we can intercept here the request to the login function
    // and in this way we are able to test and not make an API call

}

class LoginViewController {
    var api = TestApiClient1.instance
    func didTapLoginButton() {
        api.login() { user in
            // show feed
        }
    }
}

class TestApiClient2 {
    static let instance = TestApiClient2()

    func login(completion: (TestLoggedInUser) -> Void) { }
    func loadFeed(completion: ([TestFeedItem]) -> Void) { }
}

class FeedViewController: UIViewController {
    var api = TestApiClient2.instance

    override func viewDidLoad() {
        super.viewDidLoad()

        api.loadFeed { loadedItems in
            // update UI
        }
    }
}

/* NOTE: - by implementing a new feature - FeedViewController
 we had to add a new method to the shared type

 Why is this a problem?
 A: check diagram-singleton-testing
 Login should not care about feed and viceversa
 but right now we have different modules sharing this concrete type - ApiClient
 so every time we need to add a new method in the ApiClient we need to recompile and redeploy all the modules dependent on ApiClient - we have source code dependency in the ApiClient layer

 if i want to use the login in a different content/application how can it be moved to a separate application without having to bring the ApiClient with it

*/
