//  Created by Dominik Hauser on 25.04.26.
//  
//


import Testing
@testable import AstrodonSwiftUI

struct TimelineViewModelTests {

  let keychainMock: KeychainProtocolMock
  let sut: TimelineViewModel

  init() {
    keychainMock = KeychainProtocolMock()
    keychainMock.getForReturnValue = nil
    sut = TimelineViewModel(keychain: keychainMock)
  }

  @Test func isPresentingAuthIsTrue_whenTokenIsMissing() async throws {
    #expect(sut.isPresentingAuth == true)
  }

}
