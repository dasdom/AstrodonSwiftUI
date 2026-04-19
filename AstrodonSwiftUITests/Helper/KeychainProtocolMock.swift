//  Created by Dominik Hauser on 18.04.26.
//  
//

@testable import AstrodonSwiftUI

// MARK: - KeychainProtocolMock -


// MARK: - KeychainProtocolMock -

final class KeychainProtocolMock: KeychainProtocol {

  // MARK: - save

  var saveStringForCallsCount = 0
  var saveStringForCalled: Bool {
    saveStringForCallsCount > 0
  }
  var saveStringForReceivedArguments: (string: String, for: String)?
  var saveStringForReceivedInvocations: [(string: String, for: String)] = []
  var saveStringForClosure: ((String, String) -> Void)?

  func save(string: String, for key: String) {
    saveStringForCallsCount += 1
    saveStringForReceivedArguments = (string: string, for: key)
    saveStringForReceivedInvocations.append((string: string, for: key))
    saveStringForClosure?(string, key)
  }

  // MARK: - get

  var getForCallsCount = 0
  var getForCalled: Bool {
    getForCallsCount > 0
  }
  var getForReceivedFor: String?
  var getForReceivedInvocations: [String] = []
  var getForReturnValue: String!
  var getForClosure: ((String) -> String)?

  func get(for key: String) -> String {
    getForCallsCount += 1
    getForReceivedFor = key
      getForReceivedInvocations.append(key)
        return getForClosure.map({ $0(key) }) ?? getForReturnValue
  }
}
