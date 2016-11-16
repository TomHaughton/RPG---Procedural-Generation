import Foundation
import SpriteKit

class MeleeEnemy:Enemy{
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Building melee combat
    override func moveToAttack(player: Player){
        if actionForKey("attack") == nil{
            let attackWait = SKAction.runBlock(){
                self.removeActionForKey("attack")
            }
            
            if CGRectContainsPoint(CGRectOffset(player.frame, 100, 0), position){
                runAction(SKAction.sequence([SKAction.rotateByAngle(2, duration: attackSpeed),attackWait]))
            }
            else if CGRectContainsPoint(CGRectOffset(player.frame, -100, 0), position){
                runAction(SKAction.sequence([SKAction.rotateByAngle(2, duration: attackSpeed),attackWait]))
            }
            else if CGRectContainsPoint(CGRectOffset(player.frame, 0, 100), position){
                runAction(SKAction.sequence([SKAction.rotateByAngle(2, duration: attackSpeed),attackWait]))
            }
            else if CGRectContainsPoint(CGRectOffset(player.frame, 0, -100), position){
                runAction(SKAction.sequence([SKAction.rotateByAngle(2, duration: attackSpeed),attackWait]))
            }
        }
        
        if actionForKey("move") == nil{
            let moveWait = SKAction.runBlock(){
                self.removeActionForKey("move")
            }
            
            switch(shortestToPlayer(player.position)){
            case "-x":
                if !CGRectContainsPoint(player.frame, CGPointMake(position.x - 100, position.y)){
                    self.runAction(SKAction.sequence([SKAction.moveByX(-100, y: 0, duration: 0.2), SKAction.waitForDuration(0.1), moveWait]), withKey: "move")
                }
                break
            case "x":
                if !CGRectContainsPoint(player.frame, CGPointMake(position.x + 100, position.y)){
                    self.runAction(SKAction.sequence([SKAction.moveByX(100, y: 0, duration: 0.2), SKAction.waitForDuration(0.1), moveWait]), withKey: "move")
                }
                break
            case "-y":
                if !CGRectContainsPoint(player.frame, CGPointMake(position.x, position.y - 100)){
                    self.runAction(SKAction.sequence([SKAction.moveByX(0, y: -100, duration: 0.2), SKAction.waitForDuration(0.1), moveWait]), withKey: "move")
                }
                break
            case "y":
                if !CGRectContainsPoint(player.frame, CGPointMake(position.x, position.y + 100)){
                    self.runAction(SKAction.sequence([SKAction.moveByX(0, y: 100, duration: 0.2), SKAction.waitForDuration(0.1), moveWait]), withKey: "move")
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
}