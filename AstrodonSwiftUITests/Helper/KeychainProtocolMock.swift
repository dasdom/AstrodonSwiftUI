//  Created by Dominik Hauser on 18.04.26.
//  
//

@testable import AstrodonSwiftUI
import Combine

// MARK: - KeychainProtocolMock -

final class KeychainProtocolMock: KeychainProtocol {

  // MARK: - tokenPublisher

  var tokenPublisher: CurrentValueSubject<String?, KeychainError> {
    get { underlyingTokenPublisher }
    set(value) { underlyingTokenPublisher = value }
  }
  private var underlyingTokenPublisher: CurrentValueSubject<String?, KeychainError>! = CurrentValueSubject(nil)

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
}
