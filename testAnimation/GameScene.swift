import SpriteKit

@available(iOS 9.0, *)
class GameScene: SKScene {
    
    var background = SKSpriteNode()
    var ui = UI()
    var update = Update()
    var player = Player()
    var touch:UITouch!
    let cameraNode = SKCameraNode()
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        addChild(cameraNode)
        if #available(iOS 9.0, *) {
            camera = cameraNode
        } else {
            // Fallback on earlier versions
        }
        camera!.position = player.position
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
