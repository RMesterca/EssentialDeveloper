#  Have you ever been told that Singleton is an anti-pattern?

In the right context, Singletons can be ok. But if you are not careful, they aren’t just an anti-pattern. THEY CAN BE DANGEROUS!

In this lecture, we address the good and bad traits of the Singleton pattern, its common benefits, and pitfalls, and showcase how dependency inversion can help us protect our systems in 4 simple steps.

What is a Singleton?
The Singleton pattern as described in the Design Patterns book (GOF) by Gamma, Johnson, Vlissides, and Helm is a way to make sure that a class has only one instance and it provides a single point of access to it. The pattern specifies that the class itself should be responsible for keeping track of its sole instance. It can further ensure that no other instance can be created by intercepting requests for creating new objects and provide a way to access the sole instance.

Moreover, to ensure that the class can't be instantiated from the outside world more than once, the singleton pattern prohibits the declaration of a (visible to the module) initializer.

What is a singleton with a lowercase "s"?
A variation known as a singleton with a lowercase "s," constitutes a class that is being instantiated only one time in the whole lifecycle of the app; however, its API does not prohibit developers from creating a new instance of the class. The constraint is up to the developer's choice or discipline to instantiate it only once.

Some examples of such objects are Apple’s URLSession.shared and UserDefaults.standard. Although they offer a shared instance for accessing an immutable reference (get only) of themselves, they also allow their clients to create other instances through their initializers.

Singletons vs. Global Mutable Shared State
Another important point when it comes to singleton objects is not to be confused with mutable global shared state. Mutable global state is usually accessed by a static sharedInstance of a class and allows the access and mutation of that reference (static var instead of static let). For example, a global mutable "Context" that provides access to various values and references such as current Date, Networking and Database components.

Mutable global shared state can be risky as it increases the chances of the system being in inconsistent states. Its state can be changed from any process/thread in the app. But it offers ease of use when it comes to accessing objects throughout the system and the easy configuration of the system environment (including Ambient Context injection for mocking the current time, locale, or network responses during tests). Its trade-offs must be well understood and thought of.

There are often better alternatives, so mutable global state shouldn’t be the only tool in a developer’s arsenal.

Examples of good Singleton candidates
So when should we use the singleton pattern?

When we need precisely one instance of a class, and it must be accessible to clients from a well-known access point.

For example, a class that logs messages to the console is a good candidate to do so, as the system may require access to it from any given point. Plus, it’s API is very simple. We should only need its public API to log messages/events, so we don’t need more than one instance or even re-create or mutate its reference in memory.

Moreover, if we need to extend the functionality of that class, then the singleton pattern allows us to subclass or create extensions on the class type.

Examples of bad Singleton candidates
The rule of thumb is to decide which objects should be created just once. Singleton objects should be rare in most systems and need to have a one-to-one relationship with the system. Meaning "it makes sense" or it’s mandatory for a system to have only one "instance of such type."

For example, Views are bad Singleton candidates as they should be able to allocate and deallocate memory on demand. The same holds for types of components such as Presenters, View Models, and Coordinators.

Dependency Inversion
It's a common practice for 3rd-party frameworks to provide singleton objects instead of allowing their clients to instantiate internal classes to facilitate their use (creating an instance may be complicated and require private details the framework creator don’t want to expose). Although this approach provides convenience for client developers, if the singleton reference is used throughout the app, it can create a tight coupling between the client and the external framework.

A simple way to break the tight coupling on external frameworks is to use dependency inversion (instead of accessing the concrete singleton instance directly). By hiding the third-party dependency behind an interface that you own and you can extend (e.g., protocol/closure), you can keep the modules of your app agnostic about the implementation details of another external system. Such separation can protect the codebase from breaking changes when updating the external framework, make your code more testable, and also allow you to replace it with another framework in the future easily.

As we showcase in this lecture, you can free your modules from tight coupling on shared instances by inverting the dependency with an abstract interface (e.g., protocol or closure) and injecting the instance instead of accessing it directly.

References
Design Patterns https://www.goodreads.com/book/show/85009.Design_Patterns

