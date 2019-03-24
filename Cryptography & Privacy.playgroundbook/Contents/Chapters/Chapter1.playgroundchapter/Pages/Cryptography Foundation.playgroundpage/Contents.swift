//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
/*:
# Cryptography Foundation
## What's Cryptography?
In software development, we use cryptography to do a lot of things that are related to security, for example, encrypting and decrypting.
## What Will We Learn
In this playground book, we'll learn two of the most basic cryptography concepts so that you can secure the app:
### Symmetric-Key Cryptography
In symmetric-key cryptography, we use a key (just a password) which is shared between the sender and the receiver. Anyone holding the key can decrypt the content.
### Asymmetric-Key Cryptography
By contrast, in asymmetric-key cryptography, we use key-pairs. A key-pair is made up of a public key and a private key. After generating a key-pair, we keep the private one on our disk and share the public one to others. Anyone can encrypt a message using the public key, and only the holder of the corresponding private key can decrypt it.

> A bit confused, or TL;DR? Don't be afraid! You'll understand how to use them in the following part with ease.

[Let's Go!](@next)
*/
//#-hidden-code
import PlaygroundSupport
PlaygroundPage.current.assessmentStatus = .pass(message: "[Let's go!](@next)")
//#-end-hidden-code
