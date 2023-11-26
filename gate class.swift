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

class TextBasedInterface {
	var gates: [String: Gate] = [:]

	func start() {
		print("Welcome to the Logic Gate Simulator")
		var shouldContinue = true
		while shouldContinue {
			print("\nEnter command (type 'help' for commands list):")
			if let input = readLine() {
				shouldContinue = executeCommand(input)
			}
		}
	}

	private func executeCommand(_ input: String) -> Bool {
		let parts = input.split(separator: " ").map(String.init)
		guard !parts.isEmpty else { return true }

		switch parts[0].lowercased() {
		case "create":
			guard parts.count >= 3 else {
				print("Invalid command format for create.")
				return true
			}
			createGate(type: parts[1], id: parts[2])
		case "connect":
			guard parts.count >= 3 else {
				print("Invalid command format for connect.")
				return true
			}
			connectGates(from: parts[1], to: parts[2])
		case "setinput":
			guard parts.count >= 3 else {
				print("Invalid command format for setinput.")
				return true
			}
			setInput(for: parts[1], inputs: Array(parts.dropFirst(2)).map { $0 == "1" })
		case "run":
			runSimulation()
		case "exit":
			print("Exiting simulator.")
			return false
		case "help":
			printHelp()
		default:
			print("Unknown command.")
		}
		return true
	}

	private func createGate(type: String, id: String) {
		switch type.lowercased() {
		case "and":
			gates[id] = AND()
		case "or":
			gates[id] = OR()
		default:
			print("Unknown gate type.")
		}
	}

	private func connectGates(from: String, to: String) {
		guard let sourceGate = gates[from], let destinationGate = gates[to] else {
			print("Invalid gate identifier.")
			return
		}
		sourceGate.cnct = destinationGate
	}

	private func setInput(for id: String, inputs: [Bool]) {
		guard let gate = gates[id] else {
			print("Invalid gate identifier.")
			return
		}
		gate.input.append(contentsOf: inputs)
	}

	private func runSimulation() {
		for gate in Gate.allGates {
			gate.operate()
			gate.outputToNext()
		}
		print("Simulation complete.")
	}

	private func printHelp() {
		print(
			"""
			Commands:
			  create <type> <id> - Create a new gate ('and' or 'or') with a unique ID.
			  connect <source_id> <destination_id> - Connect two gates.
			  setinput <id> <input_values> - Set inputs for a gate (1 for true, 0 for false).
			  run - Run the simulation.
			  exit - Exit the simulator.
			""")
	}
}

let interface = TextBasedInterface()
interface.start()

