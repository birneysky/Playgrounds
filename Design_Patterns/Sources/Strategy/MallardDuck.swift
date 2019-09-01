
public class MallardDuck: Duck {
	
	public override init() {
		super.init()
		flyBehavior =  FlyRocketPowered()
		quackBehavior =  Quack()
	}

	public override func display() {
		print("I'm a Mallard duck")
	}
}