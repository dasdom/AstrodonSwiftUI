//  Created by Dominik Hauser on 25.04.26.
//  
//


import Foundation

@Observable
class TimelineViewModel {
  let keychain: KeychainProtocol
  let apiClient: APIClientProtocol
  var isPresentingAuth: Bool = false

  init(keychain: KeychainProtocol = Keychain(), apiClient: APIClientProtocol = APIClient()) {
    self.keychain = keychain
    isPresentingAuth = keychain.token() == nil

    self.apiClient = apiClient
  }
}
