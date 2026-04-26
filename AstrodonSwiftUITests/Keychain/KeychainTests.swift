//  Created by Dominik Hauser on 25.04.26.
//
//


import Testing
@testable import AstrodonSwiftUI

struct KeychainTests {

  let sut = Keychain.shared

  @Test func get_returnsPreviouslySavedString() async throws {
    try await sut.save(string: "Test string", for: "test_key")

    let result = await sut.get(for: "test_key")

    #expect(result == "Test string")
  }

  @Test func delete_removesStoredString() async throws {
    try await sut.save(string: "Test string", for: "test_key")

    try await sut.delete(for: "test_key")

    let result = await sut.get(for: "test_key")
    #expect(result == nil)
  }
}
