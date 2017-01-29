import Foundation
import SpriteKit

class testQuestGiver:QuestGiver{
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        dialogue = ["Hello, can you please kill an enemy for me?","It'll really help me out!"]
        completeDialogue.append("Thank you")
        quest = BanditQuest()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
