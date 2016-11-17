import Foundation
import SpriteKit

class RangedEnemy:Enemy{
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToAttack(scene: GameScene){
        if actionForKey("attack") == nil{
            let attackWait = SKAction.runBlock(){
                self.removeActionForKey("attack")
            }
            
            if position.x == scene.player.position.x || position.y == scene.player.position.y{
                runAction(SKAction.sequence([SKAction.rotateByAngle(1, duration: attackSpeed),attackWait]), withKey: "attack")
            }
            else{
                removeActionForKey("attack")
            }
        }
        
        if actionForKey("move") == nil{
            let moveWait = SKAction.runBlock(){
                self.removeActionForKey("move")
            }
        
            if !(position.x == scene.player.position.x || position.y == scene.player.position.y){
                switch(shortestToPlayer(scene.player.position, scene: scene)){
                case "-x":
                    if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x - 100, position.y)){
                        self.runAction(SKAction.sequence([SKAction.moveByX(-100, y: 0, duration: 0.2), SKAction.waitForDuration(0.15), moveWait]), withKey: "move")
                    }
                    break
                case "x":
                    if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x + 100, position.y)){
                        self.runAction(SKAction.sequence([SKAction.moveByX(100, y: 0, duration: 0.2), SKAction.waitForDuration(0.15), moveWait]), withKey: "move")
                    }
                    break
                case "-y":
                    if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x, position.y - 100)){
                        self.runAction(SKAction.sequence([SKAction.moveByX(0, y: -100, duration: 0.2), SKAction.waitForDuration(0.15), moveWait]), withKey: "move")
                    }
                    break
                case "y":
                    if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x, position.y + 100)){
                        self.runAction(SKAction.sequence([SKAction.moveByX(0, y: 100, duration: 0.2), SKAction.waitForDuration(0.15), moveWait]), withKey: "move")
                    }
                    break

                default: break
                }
            }
        }
    }
    
    func shortestToPlayer(playerPos: CGPoint, scene:GameScene) -> String{
        
        if playerPos.x < position.x{
            if playerPos.y < position.y{
                if (position.x - playerPos.x) < (position.y - playerPos.y){
                    if (position.x - playerPos.x < 2){
                        attack(scene, direction:"down")
                        return ""
                    }
                    return "-x"
                }
                else {
                    if (position.y - playerPos.y < 2){
                        attack(scene, direction:"left")
                        return ""
                    }
                    return "-y"
                }
            }
            else{
                if (position.x - playerPos.x) < (playerPos.y - position.y){
                    if (position.x - playerPos.x < 2){
                        attack(scene, direction:"up")
                        return ""
                    }
                    return "-x"
                }
                else {
                    if (playerPos.y - position.y < 2){
                        attack(scene, direction:"left")
                        return ""
                    }
                    return "y"
                }

            }
        }
        else{
            if playerPos.y < position.y{
                if (playerPos.x - position.x) < (position.y - playerPos.y){
                    if playerPos.x - position.x < 2{
                        attack(scene, direction:"down")
                        return ""
                    }
                    return "x"
                }
                else {
                    if position.y - playerPos.y < 2{
                        attack(scene, direction:"right")
                        return ""
                    }
                    return "-y"
                }
            }
            else{
                if (playerPos.x - position.x) < (playerPos.y - position.y){
                    if playerPos.x - position.x < 2{
                        attack(scene, direction:"up")
                        return ""
                    }
                    return "x"
                }
                else {
                    if playerPos.y - position.y < 2{
                        attack(scene, direction:"left")
                        return ""
                    }
                    return "y"
                }
                
            }
        }
    }
    
    func attack(scene: GameScene, direction: String){
        if actionForKey("attack") == nil{
            let attackWait = SKAction.runBlock(){
                self.removeActionForKey("attack")
            }
            
            let shoot = SKAction.runBlock(){
                let projectile = Projectile()
                projectile.direction = direction
                projectile.attack = self.attack
                switch(projectile.direction){
                    case "up", "down":
                        projectile.size = CGSizeMake(20, 70)
                    break
                case "left", "right":
                    projectile.size = CGSizeMake(70, 20)
                    break
                default: break
                }
                
                projectile.color = UIColor.whiteColor()
                projectile.position = self.position
                projectile.name = "projectile"
                scene.addChild(projectile)
            }
            runAction(SKAction.sequence([shoot,SKAction.waitForDuration(attackSpeed),attackWait]),withKey: "attack")
        }
    }
}
