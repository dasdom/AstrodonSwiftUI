//  Created by Dominik Hauser on 25.04.26.
//
//


import Testing
@testable import AstrodonSwiftUI
import Combine

@MainActor
struct KeychainTests {

  let sut = Keychain.shared

  @Test func get_returnsPreviouslySavedString() async throws {
    let results = sut.tokenPublisher.values

    try sut.save(token: "Test string")

    let result = try await results.first(where: { _ in true })
    #expect(result == "Test string")
  }

  @Test func delete_removesStoredString() async throws {
    try sut.save(token: "Test string")

    let results = sut.tokenPublisher.values
    try sut.save(token: nil)

    let result = try #require(try await results.first(where: { _ in true }))
    #expect(result == nil)
  }
}
