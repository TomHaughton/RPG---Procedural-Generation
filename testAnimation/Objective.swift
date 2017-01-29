import Foundation

class Objective: Equatable{
    var description:String
    var completed:Bool = false
    var item:Item?
    var toKill:Npc?
    var numToKill:Int?
    
    init(description:String, item: Item?) {
        self.description = description
        self.item = item
    }
    
    init(description:String, toKill: Npc, numToKill:Int) {
        self.description = description
        self.toKill = toKill
        self.numToKill = numToKill
    }
    
    func isComplete(player:Player){
        if let _ = item{
            if player.inventory.items.contains(item!){
                player.inventory.remove(item!)
                completed = true
            }
        }
    }
}
