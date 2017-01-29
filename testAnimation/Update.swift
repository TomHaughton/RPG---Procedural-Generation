import Foundation
import SpriteKit

class Update{
    func update(scene: GameScene, currentTime: NSTimeInterval){
        
        if let _ = scene.touches{
            let orderedTouches = Array(scene.touches).sort{ $0.locationInNode(scene.ui.ui) < $1.locationInNode(scene.ui.ui)}
            for touch in orderedTouches{
                let touchLoc = touch.locationInNode(scene.ui.ui)
                //                scene.player.move(touchLoc, dpad: scene.ui.dpad, scene: scene)
                scene.player.move(touch, scene: scene)
                scene.player.doAttack(scene, touch: touch)
                
                if scene.ui.open.containsPoint(touchLoc) || scene.player.inventory.close.containsPoint(touch.locationInNode(scene.player.inventory.inventory)){
                    let toggle = SKAction.runBlock(){
                        scene.player.inventory.toggleInventory(scene, touch: touchLoc, player: scene.player)
                    }
                    let wait = SKAction.runBlock(){
                        scene.removeActionForKey("toggle")
                    }
                    if scene.actionForKey("toggle") == nil{
                        scene.runAction(SKAction.sequence([toggle,SKAction.waitForDuration(0.3),wait]), withKey: "toggle")
                    }
                }
                scene.player.inventory.checkEquip(touch, player: scene.player)
                
                scene.ui.ui.enumerateChildNodesWithName("dialogue"){ node, _ in
                    let dia = node as! DialogueBox
                    if dia.containsPoint(touchLoc){
                        dia.nextDialogue(scene)
                    }
                }
            }
        }
        
        if !scene.pause{
            //Taken from 2dtv/ios
            if scene.lastUpdateTime > 0 {
                scene.dt = currentTime - scene.lastUpdateTime
            } else {
                scene.dt = 0
            }
            scene.lastUpdateTime = currentTime
            //
            
            if !(scene.player.health <= 0){
                scene.ui.healthBar.size = CGSizeMake(CGFloat(1500 / scene.player.maxHealth) * CGFloat(scene.player.health), 100)
            }
            else{
                //DO SOMETHING WITH GAME OVER
            }
            
            if !scene.bossFight{
                scene.camera?.position = scene.player.position
            }
            
            if let _ = scene.camFrame{
                scene.camFrame.position = scene.player.position
                
                scene.enumerateChildNodesWithName("enemy"){ node, _ in
                    let enemy = node as! Enemy
                    if CGRectIntersectsRect(enemy.frame, scene.camFrame.frame){
                        enemy.moveToAttack(scene)
                    }
                }
            }
            else {
                scene.enumerateChildNodesWithName("enemy"){ node, _ in
                    if node.isMemberOfClass(Boss){
                        let boss = node as! Boss
                        boss.chooseAttack(scene)
                    }
                    else {
                        let enemy = node as! Enemy
                        enemy.moveToAttack(scene)
                    }
                }
            }
            
            scene.enumerateChildNodesWithName("item"){ node, _ in
                let item = node as! Item
                if CGRectIntersectsRect(item.frame, scene.player.frame) /*&& CGRectIntersectsRect(item.frame, scene.frame)*/ {
                    node.removeFromParent()
                    scene.player.pickUp(item)
                    let label = SKLabelNode(text: "Picked up \(item.itemName)!")
                    label.fontSize = 200
                    label.fontName = "Cochin"
                    label.position = CGPointMake(0, 100)
                    let showItem = SKAction.runBlock(){
                        scene.player.addChild(label)
                    }
                    let remLabel = SKAction.runBlock(){
                        label.removeFromParent()
                    }
                    for quest in scene.player.questLog{
                        quest.checkProgress(item, player: scene.player)
                    }
                    scene.runAction(SKAction.sequence([showItem,SKAction.waitForDuration(2.0),remLabel]))
                }
            }
            
            //ABSTRACT THIS INTO RANGED ENEMY CLASS
            scene.enumerateChildNodesWithName("projectile"){ node, _ in
                let projectile = node as! Projectile
                if projectile.intersectsNode(scene.background){
                    scene.enumerateChildNodesWithName("scenery"){ node, _ in
                        let scenery = node as! Scenery
                        if CGRectIntersectsRect(scenery.frame,projectile.frame){
                            projectile.removeFromParent()
                            return
                        }
                    }
                    scene.enumerateChildNodesWithName("enemy"){ node, _ in
                        let enemy = node as! Enemy
                        if CGRectIntersectsRect(projectile.frame, enemy.frame) && projectile.friendly{
                            enemy.takeDamage(scene, attack: projectile.attack)
                            projectile.removeFromParent()
                        }
                    }
                    
                    if CGRectIntersectsRect(projectile.frame, scene.player.frame) && !projectile.friendly{
                        projectile.removeFromParent()
                        scene.player.damage(projectile.attack)
                        scene.player.bleed(scene)
                        if scene.player.health >= 0{
                            scene.ui.healthBar.size = CGSizeMake(CGFloat(1500 / scene.player.maxHealth) * CGFloat(scene.player.health), 100)
                        }
                        else {
                            scene.ui.healthBar.size = CGSizeMake(0, 100)
                        }
                    }
                    else if !CGRectIntersectsRect(projectile.frame, scene.background.frame){
                        projectile.removeFromParent()
                    }
                    else{
                        if projectile.velocity != CGPoint.zero{
                            projectile.move(scene)
                        }
                    }
                }
                else {
                    projectile.removeFromParent()
                }
            }
        }
    }
}
