import Foundation
import SpriteKit

class DialogueBox:SKSpriteNode{
    var dialogue: [String] = []
    var label: SKLabelNode = SKLabelNode()
    var index = -1
    var gameScene:GameScene!
    var talking = false
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(dialogue: [String], scene: GameScene) {
        self.init(texture: nil, color: .brownColor(), size: CGSizeMake(scene.size.width, scene.size.height / 3))
        gameScene = scene
        name = "dialogue"
        self.dialogue = dialogue
        
        let margin = scene.overlapAmount() < 100 ? 200 : scene.overlapAmount()
        
        position = CGPointMake(scene.size.width / 2, margin)
        zPosition = 99
        label.text = dialogue[0]
        label.fontSize = 70
        label.fontName = "Cochin"
        label.fontColor = .whiteColor()
        scene.ui.ui.addChild(self)
        self.addChild(label)
//        scene.ui.attackStick.removeFromParent()
//        scene.ui.moveStick.removeFromParent()
        talking = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nextDialogue(scene: GameScene){
        if (actionForKey("next") == nil){
            let wait = SKAction.runBlock(){
                self.removeActionForKey("next")
            }
            let next = SKAction.runBlock(){
                if self.index + 1 < self.dialogue.count{
                    self.label.text = self.dialogue[self.index + 1]
                    self.index += 1
                }
                else{
                    self.removeFromParent()
                    self.talking = false
                    if !self.talking{
//                        scene.ui.ui.addChild(scene.ui.moveStick)
//                        scene.ui.ui.addChild(scene.ui.attackStick)
                        self.talking = true
                    }
                }
            }
            runAction(SKAction.sequence([next, SKAction.waitForDuration(0.5), wait]), withKey: "next")
        }
    }
}
