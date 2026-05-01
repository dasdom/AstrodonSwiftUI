//  Created by Dominik Hauser on 18.04.26.
//  
//

import Foundation
import Combine

enum KeychainError: Error {
  case tokenError
  case addError
  case copyError
  case deleteError
}

class Keychain: KeychainProtocol {
  static let shared = Keychain()
  private let tokenKey = "token"
  let tokenPublisher = CurrentValueSubject<String?, KeychainError>(nil)

  func save(token: String?) throws {
    if let token {
      try save(string: token, for: tokenKey)
    } else {
      try delete(for: tokenKey)
    }
    tokenPublisher.send(token)
  }

  private func save(string: String, for key: String) throws {
    let data = string.data(using: .utf8)!
    let query = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service(),
      kSecAttrAccount: key,
      kSecValueData: data
    ] as CFDictionary

    SecItemDelete(query)
    
    let status = SecItemAdd(query as CFDictionary, nil)
    guard status == errSecSuccess else {
      throw KeychainError.addError
    }
  }
  
  private func get(for key: String) -> String? {
    let query = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service(),
      kSecAttrAccount: key,
      kSecReturnData: true,
      kSecMatchLimit: kSecMatchLimitOne
    ] as CFDictionary

    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query, &dataTypeRef)

    guard status == errSecSuccess else {
      return nil
    }
    guard let data = dataTypeRef as? Data else {
      return nil
    }

    return String(data: data, encoding: .utf8)
  }

  private func delete(for key: String) throws {
    let query = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service(),
      kSecAttrAccount: key,
      kSecValueData: Data()
    ] as CFDictionary

    let status = SecItemDelete(query)
    guard status == errSecSuccess else {
      throw KeychainError.deleteError
    }
  }

  private func service() -> String {
    return "de.dasdom.astrodon.swiftui"
  }
}
