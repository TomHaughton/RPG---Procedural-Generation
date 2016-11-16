import Foundation
import SpriteKit

class RangedEnemy:Enemy{
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Building melee combat
    func moveToAttack(player: Player){
        if actionForKey("attack") == nil{
            let attackWait = SKAction.runBlock(){
                self.removeActionForKey("attack")
            }
            
            if CGRectContainsPoint(CGRectOffset(player.frame, 50, 0), position){
                runAction(SKAction.sequence([SKAction.rotateByAngle(2, duration: 0.4),attackWait]))
            }
            else if CGRectContainsPoint(CGRectOffset(player.frame, -50, 0), position){
                runAction(SKAction.sequence([SKAction.rotateByAngle(2, duration: 0.4),attackWait]))
            }
            else if CGRectContainsPoint(CGRectOffset(player.frame, 0, 50), position){
                runAction(SKAction.sequence([SKAction.rotateByAngle(2, duration: 0.4),attackWait]))
            }
            else if CGRectContainsPoint(CGRectOffset(player.frame, 0, -50), position){
                runAction(SKAction.sequence([SKAction.rotateByAngle(2, duration: 0.4),attackWait]))
            }
        }
        
        if actionForKey("move") == nil{
            let moveWait = SKAction.runBlock(){
                self.removeActionForKey("move")
            }
            
            //            uncomment below line for ranged combat
            //            if position.x != player.position.x || position.y != player.position.y{
            switch(shortestToPlayer(player.position)){
            case "-x":
                if !CGRectContainsPoint(player.frame, CGPointMake(position.x - 50, position.y)){
                    self.runAction(SKAction.sequence([SKAction.moveByX(-50, y: 0, duration: 0.1), moveWait]), withKey: "move")
                }
                break
            case "x":
                if !CGRectContainsPoint(player.frame, CGPointMake(position.x + 50, position.y)){
                    self.runAction(SKAction.sequence([SKAction.moveByX(50, y: 0, duration: 0.1), moveWait]), withKey: "move")
                }
                break
            case "-y":
                if !CGRectContainsPoint(player.frame, CGPointMake(position.x, position.y - 50)){
                    self.runAction(SKAction.sequence([SKAction.moveByX(0, y: -50, duration: 0.1), moveWait]), withKey: "move")
                }
                break
            case "y":
                if !CGRectContainsPoint(player.frame, CGPointMake(position.x, position.y + 50)){
                    self.runAction(SKAction.sequence([SKAction.moveByX(0, y: 50, duration: 0.1), moveWait]), withKey: "move")
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
