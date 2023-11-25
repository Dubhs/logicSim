class Gate
{
	init(name: String)
	{
		self.name = name
		Gate.allGates.append(self)
	}
	
	static var allGates: [Gate] = []
	var name: String
	var input: [Bool] = []
	var outBuff: Bool = false
	var cnct: Gate?

	func operate(a: Bool, b: Bool) -> Bool 
	{
		fatalError("Override this method")
	}
}

class OR: Gate 
{
	init() 
	{
		let className = 
		String(describing: type(of: self))
		
		super.init(name: "\(className)" +
		"_\(Gate.allGates.count + 1)")
	}

	override func operate
	(a: Bool, b: Bool) -> Bool 
	{
		return a || b
	}
}

class AND: Gate 
{
	init()
	{
		let className = 
		String(describing: type(of: self))
		
		super.init(name: "\(className)" +
		"_\(Gate.allGates.count + 1)")
	}

	override func operate
	(a: Bool, b: Bool) -> Bool 
	{
		return a && b
	}
}

func cnct(gateArray: [Gate], inputs: [Int], out: Int) {
	for index in inputs {
		gate[index].cnct = gate[out]
	}
}

// Example Usage
let gates = [AND(), AND(), OR()]
cnct(gateArray: gates, inputs: [0, 1], out: 2)

// Setting inputs and outputs
gates[0].input
	.append(contentsOf: [true, true])
gates[1].input
	.append(contentsOf: [true, false])

print(gates[0].input)
print("•-•------•")
for gate in Gate.allGates {
	// Check if there are enough inputs
	if gate.input.count >= 2
	{
		gate.outBuff = gate.operate(
		a: gate.input[0], b: gate.input[1])
		print(
		"gateName: \(gate.name)" +
		" | result: \(gate.outBuff)")
	} else {
		print(
		"Insufficient inputs for" +
		"\(gate.name)")
	}

	if let connectedGate = gate.cnct
	{
		print(
			"Connected to: " +
			"\(connectedGate.name)")
		print(connectedGate.input)
		connectedGate.input.append(
			gate.outBuff
		)
		print(connectedGate.input)
	} else {
		print(
			"No connection for " +
			"\(gate.name)")
	}
	print("•-•------•")
}
