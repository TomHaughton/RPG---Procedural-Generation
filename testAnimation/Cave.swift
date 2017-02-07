import SpriteKit

class Cave: Dungeon{
    override init(size: CGSize, player: Player, seed: [Int], direction: String, location: CGPoint, count: Int){
        super.init(size: size, player: player, seed: seed, direction: direction, location: location, count: count)
        smallBkg = SKSpriteNode(imageNamed: "caveSmlBkg")
        smallWalls = SKSpriteNode(imageNamed: "caveSmlWalls")
        tallBkg = SKSpriteNode(imageNamed: "caveSmlBkg")
        tallWalls = SKSpriteNode(imageNamed: "caveTallWalls")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
