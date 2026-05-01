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

  // MARK: - homeTimeline

  var homeTimelineThrowableError: Error?
  var homeTimelineCallsCount = 0
  var homeTimelineCalled: Bool {
    homeTimelineCallsCount > 0
  }
  var homeTimelineReturnValue: [Toot]!
  var homeTimelineClosure: (() throws -> [Toot])?

  func homeTimeline() throws -> [Toot] {
    if let error = homeTimelineThrowableError {
      throw error
    }
    homeTimelineCallsCount += 1
    return try homeTimelineClosure.map({ try $0() }) ?? homeTimelineReturnValue
  }
}
