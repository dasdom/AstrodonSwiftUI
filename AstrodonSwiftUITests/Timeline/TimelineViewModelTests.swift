//  Created by Dominik Hauser on 25.04.26.
//  
//


import Testing
@testable import AstrodonSwiftUI

struct TimelineViewModelTests {

  let keychainMock: KeychainProtocolMock
  let apiClientMock: APIClientProtocolMock
  let sut: TimelineViewModel

  init() {
    keychainMock = KeychainProtocolMock()
    keychainMock.tokenReturnValue = nil
    apiClientMock = APIClientProtocolMock()
    sut = TimelineViewModel(keychain: keychainMock, apiClient: apiClientMock)
  }

  @Test func isPresentingAuthIsTrue_whenTokenIsMissing() async throws {
    #expect(sut.isPresentingAuth == true)
  }


}
