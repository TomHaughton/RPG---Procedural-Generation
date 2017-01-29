import Foundation
import SpriteKit

class MeleeEnemy:Enemy{
    
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
            
            if CGRectContainsPoint(CGRectOffset(scene.player.frame, 100, 0), position){
                runAction(SKAction.sequence([SKAction.waitForDuration(attackSpeed),SKAction.runBlock(){self.slash(100, y: 0, scene: scene)},attackWait]), withKey: "attack")
            }
            else if CGRectContainsPoint(CGRectOffset(scene.player.frame, -100, 0), position){
                runAction(SKAction.sequence([SKAction.waitForDuration(attackSpeed),SKAction.runBlock(){self.slash(-100, y: 0, scene: scene)},attackWait]), withKey: "attack")
            }
            else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, 100), position){
                runAction(SKAction.sequence([SKAction.waitForDuration(attackSpeed),SKAction.runBlock(){self.slash(0, y: 100, scene: scene)},attackWait]), withKey: "attack")
            }
            else if CGRectContainsPoint(CGRectOffset(scene.player.frame, 0, -100), position){
                runAction(SKAction.sequence([SKAction.waitForDuration(attackSpeed),SKAction.runBlock(){self.slash(0, y: -100, scene: scene)},attackWait]), withKey: "attack")
            }
            else {
                removeActionForKey("attack")
            }
        }
        
        if actionForKey("move") == nil{
            let moveWait = SKAction.runBlock(){
                self.removeActionForKey("move")
            }
            
            switch(shortestToPlayer(scene.player.position)){
            case "-x":
                if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x - 100, position.y)){
                    if checkSurroundings(scene, x: -100, y: 0){
                        self.runAction(SKAction.sequence([SKAction.moveByX(-50, y: 0, duration: 0.1), SKAction.waitForDuration(0.1), moveWait]), withKey: "move")
                    }
                }
                break
            case "x":
                if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x + 100, position.y)){
                    if checkSurroundings(scene, x: 100, y: 0){
                        self.runAction(SKAction.sequence([SKAction.moveByX(50, y: 0, duration: 0.1), SKAction.waitForDuration(0.1), moveWait]), withKey: "move")
                    }
                }
                break
            case "-y":
                if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x, position.y - 100)){
                    if checkSurroundings(scene, x: 0, y: -100){
                        self.runAction(SKAction.sequence([SKAction.moveByX(0, y: -50, duration: 0.1), SKAction.waitForDuration(0.1), moveWait]), withKey: "move")
                    }
                }
                break
            case "y":
                if !CGRectContainsPoint(scene.player.frame, CGPointMake(position.x, position.y + 100)){
                    if checkSurroundings(scene, x: 0, y: 100){
                        self.runAction(SKAction.sequence([SKAction.moveByX(0, y: 50, duration: 0.1), SKAction.waitForDuration(0.1), moveWait]), withKey: "move")
                    }
                }
                break
            default: break
            }
        }
    }
    
    func shortestToPlayer(playerPos: CGPoint) -> String{
        if playerPos.x < position.x{
            if playerPos.y < position.y{
                if (position.x - playerPos.x) > (position.y - playerPos.y){
                    return "-x"
                }
                else {
                    return "-y"
                }
            }
            else{
                if (position.x - playerPos.x) > (playerPos.y - position.y){
                    return "-x"
                }
                else {
                    return "y"
                }
                
            }
        }
        else{
            if playerPos.y < position.y{
                if (playerPos.x - position.x) > (position.y - playerPos.y){
                    return "x"
                }
                else {
                    return "-y"
                }
            }
            else{
                if (playerPos.x - position.x) > (playerPos.y - position.y){
                    return "x"
                }
                else {
                    return "y"
                }
                
            }
        }
    }
    
    func slash(x: CGFloat, y: CGFloat, scene: GameScene){
        if CGRectContainsPoint(CGRectOffset(scene.player.frame, x, y), position){
            scene.player.damage(self.attack)
            scene.player.bleed(scene)
            if scene.player.health >= 0{
                scene.ui.healthBar.size = CGSizeMake(CGFloat(1500 / scene.player.maxHealth) * CGFloat(scene.player.health), 100)
            }
        }
    }
    
    override func checkSurroundings(scene: GameScene, x: CGFloat, y:CGFloat) -> Bool{
        var canMove = false
        
//        scene.enumerateChildNodesWithName("door") { node, _ in
//            let door = node as! Door
//            if door.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
//                door.loadLevel(scene)
//                canMove = true
//            }
//        }
        
//        scene.enumerateChildNodesWithName("scenery") { node, stop in
//            let scenery = node as! Scenery
//            if !scenery.containsPoint(CGPointMake(self.position.x + x, self.position.y + y)){
//                canMove = true
//            }
//            else {
//                canMove = false
//                stop.memory = true
//            }
//        }
        
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
