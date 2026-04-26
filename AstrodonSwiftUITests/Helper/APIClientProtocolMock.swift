//  Created by Dominik Hauser on 17.04.26.
//  
//

@testable import AstrodonSwiftUI


// MARK: - APIClientProtocolMock -

final class APIClientProtocolMock: APIClientProtocol {

  // MARK: - token

  var tokenCodeThrowableError: Error?
  var tokenCodeCallsCount = 0
  var tokenCodeCalled: Bool {
    tokenCodeCallsCount > 0
  }
  var tokenCodeReceivedCode: String?
  var tokenCodeReceivedInvocations: [String] = []
  var tokenCodeReturnValue: String!
  var tokenCodeClosure: ((String) throws -> String)?

  func token(code: String) throws -> String {
    if let error = tokenCodeThrowableError {
      throw error
    }
    tokenCodeCallsCount += 1
    tokenCodeReceivedCode = code
    tokenCodeReceivedInvocations.append(code)
    return try tokenCodeClosure.map({ try $0(code) }) ?? tokenCodeReturnValue
  }

  // MARK: - toots

  var tootsThrowableError: Error?
  var tootsCallsCount = 0
  var tootsCalled: Bool {
    tootsCallsCount > 0
  }
  var tootsReturnValue: [Toot]!
  var tootsClosure: (() throws -> [Toot])?

  func toots() throws -> [Toot] {
    if let error = tootsThrowableError {
      throw error
    }
    tootsCallsCount += 1
    return try tootsClosure.map({ try $0() }) ?? tootsReturnValue
  }
}
