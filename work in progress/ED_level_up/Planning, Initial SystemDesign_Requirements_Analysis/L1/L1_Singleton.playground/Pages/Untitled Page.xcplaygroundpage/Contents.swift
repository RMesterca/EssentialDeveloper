import UIKit

// normal object
class ApiClient1 { }
let client1 = ApiClient1()


// Singleton - as defined by GOF book

/* The Singleton pattern as described in the Design Patterns book (GOF) by Gamma, Johnson, Vlissides, and Helm is a way to make sure that a class has only one instance and it provides a single point of access to it.

 The pattern specifies that the class itself should be responsible for keeping track of its sole instance. It can further ensure that no other instance can be created by intercepting requests for creating new objects and provide a way to access the sole instance.

Moreover, to ensure that the class can't be instantiated from the outside world more than once, the singleton pattern prohibits the declaration of a (visible to the module) initializer.
 */


// Singleton object
class ApiClient2 {
    private static let instance = ApiClient2()

    private init() {}

    static func getInstance() -> ApiClient2 {
        return instance
    }

}

let client2 = ApiClient2.getInstance()


struct LoggedInUser {}

// swift Singleton object
class ApiClient3 {
    static let instance = ApiClient3() //constant and lazily loaded; no need for private
    private init() {}

    func login(completion: (LoggedInUser) -> Void) { }
}

let client3 = ApiClient3.instance


// final class
final class ApiClient4 {
    static let instance = ApiClient4()
    private init() {}

    func login(completion: (LoggedInUser) -> Void) { }
}

// the singleton pattern tells us that we should be able to extend the functionality of the object
//class MyApiClient: ApiClient4 { }

// this way the functionality of ApiClient4 can be exapnded
extension ApiClient4 { }

let client4 = ApiClient4.instance


// singleton
URLSession.shared // convenience
URLSession() // we can create a different instance of url session

/*
 A variation known as a singleton with a lowercase "s," constitutes a class that is being instantiated only one time in the whole lifecycle of the app;
 however, its API does not prohibit developers from creating a new instance of the class.

 The constraint is up to the developer's choice or discipline to instantiate it only once.
 */



// Hard to test; the ApiClient method needs to be mocked
// I need to be able to at least subclass it, to be able to mock it

class LoginViewController1: UIViewController {

    func didTapLoginButton() {
        ApiClient4.instance.login() { user in
            //show next screen
        }
    }
}

class MockApiClient: ApiClient3 {
}

class LoginViewController2: UIViewController {

    var api = ApiClient3.instance // property injection

    func didTapLoginButton() {
        api.login() { user in
            //show next screen
        }
    }
}

// OR

class ApiClient5 {
    static var instance = ApiClient5()
    // make it settable; not a singleton anymore
    // looks like a singleton, but it is a mutable global state o.O

//    private init() {}

    func login(completion: (LoggedInUser) -> Void) { }
}

class MockApiClient2: ApiClient5 {
}

// testing
let mockAPI = MockApiClient2.instance
mockAPI.login { _ in }

class LoginViewController3: UIViewController {

    func didTapLoginButton() {
        ApiClient5.instance.login() { user in
            //show next screen
        }
    }
}


/*
 Another important point when it comes to singleton objects is not to be confused with mutable global shared state.
 Mutable global state is usually accessed by a static sharedInstance of a class and allows the access and mutation of that reference (static var instead of static let).

 For example, a global mutable "Context" that provides access to various values and references such as current Date, Networking and Database components.

Mutable global shared state can be risky as it increases the chances of the system being in inconsistent states.

Its state can be changed from any process/thread in the app.
 But it offers ease of use when it comes to accessing objects throughout the system and the easy configuration of the system environment (including Ambient Context injection for mocking the current time, locale, or network responses during tests).

 Its trade-offs must be well understood and thought of. There are often better alternatives, so mutable global state shouldn’t be the only tool in a developer’s arsenal.
 */


// Static global state

class ApiClient6 {
    static let shared = ApiClient6() // just one instance

    func login(completion: (LoggedInUser) -> Void) { }
}


