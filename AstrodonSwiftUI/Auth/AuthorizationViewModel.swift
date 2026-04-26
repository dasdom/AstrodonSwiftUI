//  Created by Dominik Hauser on 16.04.26.
//  
//


import Foundation

@Observable
class AuthorizationViewModel {
  let apiClient: APIClientProtocol
  let keychain: KeychainProtocol
  var serverHost = ""
  var code = ""
  var fetchTask: Task<Void, Error>?

  init(apiClient: APIClientProtocol = APIClient(), keychain: KeychainProtocol = Keychain()) {
    self.apiClient = apiClient
    self.keychain = keychain
  }

  func fetchToken() throws {
    fetchTask = Task {
      let token = try await apiClient.token(code: code)
      try keychain.save(string: token, for: "token")
    }
  }
}
