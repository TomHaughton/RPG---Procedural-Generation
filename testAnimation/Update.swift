import Foundation
import SpriteKit

class Update{
    func update(scene: GameScene){
        if let _ = scene.touch{
            scene.player.move(scene.touch!.locationInNode(scene), dpad: scene.ui.dpad, scene: scene.frame)
            if scene.ui.open.containsPoint(scene.touch.locationInNode(scene)) || scene.player.inventory.close.containsPoint(scene.touch.locationInNode(scene.player.inventory.inventory)){
                let toggle = SKAction.runBlock(){
                    scene.player.inventory.toggleInventory(scene, touch: scene.touch, player: scene.player)
//                    SKAction.waitForDuration(5)
                }
                let wait = SKAction.runBlock(){
                    scene.removeActionForKey("toggle")
                }
                if scene.actionForKey("toggle") == nil{
                    scene.runAction(SKAction.sequence([toggle,SKAction.waitForDuration(0.3),wait]), withKey: "toggle")
                }
            }
            scene.player.inventory.checkEquip(scene.touch, player: scene.player)
        }
        
        scene.enumerateChildNodesWithName("enemy"){ node, _ in
            let enemy = node as! Enemy
            enemy.moveToAttack(scene)
        }
        
        scene.enumerateChildNodesWithName("item"){ node, _ in
            let item = node as! Item
            if CGRectIntersectsRect(node.frame, scene.player.frame) && CGRectIntersectsRect(node.frame, scene.frame) {
                node.removeFromParent()
                scene.player.pickUp(item)
            }
        }
        
        scene.enumerateChildNodesWithName("projectile"){ node, _ in
            let projectile = node as! Projectile
            if CGRectIntersectsRect(projectile.frame, scene.player.frame) {
                projectile.removeFromParent()
                scene.player.health -= projectile.attack
            }
            else if !CGRectIntersectsRect(projectile.frame, scene.frame){
                projectile.removeFromParent()
            }
            else{
                if projectile.actionForKey("move") == nil{
                    let moveWait = SKAction.runBlock(){
                        projectile.removeActionForKey("move")
                    }
                    switch(projectile.direction){
                    case "up":
                        projectile.runAction(SKAction.sequence([SKAction.moveByX(0, y: 100, duration: 0.1), moveWait]), withKey: "move")
                        break
                    case "down":
                        projectile.runAction(SKAction.sequence([SKAction.moveByX(0, y: -100, duration: 0.1), moveWait]), withKey: "move")
                        break
                    case "left":
                        projectile.runAction(SKAction.sequence([SKAction.moveByX(-100, y: 0, duration: 0.1), moveWait]), withKey: "move")
                        break
                    case "right":
                        projectile.runAction(SKAction.sequence([SKAction.moveByX(100, y: 0, duration: 0.1), moveWait]), withKey: "move")
                        break
                    default: break
                    }
                }
            }
        }
    }
}
