public class Pizza {
	var name: String!
	var dough: String!
	var sauce: String!

	public func prepare() {
		print("preparing \(name)")
		print("Tossing dough...")
		print("Adding sauce...")
	}

	public func bake() {
		print("Bake for 25 minutes at 350")
	}

	public func cut() {
		print("Cutting the pizza into diagonal slices")
	}

	public func box() {
		print("Place pizza in official PizzaStore box")
	}

	public func name() -> String {
		return name
	}

}
