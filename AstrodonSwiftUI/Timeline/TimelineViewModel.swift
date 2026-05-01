//  Created by Dominik Hauser on 25.04.26.
//  
//


import Foundation
import Combine

@Observable
class TimelineViewModel {
  let keychain: KeychainProtocol
  let apiClient: APIClientProtocol
  var isPresentingAuth: Bool = true
  var tokenPublisherToken: AnyCancellable?

  init(keychain: KeychainProtocol = Keychain(), apiClient: APIClientProtocol = APIClient()) {
    self.keychain = keychain
    self.apiClient = apiClient

    tokenPublisherToken = keychain.tokenPublisher.sink { _ in } receiveValue: { [weak self] token in
      self?.isPresentingAuth = (token == nil)
    }

  }
}
