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
            
            let slash = SKAction.runBlock(){
                self.doAttack(scene)
            }
            
            runAction(SKAction.sequence([SKAction.waitForDuration(attackSpeed),slash,attackWait]), withKey: "attack")
        }
    
        if distance(scene.player.position, right: position) > 100{
            var velocity = position - scene.player.position
            velocity = velocity / velocityMag(velocity) * movementSpeed
            velocity = velocity * CGFloat(scene.dt) * -1
            position += velocity
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
    
    func doAttack(scene: GameScene){
        if distance(scene.player.position, right: position) < 100{
            scene.player.damage(self.attack)
            scene.player.bleed(scene)
            if scene.player.health >= 0{
                scene.ui.healthBar.size = CGSizeMake(CGFloat(1500 / scene.player.maxHealth) * CGFloat(scene.player.health), 100)
            }
        }
    }
    
    override func checkSurroundings(scene: GameScene, x: CGFloat, y:CGFloat) -> Bool{
        var canMove = false
        
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
