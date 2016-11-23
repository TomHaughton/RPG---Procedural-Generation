import Foundation
import SpriteKit

class Item: SKSpriteNode {
    var itemName:String!
    var weight:Int! = 1
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        name = "item"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? Item else {
            return false
        }
        let lhs = self
        
        return lhs.name == rhs.name && lhs.weight == rhs.weight
    }
}
