//  Created by Dominik Hauser on 25.04.26.
//  
//


import Testing
@testable import AstrodonSwiftUI
import Combine

@MainActor
struct TimelineViewModelTests {

  let keychainMock: KeychainProtocolMock
  let apiClientMock: APIClientProtocolMock
  let sut: TimelineViewModel

  init() {
    keychainMock = KeychainProtocolMock()
    apiClientMock = APIClientProtocolMock()
    sut = TimelineViewModel(keychain: keychainMock, apiClient: apiClientMock)
  }

  @Test func isPresentingAuthIsTrue_whenTokenIsMissing() async throws {
    keychainMock.tokenPublisher.send(nil)
    #expect(sut.isPresentingAuth == true)
  }

  @Test func isPresentingAuthIsFalse_whenTokenIsAdded() async throws {
    keychainMock.tokenPublisher.send("1234")
    #expect(sut.isPresentingAuth == false)
  }
}
