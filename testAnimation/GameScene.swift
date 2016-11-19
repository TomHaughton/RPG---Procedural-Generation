import SpriteKit

@available(iOS 9.0, *)
class GameScene: SKScene {
    
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
    
    //Taken from 2D iOS and tvOS Games by tutorials v1.3
    func overlapAmount() -> CGFloat {
        guard let view = self.view else {
            return 0 }
        let scale = view.bounds.size.width / self.size.width
        let scaledHeight = self.size.height * scale
        let scaledOverlap = scaledHeight - view.bounds.size.height
        return scaledOverlap / scale
    }
    func getCameraPosition() -> CGPoint {
        return CGPoint(x: cameraNode.position.x, y: cameraNode.position.y +
            overlapAmount()/2)
    }
    func setCameraPosition(position: CGPoint) {
        cameraNode.position = CGPoint(x: position.x, y: position.y -
            overlapAmount()/2)
    }
    //End of referenced code
}
