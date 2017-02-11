import Foundation
import SpriteKit

func velocityMag(velocity: CGPoint) -> CGFloat{
    let x = pow(velocity.x,2)
    let y = pow(velocity.y,2)
    return sqrt(x+y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (inout left: CGPoint, right: CGPoint) {
    left = left + right
}

func -= (inout left: CGPoint, right: CGPoint) {
    left = left - right
}

func < (left: CGPoint, right: CGPoint) -> Bool {
    return left.x < right.x
}

func distance(left: CGPoint, right: CGPoint) -> CGFloat {
    let x = pow(left.x - right.x, 2)
    let y = pow(left.y - right.y, 2)
    return sqrt(x + y)
}

func == (lhs: Quest, rhs: Quest) -> Bool{
    return lhs.objectives == rhs.objectives
}

func == (lhs: [Objective], rhs: [Objective]) -> Bool{
    for i in 0...lhs.count - 1{
        if lhs[i] != rhs[i]{
            return false
        }
    }
    return true
}

func == (lhs: Objective, rhs: Objective) -> Bool{
    return lhs.description == rhs.description
}

