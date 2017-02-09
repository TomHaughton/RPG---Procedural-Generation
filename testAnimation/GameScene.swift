import SpriteKit
import AVFoundation

@available(iOS 9.0, *)
class GameScene: SKScene {
    
    var background = SKSpriteNode()
    var ui = UI()
    private var update = Update()
    var player:Player!
    var touches:Set<UITouch>!
    let cameraNode = SKCameraNode()
    var musicPlayer = AVAudioPlayer()
    var camFrame:SKSpriteNode!
    var bossFight = false
    var pause = false
    
    //Taken from 2d tvios
    var lastUpdateTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    
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
        self.touches = touches
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            self.touches.insert(touch)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        update.update(self, currentTime: currentTime)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.touches = []
        player.removeActionForKey("animation")
    }
    
    //Taken from 2d tvios
    func overlapAmount() -> CGFloat {
        guard let view = self.view else {
            return 0 }
        let scale = view.bounds.size.width / self.size.width
        let scaledHeight = self.size.height * scale
        let scaledOverlap = scaledHeight - view.bounds.size.height
        return scaledOverlap / scale
    }
    //
}
