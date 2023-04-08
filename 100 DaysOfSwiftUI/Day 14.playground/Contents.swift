import UIKit

// Pick random num 1...100 if given array is nil or empty, else pick random number from an array
func randomArray(for array: [Int]?) -> Int { array?.randomElement() ?? Array(1...100).randomElement()! }

// Loop throw different situations
for _ in 1...20 {
    print(randomArray(for: [1,10,20,324,23,0]))
}
