//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//

import Foundation
import PlaygroundSupport
//#-end-hidden-code
/*:
# Asymmetric-Key Cryptography
In asymmetric-key cryptography, we use a key-pair which contains a public key and a private key. After generating a key-pair, we usually send the public one to others, and keep the private one on the disk. As a result, anyone holding your public key can use it to send encrypted messages to you, and it can only be decrypted using the corresponding private key.

This is to say, the sender doesn't need to know how to decrypt the content when encrypting, which solves the key distribution problem.

> Use `generateKeyPair()` to generate a key-pair (this may take a while)
>
> Use `encrypt(contentData: , usingPublicKey: )` and `decrypt(contentData: , usingPrivateKey: )` to encrypt/decrypt
>
> For detailed usage, see help of each function

- Example:
```
let keyPair = generateKeyPair()
let text = "TOP SECRET"
let textData = text.data(using: .utf8)!
let encrypted = encrypt(contentData: textData, usingPublicKey: keyPair.publicKey)
let decrypted = decrypt(contentData: encrypted, usingPrivateKey: keyPair.privateKey)
print(String(data: decrypted, encoding: .utf8)!)
// Output: "TOP SECRET"
```

- Important:
Encrypting/Decrypting using asymmetric-key cryptography can be **way slower** than symmetric-key cryptography, and therefore is **not suitable for large files**.
*/

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, textData, publicKey, privateKey, encryptedData, .)
// Encrypt the text using a designated public key
func encrypt(text: String, usingPublicKey publicKey: SecKey) -> Data {
	let textData = text.data(using: .utf8)!
	return encrypt(contentData: /*#-editable-code*/<#T##Plain Data##Data#>/*#-end-editable-code*/
		, usingPublicKey: /*#-editable-code*/<#T##Public Key##SecKey#>/*#-end-editable-code*/
	)
}

// Decrypt the text using a designated private key
func decrypt(encryptedData: Data, usingPrivateKey privateKey: SecKey) -> String {
	let decrypted = decrypt(contentData: /*#-editable-code*/<#T##Encrypted Data##Data#>/*#-end-editable-code*/, usingPrivateKey: /*#-editable-code*/<#T##Private Key##SecKey#>/*#-end-editable-code*/)
	return String(data: decrypted, encoding: .utf8)!
}

//#-hidden-code
let keyPair = generateKeyPair()
let randomContent = generateRandomContent()
let encrypted = encrypt(text: randomContent, usingPublicKey: keyPair.publicKey)
let decrypted = decrypt(encryptedData: encrypted, usingPrivateKey: keyPair.privateKey)
if decrypted == randomContent {
	PlaygroundPage.current.assessmentStatus = .pass(message: """
Congratulations, You've learnt how to use asymmetric-key cryptography!

[Cryptography & Privacy in Practice: Secure Chat](@next)
""")
} else {
	PlaygroundPage.current.assessmentStatus = .fail(hints: ["Please read the text above again to ensure you understand how to use asymmetric cryptography."], solution: """
```
func encrypt(text: String, usingPublicKey publicKey: SecKey) -> Data {
	let textData = text.data(using: .utf8)!
	return encrypt(contentData: textData, usingPublicKey: publicKey)
}

func decrypt(encryptedData: Data, usingPrivateKey privateKey: SecKey) -> String {
	let decrypted = decrypt(contentData: encryptedData, usingPrivateKey: privateKey)
	return String(data: decrypted, encoding: .utf8)!
}
```
""")
	
}
//#-end-hidden-code
