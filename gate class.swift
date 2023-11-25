class Gate {
	static var allGates: [Gate] = []
	var name: String
	var input: [Bool]?
	var outBuff: Bool?
//	var cnct: 
	
	init(name: String) {
		self.name = name
		Gate.allGates.append(self)
	}
	func operate(a: Bool, b: Bool) -> Bool {
		fatalError("This method should be overridden")
	}
}

class OR: Gate {
	init() {
		let className = String(describing: type(of: self))
super.init(name: "\(className)_\(Gate.allGates.count + 1)")
	}
	override func operate(a: Bool, b: Bool) -> Bool {
		return a || b
	}
}

class AND: Gate {
	init() {
		let className = String(describing: type(of: self))
		super.init(name: "\(className)_\(Gate.allGates.count + 1)")
	}
	override func operate(a: Bool, b: Bool) -> Bool {
		return a && b
	}
}

// Example Usage
let orGate = OR()
let andGate = AND()

for gate in Gate.allGates 
{
	print(gate.operate(a: true, b: false))
	print(gate.name)
}
print(Gate.allGates)