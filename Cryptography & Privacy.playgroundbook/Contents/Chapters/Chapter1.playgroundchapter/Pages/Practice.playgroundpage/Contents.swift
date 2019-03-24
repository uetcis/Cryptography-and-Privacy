//#-hidden-code
import UIKit
import PlaygroundSupport

let testChatData = [
"Hello, my friend!",
"Hi!"
]
var chatHistory = [String]()
fileprivate var executionMode = PlaygroundPage.current.executionMode
NotificationCenter.default.addObserver(forName: .playgroundPageExecutionModeDidChange, object: PlaygroundPage.current, queue: .main) { _ in
	executionMode = PlaygroundPage.current.executionMode
}

//#-end-hidden-code
/*:
# Cryptography & Privacy in Practice: Secure Chat

We've just learned how to use Symmetric and Asymmetric-Key Cryptography, now let's practice.

In many cases, we mix the two techniques together, so that we can solve the key-distribution problem and achieve better performance at the same time:

Users exchange their symmetric key using Asymmetric-Key Cryptography, so that no one else will know it, and therefor no one else can know what they're talking about. What's more, since they're not directly using Asymmetric-Key Cryptography to encrypt/decrypt, they can benefit from the speed of Symmetric-Key Cryptography, especially when transferring large files.

Let's try to implement the secure chat feature using this technique.
*/

public class Person: Client {
	
	public var name: String = ""
	private lazy var ownKeyPair = generateKeyPair()
	private var sharedKey: Data!
	
	public func requestSecureChat(with receiver: Client) {
		//#-hidden-code
		let status = DeliveryStatus(senderName: name,
									receiverName: receiver.name,
									viewer: name,
									content: .requestSecureChat(publicKey: ownKeyPair.publicKey))
		showStatus(status)
		//#-end-hidden-code
		//#-code-completion(everything, hide)
		//#-code-completion(identifier, show, ownKeyPair, publicKey, privateKey, sharedKey, .)
		deliver(message: Message(sender: self, receiver: receiver,
								 payload: Message.Payload(
									content: .requestSecureChat(publicKey: /*#-editable-code*/<#T##Public Key##SecKey##>/*#-end-editable-code*/))!))
	}
	
	public func didReceive(message: Message) {
		let unwrappedContent = message.payload.getContent { encryptedData in
			if self.sharedKey != nil {
				return decrypt(contentData: encryptedData, keyData: /*#-editable-code*/<#T##Shared Key Data##Data#>/*#-end-editable-code*/)
			} else {
				return decrypt(contentData: encryptedData, usingPrivateKey: /*#-editable-code*/<#T##Private Key##SecKey#>/*#-end-editable-code*/)
			}
		}
		guard let content = unwrappedContent else {
			fatalError("Cannot Decrypt Message Payload")
		}
		switch content {
		case .requestSecureChat(publicKey: let publicKey):
			sharedKey = generateRandomData()
			let payload = Message.Payload(content: .confirmSecureChat(encryptedSharedKeyData: /*#-editable-code*/<#T##Shared Key Data##Data#>/*#-end-editable-code*/)) { plainData in
				return encrypt(contentData: plainData, usingPublicKey: /*#-editable-code*/<#T##Public Key##SecKey#>/*#-end-editable-code*/)
			}
			deliver(message: Message(sender: self, receiver: message.sender, payload: payload!))
		case .confirmSecureChat(encryptedSharedKeyData: let keyData):
			sharedKey = keyData
		case .plain(text: let text):
			print("\(name) received: \"\(text)\" from \(message.sender.name)")
			//#-hidden-code
			chatHistory += [text]
			//#-end-hidden-code
		}
		//#-hidden-code
		let status = DeliveryStatus(senderName: message.sender.name,
									receiverName: message.receiver.name,
									viewer: name,
									content: content)
		showStatus(status)
		//#-end-hidden-code
	}
	
	//#-hidden-code
	public func send(text: String, to receiver: Client) {
		let payload = Message.Payload(content: .plain(text: text)) { plainData in
			return encrypt(contentData: plainData, keyData: self.sharedKey)
		}
		let status = DeliveryStatus(senderName: name,
									receiverName: receiver.name,
									viewer: name,
									content: .plain(text: text))
		showStatus(status)
		deliver(message: Message(sender: self, receiver: receiver, payload: payload!))
	}
	
	public func showDelivery(for message: Message) {
		let status = DeliveryStatus(senderName: message.sender.name,
									receiverName: message.receiver.name,
									viewer: "Man in the Middle",
									content: message.payload.getContent(decryptor: nil))
		showStatus(status)
	}
	
	private func showStatus(_ status: DeliveryStatus) {
		let remoteView = getRemoteView()
		remoteView.send(.data(status.toJSONData()!))
		let interval: UInt32
		switch executionMode {
		case .runFaster:
			interval = 1
		case .runFastest:
			interval = 0
		default:
			interval = 2
		}
		sleep(interval)
	}
	
	public init(name: String) {
		self.name = name
	}
	//#-end-hidden-code
}

let alice = Person(name: "Alice")
let bob = Person(name: "Bob")

alice.requestSecureChat(with: bob)
alice.send(text: "Hello, my friend!", to: bob)
bob.send(text: "Hi!", to: alice)
//#-hidden-code
if chatHistory == testChatData {
	PlaygroundPage.current.assessmentStatus = .pass(message: """
	Congratulations! You've just excellently implemented the secure chat feature of this IM app. You're now sure to know a lot about cryptography and how it can protect our privacy.

	Finally, thanks for playing around and hope to meet you at WWDC19.
""")
} else {
	PlaygroundPage.current.assessmentStatus = .fail(hints: [
"Having trouble in real practicing? Don't worry! See if the next page solves your problem.",
"""
Common Mistake: Public Keys are used many times here, and there are 2 different public keys. Check your code again to see if you messed them up.

Fun Fact: The author once also made this mistake when debugging. 😂😂😂

Not the case? Check out the solution in the next page.
"""], solution: """
```
public class Person: Client {
	
	public var name: String = ""
	private lazy var ownKeyPair = generateKeyPair()
	private var sharedKey: Data!
	
	public func requestSecureChat(with receiver: Client) {
		deliver(message: Message(sender: self, receiver: receiver,
								 payload: Message.Payload(
									content: .requestSecureChat(publicKey: ownKeyPair.publicKey))!))
	}
	
	public func didReceive(message: Message) {
		let unwrappedContent = message.payload.getContent { encryptedData in
			if self.sharedKey != nil {
				return decrypt(contentData: encryptedData, keyData: self.sharedKey)
			} else {
				return decrypt(contentData: encryptedData, usingPrivateKey: self.ownKeyPair.privateKey)
			}
		}
		guard let content = unwrappedContent else {
			fatalError("Cannot Decrypt Message Payload")
		}
		switch content {
		case .requestSecureChat(publicKey: let publicKey):
			sharedKey = generateRandomData()
			let payload = Message.Payload(content: .confirmSecureChat(encryptedSharedKeyData: sharedKey)) { plainData in
				return encrypt(contentData: plainData, usingPublicKey: publicKey)
			}
			deliver(message: Message(sender: self, receiver: message.sender, payload: payload!))
		case .confirmSecureChat(encryptedSharedKeyData: let keyData):
			sharedKey = keyData
		case .plain(text: let text):
			break
		}
	}
	
}
```
""")
}
//#-end-hidden-code
