
public class ModelDuck: Duck {
	
	public override init() {
		super.init()
		flyBehavior =  FlyNoWay()
		quackBehavior = MuteQuack()
	}

	public override func display() {
		print("I'm a Model duck")
	}

}	