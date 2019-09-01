
enum PizzType: String {
    case Cheese
    case Veggie
    case Clam
    case Pepperoni
}

public class PizzaStore {
	
    public final func orderPizza(type: PizzType) -> Pizza {
        guard let pizza = createPizza(type) else {
            fatalError("this store can't supply pizza what you want")
        }
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        return pizza
    }
    
    func createPizza(_ type: PizzType) -> Pizza? {
        preconditionFailure("this mehtod must be override")
        return nil
    }
    
}
