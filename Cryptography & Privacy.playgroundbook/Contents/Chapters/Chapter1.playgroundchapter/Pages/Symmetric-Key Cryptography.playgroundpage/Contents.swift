//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
/*:
# Symmetric-Key Cryptography
In symmetric-key cryptography, we use only one key (just a password) which is shared between the sender and the receiver. Anyone holding the key can decrypt the content.

> Use `encrypt(contentData: , keyData: )` and `decrypt(contentData: , keyData:)` to practise symmetric cryptography.
>
> For detailed usage, see help of each function

- Example:
```
let text = "TOP SECRET"
let password = "Yukinoshita Yukino"
let textData = text.data(using: .utf8)!
let passwordData = password.data(using: .utf8)!
let encryptedData = encrypt(contentData: textData, keyData: passwordData)
let decrypted = decrypt(contentData: encryptedData, keyData: passwordData)
print(String(data: decrypted, encoding: .utf8)!)
// Output: "TOP SECRET"
```
*/

// Encrypt the text using a designated password
func encrypt(text: String, using password: String) -> Data {
	let dataToBeEncrypted = text.data(using: .utf8)!
	let key = password.data(using: .utf8)!
	return encrypt(contentData: /*#-editable-code*/<#T##Data To Be Encrypted##Data#>/*#-end-editable-code*/
		, keyData: /*#-editable-code*/<#T##Key Data##Data#>/*#-end-editable-code*/)
}

// Decrypt the text using a designated password
func decrypt(encryptedData: Data, using password: String) -> String {
	let key = password.data(using: .utf8)!
	let decryptedData = decrypt(contentData: /*#-editable-code*/<#T##Encrypted Data##Data#>/*#-end-editable-code*/, keyData: /*#-editable-code*/<#T##Key Data##Data#>/*#-end-editable-code*/)
	return String(data: decryptedData, encoding: .utf8)!
}

//#-hidden-code
let randomContent = generateRandomContent()
let password = "Yukinoshita Yukino"
let encrypted = encrypt(text: randomContent, using: password)
let decrypted = decrypt(encryptedData: encrypted, using: password)
if decrypted == randomContent {
	PlaygroundPage.current.assessmentStatus = .pass(message: """
Congratulations, You've learnt how to use symmetric cryptography!

[Continue to learn about asymmetric cryptography](@next)
""")
} else {
	PlaygroundPage.current.assessmentStatus = .fail(hints: ["Please read the text above again to ensure you understand how to use symmetric cryptography."], solution: """
```
func encrypt(text: String, using password: String) -> Data {
	let dataToBeEncrypted = text.data(using: .utf8)!
	let key = password.data(using: .utf8)!
	return encrypt(contentData: dataToBeEncrypted, keyData: key)
}

func decrypt(encryptedData: Data, using password: String) -> String {
	let key = password.data(using: .utf8)!
	let decryptedData = decrypt(contentData: encryptedData, keyData: key)
	return String(data: decryptedData, encoding: .utf8)!
}
```
""")
	
}
//#-end-hidden-code
