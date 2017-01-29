import Foundation
import SpriteKit

class Projectile:Enemy{
    var direction = ""
    var velocity: CGPoint = CGPoint.zero
    var friendly = false
    
    func move(scene:GameScene){
        let dt = CGFloat(scene.dt)
        position -= (velocity * dt)
    }
}
