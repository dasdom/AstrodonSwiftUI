//  Created by Dominik Hauser on 18.04.26.
//
//

import Testing
@testable import AstrodonSwiftUI

struct AuthorizationViewModelTests {

  let apiClientMock: APIClientProtocolMock
  let keychainMock: KeychainProtocolMock
  let sut: AuthorizationViewModel

  init() {
    apiClientMock = APIClientProtocolMock()
    keychainMock = KeychainProtocolMock()
    sut = AuthorizationViewModel(apiClient: apiClientMock, keychain: keychainMock)
  }

  @Test func fetchToken_storesTokenInKeychain() async throws {
    let token = "987654321"
    apiClientMock.tokenCodeReturnValue = token
    await MainActor.run {
      sut.code = "1234"
    }

    try await sut.fetchToken()

    // Wait until the task is finished
    // (https://dev.to/abeldemoz/deterministic-unit-tests-in-swift-concurrency-465n#comment-339bh)
    try await sut.fetchTask?.value
    #expect(keychainMock.saveTokenReceivedToken == token)
  }


}
