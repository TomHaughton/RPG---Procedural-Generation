import Foundation
import SpriteKit

class Item: SKSpriteNode {
    private struct itemProperties{
        static var itemName:String!
        static var weight:Int!
    }
    
    var itemName: String{
        get{
            return itemProperties.itemName
        }
        set{
            itemProperties.itemName = newValue
        }
    }
    
    var weight: Int{
        get{
            return itemProperties.weight
        }
        set{
            itemProperties.weight = newValue
        }
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
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