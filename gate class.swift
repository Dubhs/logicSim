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

	func operate() -> Void
	{
		fatalError("Override this method")
	}
	
	func outputToNext() -> Void
	{
		if let connectedGate = self.cnct {
			print(
				"Connected to: " + "\(connectedGate.name)")
			print(connectedGate.input)
			connectedGate.input.append(
				self.outBuff
			)
			print(connectedGate.input)
		} else {
			print(
				"No connection for " + "\(self.name)")
		}
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

	override func operate() -> Void
	{
		if self.input.count > 1
		{
			self.outBuff = 
				self.input[0] ||
				self.input[1]
		} else {
			print("fuck")
		}
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

	override func operate() {
		if self.input.count > 1 {
			self.outBuff = 
				self.input[0] && 
				self.input[1]
		} else {
			print("fuck")
		}
	}
}

func cnct(gateArray: [Gate], inputs: [Int], out: Int) {
	for index in inputs {
		gateArray[index].cnct =
		gateArray[out]
	}
}

func Initialize() -> Void
{
	let gates = [AND(), AND(), OR()]

	cnct(
		gateArray: gates, 
		inputs: [0, 1], out: 2)

// Setting inputs and outputs
	gates[0].input
		.append(contentsOf: [true, true])
	gates[1].input
		.append(contentsOf: [true, false])

	print(gates[0].input)
}

func Main() -> Void
{
	print("•-•------•")
	for gate in Gate.allGates {
	// Check if there are enough inputs
		gate.operate()
		print(
		"gateName: \(gate.name)" + 
		" | result: \(gate.outBuff)")

		gate.outputToNext()
		print("•-•------•")
	}
}
// setup test gates
Initialize()
// iterate logic and print results
Main()




