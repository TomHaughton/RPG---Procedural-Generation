import Foundation

class Quest:Equatable{
    var objectives:[Objective] = []
    var reward:Item?
    var required:Item?
    
    init(){
    }
    
    init(item:Item?) {
        reward = item
    }
    
    //ENEMY KILLING IS DONE
    //IMPLEMENT CHECK FOR ITEM PICKUP
    
    func isComplete() -> Bool{
        return objectives[objectives.count - 1].completed == true
    }
    
    func giveReward(player: Player){
        if isComplete(){
            if let _ = reward{
                player.pickUp(reward!)
            }
        }
    }
    
    private func currentObjective() -> Int{
        for index in 0...objectives.count - 1{
            if objectives[index].completed == false{
                return index
            }
        }
        
        return objectives.count - 1
    }
    
    func checkProgress(enemy:Enemy, player:Player){
        let currentObj = objectives[currentObjective()]
        if let _ = currentObj.toKill{
            if object_getClassName(currentObj.toKill) == object_getClassName(enemy){
                currentObj.numToKill! -= 1
                if currentObj.numToKill <= 0{
                    currentObj.completed = true
                    print("complete")
                }
            }
        }
    }
    
    func checkProgress(item:Item, player:Player){
        let currentObj = objectives[currentObjective()]
        if let _ = currentObj.item{
            if object_getClassName(currentObj.item) == object_getClassName(item){
                currentObj.completed = true
                print("complete")
            }
        }
    }
}
