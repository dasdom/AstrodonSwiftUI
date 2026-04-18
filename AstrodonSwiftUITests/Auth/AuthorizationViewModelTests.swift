//  Created by Dominik Hauser on 18.04.26.
//
//

import Testing
@testable import AstrodonSwiftUI

struct AuthorizationViewModelTests {

  let apiClientMock: APIClientProtocolMock
  let sut: AuthorizationViewModel

  init() {
    apiClientMock = APIClientProtocolMock()
    sut = AuthorizationViewModel(apiClient: apiClientMock)
  }

  @Test func dummy() async throws {
    apiClientMock.tokenCodeReturnValue = "987654321"
    await MainActor.run {
      sut.code = "1234"
    }

    try await sut.fetchToken()

    // Wait until the task is finished
    // (https://dev.to/abeldemoz/deterministic-unit-tests-in-swift-concurrency-465n#comment-339bh)
    try await sut.fetchTask?.value
    #expect(apiClientMock.tokenCodeCalled == true)
  }

}
