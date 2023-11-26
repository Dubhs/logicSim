enum ASCIIArt {
	case horizontalLine
	case verticalLine
	case corner(CornerType)
	case custom(String)

	enum CornerType {
		case topLeft, topRight, bottomLeft, bottomRight
	}

	var character: String {
		switch self {
		case .horizontalLine:
			return "─"
		case .verticalLine:
			return "│"
		case .corner(let type):
			switch type {
			case .topLeft:
				return "┌"
			case .topRight:
				return "┐"
			case .bottomLeft:
				return "└"
			case .bottomRight:
				return "┘"
			}
		case .custom(let customChar):
			return customChar
		}
	}
	
		static func createBox(withText text: String, padding: Int = 0) -> String {
			let textLength = text.count
			let boxWidth = textLength + 2 * padding + 2  // 2 for side borders
			let horizontalBorder = String(repeating: ASCIIArt.horizontalLine.character, count: boxWidth)
	
			let topBorder = ASCIIArt.corner(.topLeft).character + horizontalBorder + ASCIIArt.corner(.topRight).character
			let bottomBorder = ASCIIArt.corner(.bottomLeft).character + horizontalBorder + ASCIIArt.corner(.bottomRight).character
	
			let paddedText = " " + String(repeating: " ", count: padding) + text + String(repeating: " ", count: padding) + " "
			let middleLine = ASCIIArt.verticalLine.character + paddedText + ASCIIArt.verticalLine.character
	
			return topBorder + "\n" + middleLine + "\n" + bottomBorder
		}
}


let box = ASCIIArt.createBox(withText: "A1")
print(box)