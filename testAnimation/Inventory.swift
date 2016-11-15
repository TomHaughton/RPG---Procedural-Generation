class Inventory {
    var capacity: Int
    var amountFilled: Int
    var items = Array<Item>()
    
    init(capacity:Int, amountFilled: Int){
        self.capacity = capacity
        self.amountFilled = amountFilled
    }
    
    func addItem(item: Item) -> Bool{
        if (amountFilled + item.weight) < capacity {
            amountFilled += item.weight
            items.append(item)
            return true
        }
        return false
    }
    
    public func getItem(index: Int) -> Item?{
        return items[index]
    }
}