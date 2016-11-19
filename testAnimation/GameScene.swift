import SpriteKit

class GameScene: SKScene {
    
    var ui = UI()
    var update = Update()
    var player: Player!
    var touch:UITouch!
    
    override func didMoveToView(view: SKView) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = touches.first!
    }
   
    override func update(currentTime: CFTimeInterval) {
        update.update(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touch = nil
        player.removeActionForKey("animation")
    }    
}
