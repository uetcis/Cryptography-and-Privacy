//
//  Cryptography.swift
//  Book_Sources
//
//  Created by CaptainYukinoshitaHachiman on 2019/3/22.
//

import CommonCrypto
import Foundation

fileprivate let ivData = "Since we're giving a brief intro, iv is not covered in the book".data(using: .utf8)!

/**
- parameters:
	- contentData: The plain data to be encrypted
	- keyData: The shared key used to encrypt/decrypt symmetrically
- returns: The encrypted data
*/
public func encrypt(contentData: Data, keyData: Data) -> Data {
	return crypt(contentData: contentData, keyData: keyData, operation: kCCEncrypt)
}

/**
- parameters:
	- contentData: The encrypted data to be decrypted
	- keyData: The shared key used to encrypt/decrypt symmetrically
- returns: The decrypted data
*/
public func decrypt(contentData: Data, keyData: Data) -> Data {
	return crypt(contentData: contentData, keyData: keyData, operation: kCCDecrypt)
}

fileprivate func crypt(contentData: Data, keyData: Data, operation: Int) -> Data {
	let cryptLength  = size_t(contentData.count + kCCBlockSizeAES128)
	var cryptData = Data(count: cryptLength)
	
	let keyLength = size_t(kCCKeySizeAES128)
	let options = CCOptions(kCCOptionPKCS7Padding)
	
	var numBytesEncrypted: size_t = 0
	
	let cryptStatus = cryptData.withUnsafeMutableBytes { cryptBytes in
		contentData.withUnsafeBytes { dataBytes in
			ivData.withUnsafeBytes { ivBytes in
				keyData.withUnsafeBytes { keyBytes in
					CCCrypt(CCOperation(operation),
							CCAlgorithm(kCCAlgorithmAES),
							options,
							keyBytes, keyLength,
							ivBytes,
							dataBytes, contentData.count,
							cryptBytes, cryptLength,
							&numBytesEncrypted)
				}
			}
		}
	}
	
	if UInt32(cryptStatus) == UInt32(kCCSuccess) {
		cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)
	} else {
		fatalError("Error: Failed to crypt, \(cryptStatus)")
	}
	
	return cryptData
}

/**
- returns: Generated key-pair in a tuple
*/
public func generateKeyPair() -> (publicKey: SecKey, privateKey: SecKey) {
	let attributes: [String: Any] =
		[kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
		 kSecAttrKeySizeInBits as String: 4096
	]
	var error: Unmanaged<CFError>?
	if let privateKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error),
		let publicKey = SecKeyCopyPublicKey(privateKey) {
		return (publicKey: publicKey, privateKey: privateKey)
	} else {
		fatalError("Failed to generate key pair\nError: \(error!.takeRetainedValue().localizedDescription)")
	}
}

/**
- parameters:
	- contentData: The plain data to be encrypted
	- usingPublicKey: The public key used to encrypt
- returns: The encrypted data
*/
public func encrypt(contentData data: Data, usingPublicKey publicKey: SecKey) -> Data {
	var error: Unmanaged<CFError>?
	if let encrypted = SecKeyCreateEncryptedData(publicKey, .rsaEncryptionPKCS1, data as CFData, &error) {
		return encrypted as Data
	} else {
		fatalError("Failed to encrypt\nError: \(error!.takeRetainedValue().localizedDescription)")
	}
}

/**
- parameters:
	- contentData: The encrypted data to be decrypted
	- usingPrivateKey: The private key used to decrypt
- returns: The decrypted data
*/
public func decrypt(contentData data: Data, usingPrivateKey privateKey: SecKey) -> Data {
	var error: Unmanaged<CFError>?
	if let decrypted = SecKeyCreateDecryptedData(privateKey, .rsaEncryptionPKCS1, data as CFData, &error) {
		return decrypted as Data
	} else {
		fatalError("Failed to decrypt\nError: \(error!.takeRetainedValue().localizedDescription)")
	}
}

public func generateRandomContent() -> String {
	var randomContent = ""
	for _ in 1...Int.random(in: 1...64) {
		if Bool.random() {
			randomContent += "1"
		} else {
			randomContent += "0"
		}
	}
	return randomContent
}

public func generateRandomData() -> Data {
	var keyData = Data(count: 128)
	let result = keyData.withUnsafeMutableBytes {
		SecRandomCopyBytes(kSecRandomDefault, 128, $0)
	}
	if result == errSecSuccess {
		return keyData
	} else {
		fatalError("Failed to generate random data")
	}
}
