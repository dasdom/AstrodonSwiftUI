//  Created by Dominik Hauser on 25.04.26.
//  
//


import Foundation

@Observable
class TimelineViewModel {
  let keychain: KeychainProtocol
  var isPresentingAuth: Bool = false

  init(keychain: KeychainProtocol = Keychain()) {
    self.keychain = keychain
    isPresentingAuth = keychain.get(for: "token") == nil
  }
}
