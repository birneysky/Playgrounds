

class NYPizzaStore: PizzaStore {
    
    override func createPizza(_ type: PizzType) -> Pizza? {
        var piz: Pizza? = nil
        switch type {
            case .Cheese:
                return 
            case .Clam:
            case .Pepperoni:
            case .Veggie
        }
        return piz
    }
}
