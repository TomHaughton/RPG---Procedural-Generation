import Foundation
import SpriteKit

class Update{
    func update(scene: GameScene){
        if let _ = scene.touch{
            if scene.ui.a.containsPoint(scene.touch.locationInNode(scene)){
                scene.player.doAttack(scene)
            }
            
            scene.player.move(scene.touch!.locationInNode(scene), dpad: scene.ui.dpad, scene: scene)
            if scene.ui.open.containsPoint(scene.touch.locationInNode(scene)) || scene.player.inventory.close.containsPoint(scene.touch.locationInNode(scene.player.inventory.inventory)){
                let toggle = SKAction.runBlock(){
                    scene.player.inventory.toggleInventory(scene, touch: scene.touch, player: scene.player)
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
        
        //ABSTRACT THIS INTO RANGED ENEMY CLASS
        scene.enumerateChildNodesWithName("projectile"){ node, _ in
            let projectile = node as! Projectile
            scene.enumerateChildNodesWithName("scenery"){ node, _ in
                let scenery = node as! Scenery
                if CGRectIntersectsRect(scenery.frame,projectile.frame){
                    projectile.removeFromParent()
                    return
                }
            }
            
            if CGRectIntersectsRect(projectile.frame, scene.player.frame) {
                projectile.removeFromParent()
                scene.player.damage(projectile.attack)
                scene.player.bleed(scene)
                if scene.player.health >= 0{
                    scene.ui.healthBar.size = CGSizeMake((15 * CGFloat(scene.player.health)), 100)
                }
                else {
                    scene.ui.healthBar.size = CGSizeMake(0, 100)
                }
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
        scene.camera!.position = scene.player.position
    }
}
