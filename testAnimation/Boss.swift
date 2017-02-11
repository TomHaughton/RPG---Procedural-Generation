//
//  Boss.swift
//  testAnimation
//
//  Created by Thomas Haughton on 18/01/2017.
//  Copyright © 2017 Thomas Haughton. All rights reserved.
//

import Foundation
import SpriteKit

class Boss:Enemy{
    var stage = 0
    var timer = Timer(duration: 5)
    
    var attackWait:SKAction!
    var shoot:SKAction!
    
    init() {
        super.init(texture: SKTexture(imageNamed:"SpiderBoss"), color: .clearColor(), size: CGSizeMake(200, 200))
        defense = 10
        xp = 300
        
        attackWait = SKAction.runBlock(){
            self.removeActionForKey("attack")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func chooseAttack(scene: GameScene){
        if timer.hasFinished(){
            if stage != 3{
                stage += 1
                timer = Timer(duration: 15)
            }
            else {
                stage = 1
            }
        }
        switch(stage){
        case 1:
            simpleAttack(scene)
            break
        case 2:
            medAttack(scene)
            break
        case 3:
            hardAttack(scene)
            break
        default: break
        }
    }
    
    func simpleAttack(scene: GameScene){
        if actionForKey("attack") == nil{
            shoot = SKAction.runBlock(){
                self.initProjectile(scene)
            }
            runAction(SKAction.sequence([shoot,SKAction.waitForDuration(0.1),shoot,SKAction.waitForDuration(0.1),shoot,SKAction.waitForDuration(attackSpeed),attackWait]),withKey: "attack")
        }
    }
    
    func medAttack(scene: GameScene){
        if actionForKey("attack") == nil{
            shoot = SKAction.runBlock(){
                self.initProjectile(scene)
            }
            runAction(SKAction.sequence([shoot,SKAction.waitForDuration(0.2),attackWait]),withKey: "attack")
        }
    }
    
    func hardAttack(scene: GameScene){
        var projectiles: [Projectile] = []
        
        if actionForKey("attack") == nil{
            let attackWait = SKAction.runBlock(){
                self.removeActionForKey("attack")
            }
            
            let shoot = SKAction.runBlock(){
                for _ in 0...2{
                    projectiles.append(self.initProjectile(scene))
                }
                
                if abs(projectiles[0].velocity.x) < abs(projectiles[0].velocity.y){
                    projectiles[1].velocity.x += projectiles[0].velocity.y / 4
                    projectiles[2].velocity.x -= projectiles[0].velocity.y / 4
                }
                else {
                    projectiles[1].velocity.y += projectiles[0].velocity.x / 4
                    projectiles[2].velocity.y -= projectiles[0].velocity.x / 4
                }
                
                for i in 0...2{
                    scene.addChild(projectiles[i])
                }
            }
            runAction(SKAction.sequence([shoot,SKAction.waitForDuration(0.5),attackWait]),withKey: "attack")
            projectiles.removeAll()
        }
    }
    
    override func takeDamage(scene: GameScene, attack: Double){
        if defense == 0{
            health = health - attack
        }
        else {
            health = health - attack/defense
        }
        
        if health <= 0 {
            removeFromParent()
            if let room = scene as? Cave{
                room.enemyCount -= 1
                room.enableDoors()
            }
            drop(scene)
        }
        blink()
    }
    
    func initProjectile(scene: GameScene) -> Projectile{
        let projectile = Projectile(texture: SKTexture(imageNamed:"web"), color: .clearColor(), size: CGSizeMake(50, 50))
        projectile.name = "projectile"
        projectile.position = self.position
        projectile.physicsBody = nil
        projectile.zPosition = 40
        projectile.speed = 800
        
        var direction = self.position - scene.player.position
        direction = direction / velocityMag(direction) * projectile.speed
        
        projectile.velocity = direction
        scene.addChild(projectile)
        return projectile
    }
}