/*
 Good Singleton candidates:

 When we need precisely one instance of a class, and it must be accessible to clients from a well-known access point.

 For example, a class that logs messages to the console is a good candidate to do so, as the system may require access to it from any given point.
 Plus, it’s API is very simple. We should only need its public API to log messages/events,
 so we don’t need more than one instance or even re-create or mutate its reference in memory.

 Moreover, if we need to extend the functionality of that class, then the singleton pattern allows us to subclass or create extensions on the class type.\

--------

 Bad Singleton candidates

 The rule of thumb is to decide which objects should be created just once.
 Singleton objects should be rare in most systems and need to have a one-to-one relationship with the system.
 Meaning "it makes sense" or it’s mandatory for a system to have only one "instance of such type."

 For example, Views are bad Singleton candidates as they should be able to allocate and deallocate memory on demand.
 The same holds for types of components such as Presenters, View Models, and Coordinators.
 */

// ------------------------------------
// ------------------------------------

struct FeedItem {}

class ApiClient7 {
    static let instance = ApiClient7()
    private init() {}

    func login(completion: (LoggedInUser) -> Void) { }

    func loadFeed(completion: ([FeedItem]) -> Void) { }
}


class LoginViewController4: UIViewController {

    func didTapLoginButton() {
        ApiClient7.instance.login() { user in
            //show feed screen
        }
    }
}


class FeedViewController: UIViewController {

    var api = ApiClient7.instance

    override func viewDidLoad() {
        super.viewDidLoad()

        loadFeed()
    }

    func loadFeed() {
        api.loadFeed { loadedItem in
            // update UI
        }
    }
}


// ------------------------------------
// ------------------------------------

//API Module
class ApiClient8 {
    static let instance = ApiClient8()

    func execute(_ : URLRequest, completion: (Data) -> Void) { }

}


// Login Module
extension ApiClient8 {
    func login(completion: (LoggedInUser) -> Void) { }
}

class LoginViewController5: UIViewController {

    func didTapLoginButton() {
        ApiClient8.instance.login() { user in
            //show feed screen
        }
    }
}

// Feed Module


extension ApiClient8 {
    func loadFeed(completion: ([FeedItem]) -> Void) { }
}

class FeedViewController2: UIViewController {
    var api = ApiClient8.instance

    override func viewDidLoad() {
        super.viewDidLoad()

        loadFeed()
    }

    func loadFeed() {
        api.loadFeed { loadedItem in
            // update UI
        }
    }
}


// ------------------------------------
// ------------------------------------

/*
 Dependency Inversion


It's a common practice for 3rd-party frameworks to provide singleton objects
 instead of allowing their clients to instantiate internal classes to facilitate
 their use (creating an instance may be complicated and require private details
 the framework creator don’t want to expose).

 Although this approach provides convenience for client developers, if the
 singleton reference is used throughout the app, it can create a tight coupling
 between the client and the external framework.

A simple way to break the tight coupling on external frameworks is to use
 dependency inversion (instead of accessing the concrete singleton instance directly).

By hiding the third-party dependency behind an interface that you own and you
 can extend (e.g., protocol/closure), you can keep the modules of your app agnostic
 about the implementation details of another external system.

 Such separation can protect the codebase from breaking changes when updating
 the external framework, make your code more testable, and also allow you to
 replace it with another framework in the future easily.

As we showcase in this lecture, you can free your modules from tight coupling
 on shared instances by inverting the dependency with an abstract interface
 (e.g., protocol or closure) and injecting the instance instead of accessing it directly.

 */


// Main Module
extension ApiClient9 {
    func login(completion: (LoggedInUser) -> Void) { }
}


extension ApiClient9 {
    func loadFeed(completion: ([FeedItem]) -> Void) { }
}

class ApiClient9 {
    static let instance = ApiClient9()
    func execute(_ : URLRequest, completion: (Data) -> Void) { }
}

// Login Module
class LoginViewController6: UIViewController {
    var login: (((LoggedInUser) -> Void) -> Void)?

    func didTapLoginButton() {
       login? { user in
            //show feed screen
        }
    }
}

// Feed Module
class FeedViewController3: UIViewController {
    var loadFeed: ((([FeedItem]) -> Void) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadFeed? { loadedItem in
            // update UI
        }
    }
}

















