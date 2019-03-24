import Foundation

public extension Encodable {
	
	func toJSONData() -> Data? {
		let encoder = JSONEncoder()
		return try? encoder.encode(self)
	}
	
}

public extension Decodable {
	
	init?(jsonData: Data) {
		do {
			self = try JSONDecoder().decode(Self.self, from: jsonData)
		} catch {
			return nil
		}
	}
	
}
