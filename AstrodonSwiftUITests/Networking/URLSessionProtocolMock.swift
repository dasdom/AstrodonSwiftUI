//  Created by Dominik Hauser on 12.04.26.
//  
//

import Foundation
@testable import AstrodonSwiftUI

final class URLSessionProtocolMock: URLSessionProtocol {

  // MARK: - data
  var okDataReturnValue: Data? {
    didSet {
      if let okDataReturnValue = okDataReturnValue {
        dataFromDelegateReturnValue = (
          okDataReturnValue,
          HTTPURLResponse.okResponse
        )

        dataForDelegateReturnValue = (
          okDataReturnValue,
          HTTPURLResponse.okResponse
        )
      }
    }
  }

  var dataFromDelegateThrowableError: Error?
  var dataFromDelegateCallsCount = 0
  var dataFromDelegateCalled: Bool {
    dataFromDelegateCallsCount > 0
  }
  var dataFromDelegateReceivedArguments: (url: URL, delegate: URLSessionTaskDelegate?)?
  var dataFromDelegateReceivedInvocations: [(url: URL, delegate: URLSessionTaskDelegate?)] = []
  var dataFromDelegateReturnValue: (Data, URLResponse)!
  var dataFromDelegateClosure: ((URL, URLSessionTaskDelegate?) throws -> (Data, URLResponse))?

  func data(from url: URL, delegate: URLSessionTaskDelegate?) throws -> (Data, URLResponse) {
    if let error = dataFromDelegateThrowableError {
      throw error
    }
    dataFromDelegateCallsCount += 1
    dataFromDelegateReceivedArguments = (url: url, delegate: delegate)
    dataFromDelegateReceivedInvocations.append((url: url, delegate: delegate))
    return try dataFromDelegateClosure.map({ try $0(url, delegate) }) ?? dataFromDelegateReturnValue
  }


  var dataForDelegateThrowableError: Error?
  var dataForDelegateCallsCount = 0
  var dataForDelegateReturnValue: (Data, URLResponse)!
  var dataForDelegateReceivedArguments: (request: URLRequest, delegate: URLSessionTaskDelegate?)?
  var dataForDelegateClosure: ((URLRequest, URLSessionTaskDelegate?) throws -> (Data, URLResponse))?

  func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
    if let error = dataForDelegateThrowableError {
      throw error
    }
    dataForDelegateCallsCount += 1
    dataForDelegateReceivedArguments = (request: request, delegate: delegate)
    return try dataForDelegateClosure.map({ try $0(request, delegate) }) ?? dataForDelegateReturnValue
  }

}
