//  Created by Dominik Hauser on 25.04.26.
//
//


import Testing
@testable import AstrodonSwiftUI

struct KeychainTests {

  let sut = Keychain.shared

  @Test func get_returnsPreviouslySavedString() async throws {
    try await sut.save(token: "Test string")

    let result = await sut.token()

    #expect(result == "Test string")
  }

  @Test func delete_removesStoredString() async throws {
    try await sut.save(token: "Test string")

    try await sut.save(token: nil)

    let result = await sut.token()
    #expect(result == nil)
  }
}
