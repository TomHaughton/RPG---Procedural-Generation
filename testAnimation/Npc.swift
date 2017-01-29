import Foundation
import SpriteKit

class Npc: SKSpriteNode{
    var npcName: String!
    var dialogue: [String] = []
    var completeDialogue: [String] = []
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

