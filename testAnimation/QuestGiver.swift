import Foundation
import SpriteKit

class QuestGiver:Npc{
    var quest:Quest?
    var help: Item?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        name = "quest"
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.dynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func giveQuest(player:Player){
        if let _ = quest{
            if let _ = help{
                player.pickUp(help!)
            }
            player.questLog.append(quest!)
        }
    }
    
//    func completeQuest(player:Player){
//        for quest in player.questLog{
//            if object_getClassName(quest) == object_getClassName(self.quest){
//                quest.giveReward(player)
//            }
//        }
//    }
    
    func showDialogue(scene: GameScene){
        let _ = DialogueBox(dialogue: dialogue, scene: scene)
    }
    
    func showThanks(scene: GameScene){
        let _ = DialogueBox(dialogue: completeDialogue, scene: scene)
    }
}
