import Foundation

public class Duck {
	var flyBehavior: FlyBehavior!
	var quackBehavior: QuackBehavior!

	public func performFly() {
		flyBehavior.fly()
	}

	public func performQuack() {
		quackBehavior.quack()
	}

	public func display() {
		preconditionFailure("This method must be overriden");
	}
}