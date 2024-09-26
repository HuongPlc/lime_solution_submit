import UIKit

func solution(_ value1: Double, _ weight1: Double, _ value2: Double, _ weight2: Double, _ maxW: Double) -> Double {
    var result: Double = 0
    let canCarryBoth = maxW >= (weight1 + weight2)
    let canCarryItem1 = maxW >= weight1
    let canCarryItem2 = maxW >= weight2
    
    if canCarryBoth {
        result = value1 + value2
    } else {
        if canCarryItem1 {
            result = max(result, value1)
        }
        if canCarryItem2 {
            result = max(result, value2)
        }
    }
    
    return result
}
