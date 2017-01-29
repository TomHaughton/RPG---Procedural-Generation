import Foundation
import SpriteKit

class RangedEnemy:Enemy{
    
    var tex:String? = ""
    var projWidth:CGFloat = 100
    var projHeight:CGFloat = 100
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToAttack(scene: GameScene){
        if actionForKey("attack") == nil{
            if position.x == scene.player.position.x || position.y == scene.player.position.y{
                shortestToPlayer(scene.player.position, scene: scene)
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
                        if checkSurroundings(scene, x: -100, y: 0){
                            self.runAction(SKAction.sequence([SKAction.moveByX(-100, y: 0, duration: 0.2), SKAction.waitForDuration(0.15), moveWait]), withKey: "move")
                        }
                    }
                    break
                case "x":
                    if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x + 100, position.y)){
                        if checkSurroundings(scene, x: -100, y: 0){
                            self.runAction(SKAction.sequence([SKAction.moveByX(100, y: 0, duration: 0.2), SKAction.waitForDuration(0.15), moveWait]), withKey: "move")
                        }
                    }
                    break
                case "-y":
                    if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x, position.y - 100)){
                        if checkSurroundings(scene, x: 0, y: -100){
                            self.runAction(SKAction.sequence([SKAction.moveByX(0, y: -100, duration: 0.2), SKAction.waitForDuration(0.15), moveWait]), withKey: "move")
                        }
                    }
                    break
                case "y":
                    if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x, position.y + 100)){
                        if checkSurroundings(scene, x: 0, y: 100){
                            self.runAction(SKAction.sequence([SKAction.moveByX(0, y: 100, duration: 0.2), SKAction.waitForDuration(0.15), moveWait]), withKey: "move")
                        }
                    }
                    break

                default: break
                }
            }
        }
    }
    
    func shortestToPlayer(playerPos: CGPoint, scene:GameScene) -> String{
        attack(scene)
        if playerPos.x < position.x{
            if playerPos.y < position.y{
                if (position.x - playerPos.x) < (position.y - playerPos.y){
                    if (position.x - playerPos.x < 50){
//                        attack(scene, direction:"down")
                        return ""
                    }
                    return "-x"
                }
                else {
                    if (position.y - playerPos.y < 50){
//                        attack(scene, direction:"left")
                        return ""
                    }
                    return "-y"
                }
            }
            else{
                if (position.x - playerPos.x) < (playerPos.y - position.y){
                    if (position.x - playerPos.x < 50){
//                        attack(scene, direction:"up")
                        return ""
                    }
                    return "-x"
                }
                else {
                    if (playerPos.y - position.y < 50){
//                        attack(scene, direction:"left")
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
//                        attack(scene, direction:"down")
                        return ""
                    }
                    return "x"
                }
                else {
                    if position.y - playerPos.y < 2{
//                        attack(scene, direction:"right")
                        return ""
                    }
                    return "-y"
                }
            }
            else{
                if (playerPos.x - position.x) < (playerPos.y - position.y){
                    if playerPos.x - position.x < 2{
//                        attack(scene, direction:"up")
                        return ""
                    }
                    return "x"
                }
                else {
                    if playerPos.y - position.y < 2{
//                        attack(scene, direction:"right")
                        return ""
                    }
                    return "y"
                }
            }
        }
    }
    
    func attack(scene: GameScene){
        if actionForKey("attack") == nil{
            let attackWait = SKAction.runBlock(){
                self.removeActionForKey("attack")
            }
            
            let shoot = SKAction.runBlock(){
                let projectile = Projectile()
                projectile.texture = SKTexture.init(imageNamed: self.tex!)
                projectile.attack = self.attack
                projectile.size = CGSizeMake(self.projWidth, self.projHeight)
                
                projectile.name = "projectile"
                projectile.position = self.position
                projectile.physicsBody = nil
                projectile.zPosition = 40
                projectile.speed = 500
                
                var direction = self.position - scene.player.position
                direction = direction / velocityMag(direction) * projectile.speed
                //Adapted from 2d tvios
                projectile.zRotation = CGFloat(atan2(Double(direction.y), Double(direction.x))) + CGFloat(M_PI / 2)
                //
                
                projectile.velocity = direction
                scene.addChild(projectile)
            }
            runAction(SKAction.sequence([shoot,SKAction.waitForDuration(attackSpeed),attackWait]),withKey: "attack")
        }
    }
    
    override func checkSurroundings(scene: GameScene, x: CGFloat, y:CGFloat) -> Bool{
        var canMove = false
        
        scene.enumerateChildNodesWithName("door") { node, _ in
            let door = node as! Door
            if door.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
                door.loadLevel(scene)
                canMove = true
            }
        }
        
        scene.enumerateChildNodesWithName("scenery") { node, enemy in
            let scenery = node as! Scenery
            if !scenery.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
                canMove = true            }
            else {
                canMove = false
            }
        }
        
        scene.enumerateChildNodesWithName("enemy") { node, stop in
            let enemy = node as! Enemy
            if !enemy.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
                canMove = true
            }
            else {
                canMove = false
                stop.memory = true
            }
        }
        return canMove
    }
}
