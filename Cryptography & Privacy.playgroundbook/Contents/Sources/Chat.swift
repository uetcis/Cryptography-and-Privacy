import UIKit
import Foundation
import PlaygroundSupport

public protocol Client {
	var name: String { get }
	func deliver(message: Message)
	func didReceive(message: Message)
	func showDelivery(for message: Message)
	func requestSecureChat(with receiver: Client)
}

public extension Client {
	
	public func deliver(message: Message) {
		showDelivery(for: message)
		message.receiver.didReceive(message: message)
	}
	
}

public struct Message {
	
	public var sender: Client
	public var receiver: Client
	public var payload: Payload
	
	public init(sender: Client, receiver: Client, payload: Payload) {
		self.sender = sender
		self.receiver = receiver
		self.payload = payload
	}
	
	public struct Payload {
		public let isEncrypted: Bool
		private let data: Data
		
		public func getContent(decryptor: ((Data) -> Data)?) -> Content? {
			var data = self.data
			if isEncrypted {
				if let decryptor = decryptor {
					data = decryptor(data)
				} else {
					return nil
				}
			}
			return try? JSONDecoder().decode(Content.self, from: data)
		}
		
		public init?(content: Content, encryptor: ((Data) -> Data)? = nil) {
			guard let data = try? JSONEncoder().encode(content) else { return nil }
			if let encryptor = encryptor {
				self.data = encryptor(data)
				isEncrypted = true
			} else {
				self.data = data
				isEncrypted = false
			}
		}
		
	}
	
	public enum Content: Codable {
		
		case plain(text: String)
		case requestSecureChat(publicKey: SecKey)
		case confirmSecureChat(encryptedSharedKeyData: Data)
		
		private enum CodingKeys: String, CodingKey {
			case type
			case data
		}
		
		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			let type = try container.decode(String.self, forKey: .type)
			let data = try container.decode(Data.self, forKey: .data)
			
			switch type {
			case "plain":
				let text = String(data: data, encoding: .utf8)!
				self = .plain(text: text)
			case "requestSecureChat":
				let attributes: [String: Any] = [
					kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
					kSecAttrKeyClass as String: kSecAttrKeyClassPublic,
					kSecAttrKeySizeInBits as String : 4096
				]
				let key = SecKeyCreateWithData(data as CFData, attributes as CFDictionary, nil)!
				self = .requestSecureChat(publicKey: key)
			case "confirmSecureChat":
				self = .confirmSecureChat(encryptedSharedKeyData: data)
			default:
				fatalError("Impossible Case")
			}
		}
		
		public func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			let type: String
			let data: Data!
			
			switch self {
			case .plain(text: let text):
				type = "plain"
				data = text.data(using: .utf8)
			case .requestSecureChat(publicKey: let key):
				type = "requestSecureChat"
				data = SecKeyCopyExternalRepresentation(key, nil) as Data?
			case .confirmSecureChat(encryptedSharedKeyData: let keyData):
				type = "confirmSecureChat"
				data = keyData
			}
			
			try container.encode(type, forKey: .type)
			try container.encode(data, forKey: .data)
		}
		
		
		public func draw(`in` rect: CGRect) {
			let contentAttributes: [NSAttributedString.Key: Any] = [
				.font: UIFont.systemFont(ofSize: 32, weight: .regular),
				.foregroundColor: #colorLiteral(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)]
			switch self {
			case .plain(text: let text):
				let drawableText = text as NSString
				drawableText.draw(in: rect,
								  withAttributes: contentAttributes)
				return
			case .confirmSecureChat(encryptedSharedKeyData: _):
				let drawableText = "Shared Key Used in Symmetric-Key Cryptography" as NSString
				drawableText.draw(in: rect, withAttributes: contentAttributes)
			case .requestSecureChat(publicKey: _):
				let drawableText = "Public Key Used in Asymmetric-Key Cryptography" as NSString
				drawableText.draw(in: rect, withAttributes: contentAttributes)
			}
		}
		
	}
	
}


/*
public class Person: Client {
	
	private lazy var ownKeyPair = generateKeyPair()
	private var sharedKey: Data?
	
	public func requestSecureChat(with receiver: Client) {
		deliver(message: Message(sender: self, receiver: receiver,
								 payload: Message.Payload(
									content: .requestSecureChat(publicKey: ownKeyPair.publicKey))!))
	}
	
	public func didReceive(message: Message) {
		let unwrappedContent = message.payload.getContent { encryptedData in
			if let key = self.sharedKey {
				return decrypt(contentData: encryptedData, keyData: key)
			} else {
				return decrypt(contentData: encryptedData, usingPrivateKey: self.ownKeyPair.privateKey)
			}
		}
		guard let content = unwrappedContent else {
			fatalError()
		}
		switch content {
		case .requestSecureChat(publicKey: let publicKey):
			sharedKey = generateRandomData()
			let payload = Message.Payload(content: .confirmSecureChat(encryptedSharedKeyData: sharedKey!)) { plainData in
				return encrypt(contentData: plainData, usingPublicKey: publicKey)
			}
			deliver(message: Message(sender: self, receiver: message.sender, payload: payload!))
		case .confirmSecureChat(encryptedSharedKeyData: let keyData):
			sharedKey = keyData
		case .plain(text: let text):
			print("\(name) received: \"\(text)\" from \(message.sender.name)")
		}
	}
	
	public func send(text: String, to receiver: Client) {
		let payload = Message.Payload(content: .plain(text: text)) { plainData in
			return encrypt(contentData: plainData, keyData: self.sharedKey!)
		}
		deliver(message: Message(sender: self, receiver: receiver, payload: payload!))
	}
	
	
	public var name: String = ""
	
	public func showDelivery(for message: Message) {
		let status = DeliveryStatus(senderName: message.sender.name,
									receiverName: message.receiver.name,
									content: message.payload.getContent(decryptor: nil))
		let remoteView = getRemoteView()
		remoteView.send(.data(status.toJSONData()!))
		sleep(2)
	}
	
	public init(name: String) {
		self.name = name
	}
	
}
*/

public struct DeliveryStatus: Codable {
	public let senderName: String
	public let receiverName: String
	public let viewer: String
	public let content: Message.Content?
	
	public init(senderName: String, receiverName: String, viewer: String, content: Message.Content?) {
		self.senderName = senderName
		self.receiverName = receiverName
		self.viewer = viewer
		self.content = content
	}
}
