// ray wenderlich tutorial on generics
// quick refresh on generics needed to rewrite the current dependency injection layer in a project at work

// Intro

func addInts(x: Int, y: Int) -> Int {
    return x + y
}

let intSum = addInts(x: 1, y: 2)

func addDouble(x: Double, y: Double) -> Double {
    return x + y
}

let doubleSum = addDouble(x: 1.0, y: 2.5)

let numbers = [1, 2, 3]
let firstNumber = numbers[0]

var numbersAgain: Array<Int> = []
numbersAgain.append(1)
numbersAgain.append(2)
numbersAgain.append(3)

let firstNumberAgain = numbersAgain[0]

let countryCodes = ["Arendelle": "AR", "Genovia": "GN", "Freedonia": "FD"]
let countryCode = countryCodes["Freedonia"]

let optionalName = Optional<String>.some("Princess Moana")
if let name = optionalName {}

enum MagicError: Error {
  case spellFailure
}

func cast(_ spell: String) -> Result<String, MagicError> {
  switch spell {
  case "flowers":
    return .success("💐")
  case "stars":
    return .success("✨")
  default:
    return .failure(.spellFailure)
  }
}

let res1 = cast("flowers")
let res2 = cast("avada kedavra")


// Write a generic data structure

struct Queue<Element: Equatable> {
    private var elements: [Element] = []

    mutating func enqueue(newElement: Element) {
        elements.append(newElement)
    }

    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else { return nil }
        return elements.remove(at: 0)
    }
}

var q = Queue<Int>()
q.enqueue(newElement: 4)
q.enqueue(newElement: 2)

q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()

//q.enqueue(newElement: "banana")
//q.enqueue(newElement: 2.00)


// Write a generic function

func pairs<Key, Value>(from dict: [Key: Value]) -> [(Key, Value)] {
    return Array(dict)
}

let somePairs = pairs(from: ["min" : 199, "max": 299])
let morePairs = pairs(from: [1 : "swift", 2:"generics", 3:"rule"])


// Constraining a generic type

/// a function to sort an array and find the middle value.
//func mid<T>(array: [T]) -> T? {
//    guard !array.isEmpty else { return nil }
//    return array.sorted()[(array.count - 1) / 2]

    // return error: Referencing instance method 'sorted()' on 'Sequence' requires that 'T' conform to 'Comparable'
//}

func mid<T: Comparable>(array: [T]) -> T? {
    guard !array.isEmpty else { return nil }
    return array.sorted()[(array.count - 1) / 2]
}

mid(array: [3,5,1,2,4])

// i.e. Result: The Failure type is constrained to Error


// Cleaning up the add functions

protocol Summable {
    static func +(lhs: Self, rhs: Self) -> Self
}

extension Int: Summable {}
extension Double: Summable {}

func add<T: Summable>(x: T, y: T) -> T {
    return x + y
}

let addIntSumm = add(x: 1, y: 2)
let addDoubleSumm = add(x: 2.0, y: 1)

extension String: Summable {}
let addString = add(x: "Generics", y: " are awesome")


// extending a generic type
extension Queue {
    func peek() -> Element? {
        return elements.first
    }
}

q.peek()
q.enqueue(newElement: 5)
q.enqueue(newElement: 3)
q.peek()

// challenge -> extend the queue type to implement a function isHomogenous which check if all the elements of the queue are equal; need first tp add a type constraint in the Queue declaration to endure the elements came be checked for equality


extension Queue {
    func isHomogeneous() -> Bool {
        guard let first = elements.first else { return true }
        return !elements.contains{$0 != first }
    }
}

var h = Queue<Int>()
h.enqueue(newElement: 4)
h.enqueue(newElement: 4)
h.isHomogeneous() // true
h.enqueue(newElement: 2)
h.isHomogeneous() // false



// Subclassing a generic type

class Box<T> {
    // Just a plain old box.
}

class Gift<T> : Box<T> {
    // By default, a gift box is wrapped with plain white paper
    func wrap() {
        print("Wrap with plain white paper.")
    }
}

class Rose {
    // Flower of choice for fairytale dramas
}

class ValentinesBox: Gift<Rose> {
    // A rose for your valentine
    override func wrap() {
        print("Wrap with ♥♥♥ paper.")
    }
}

class Shoe {
    // just regular footwear
}

class GlassSlipper: Shoe {
    // a single shoe, destined for a princess
}

class ShoeBox: Box<Shoe> {
    // a box of shoes
}

let box = Box<Rose>()
let gift = Gift<Rose>()
let shoeBox = ShoeBox()

let valentines = ValentinesBox()

gift.wrap()
valentines.wrap()



// enums with associated values

enum Reward<T> {
    case treasureChest(T)
    case medal

    var message: String {
        switch self {
        case .treasureChest(let treasure):
            return "You got a chest filled with \(treasure)"
        case .medal:
            return "Stand proud, you earned a medal"
        }
    }
}

let message = Reward.treasureChest("💰").message
print(message)



