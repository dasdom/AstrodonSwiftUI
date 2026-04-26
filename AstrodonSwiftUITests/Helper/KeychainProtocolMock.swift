//  Created by Dominik Hauser on 18.04.26.
//  
//

@testable import AstrodonSwiftUI


// MARK: - KeychainProtocolMock -

final class KeychainProtocolMock: KeychainProtocol {

  // MARK: - save

  var saveStringForThrowableError: Error?
  var saveStringForCallsCount = 0
  var saveStringForCalled: Bool {
    saveStringForCallsCount > 0
  }
  var saveStringForReceivedArguments: (string: String, key: String)?
  var saveStringForReceivedInvocations: [(string: String, key: String)] = []
  var saveStringForClosure: ((String, String) throws -> Void)?

  func save(string: String, for key: String) throws {
    if let error = saveStringForThrowableError {
      throw error
    }
    saveStringForCallsCount += 1
    saveStringForReceivedArguments = (string: string, key: key)
    saveStringForReceivedInvocations.append((string: string, key: key))
    try saveStringForClosure?(string, key)
  }

  // MARK: - get

  var getForCallsCount = 0
  var getForCalled: Bool {
    getForCallsCount > 0
  }
  var getForReceivedKey: String?
  var getForReceivedInvocations: [String] = []
  var getForReturnValue: String?
  var getForClosure: ((String) -> String?)?

  func get(for key: String) -> String? {
    getForCallsCount += 1
    getForReceivedKey = key
    getForReceivedInvocations.append(key)
    return getForClosure.map({ $0(key) }) ?? getForReturnValue
  }
}
