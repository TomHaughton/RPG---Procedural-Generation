import Foundation
import SpriteKit

class Update{
    func update(scene: GameScene){
        if let _ = scene.touch{
            scene.player.move(scene.touch!.locationInNode(scene), dpad: scene.ui.dpad, scene: scene.frame)
            if scene.ui.open.containsPoint(scene.touch.locationInNode(scene)) || scene.player.inventory.close.containsPoint(scene.touch.locationInNode(scene.player.inventory.inventory)){
                let toggle = SKAction.runBlock(){
                    scene.player.inventory.toggleInventory(scene, touch: scene.touch, player: scene.player)
                    SKAction.waitForDuration(5)
                }
                let wait = SKAction.runBlock(){
                    scene.removeActionForKey("toggle")
                }
                if scene.actionForKey("toggle") == nil{
                    scene.runAction(SKAction.sequence([toggle,SKAction.rotateByAngle(0, duration: 0.3),wait]), withKey: "toggle")
                }
            }
            scene.player.inventory.checkEquip(scene.touch, player: scene.player)
        }
        
        scene.enumerateChildNodesWithName("enemy"){ node, _ in
            let enemy = node as! Enemy
            enemy.moveToAttack(scene.player)
        }
        
        scene.enumerateChildNodesWithName("item"){ node, _ in
            let item = node as! Item
            if CGRectIntersectsRect(node.frame, scene.player.frame) && CGRectIntersectsRect(node.frame, scene.frame) {
                node.removeFromParent()
                scene.player.pickUp(item)
            }
        }
    }
}
