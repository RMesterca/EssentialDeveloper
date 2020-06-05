import UIKit


//D1
//----------------------------------------
// Reminder: closures are reference types, just like classes
//typealias FeedLoader = (([String]) -> Void) -> Void

protocol FeedLoader {
    func loadFeed(completion: @escaping (([String]) -> Void))
}

class FeedViewController: UIViewController {

    var loader: FeedLoader?

    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loader?.loadFeed { loadedItems in
            // update UI
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping (([String]) -> Void)) { }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping (([String]) -> Void)) { }
}


// D2
// ---------------------------------

struct Reachability {
    static var networkAvailable = false
}


class FeedViewController2: UIViewController {

    // if the user has access to internet, load the latest; if not, load cached data
    var remote: RemoteFeedLoader!
    var local: LocalFeedLoader!

    convenience init(loader: FeedLoader) {
        self.init()
        self.remote = remote
        self.local = local
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        load()
    }

    func load() {
        Reachability.networkAvailable
            ? remote.loadFeed { (loadedItems) in
                }
            : local.loadFeed { loadedItems in
        }
    }
}


// D3
// ---------------------------------

class RemoteWithLocalFallbackLoader: FeedLoader {
    let remote: RemoteFeedLoader
    let local: LocalFeedLoader

    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }

    func loadFeed(completion: @escaping ([String]) -> Void) {
        let load = Reachability.networkAvailable
            ? remote.loadFeed : local.loadFeed

        load(completion)

//        Reachability.networkAvailable
//            ? remote.loadFeed(completion: completion)
//            : local.loadFeed(completion: completion)
    }
}

class FeedViewController3: UIViewController {

    var loader: FeedLoader?

     convenience init(loader: FeedLoader) {
         self.init()
         self.loader = loader
     }

     override func viewDidLoad() {
         super.viewDidLoad()

         loader?.loadFeed { loadedItems in
             // update UI
         }
     }
}


let vc = FeedViewController(loader: RemoteFeedLoader())
let vc2 = FeedViewController(loader: LocalFeedLoader())

let vc3 = FeedViewController()
vc3.loader = RemoteWithLocalFallbackLoader(remote: RemoteFeedLoader(), local: LocalFeedLoader())

