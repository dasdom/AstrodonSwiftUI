//  Created by Dominik Hauser on 18.04.26.
//  
//

@testable import AstrodonSwiftUI


// MARK: - KeychainProtocolMock -

final class KeychainProtocolMock: KeychainProtocol {

  // MARK: - save

  var saveTokenThrowableError: Error?
  var saveTokenCallsCount = 0
  var saveTokenCalled: Bool {
    saveTokenCallsCount > 0
  }
  var saveTokenReceivedToken: String?
  var saveTokenReceivedInvocations: [String?] = []
  var saveTokenClosure: ((String?) throws -> Void)?

  func save(token: String?) throws {
    if let error = saveTokenThrowableError {
      throw error
    }
    saveTokenCallsCount += 1
    saveTokenReceivedToken = token
    saveTokenReceivedInvocations.append(token)
    try saveTokenClosure?(token)
  }

  // MARK: - token

  var tokenCallsCount = 0
  var tokenCalled: Bool {
    tokenCallsCount > 0
  }
  var tokenReturnValue: String?
  var tokenClosure: (() -> String?)?

  func token() -> String? {
    tokenCallsCount += 1
    return tokenClosure.map({ $0() }) ?? tokenReturnValue
  }
}
