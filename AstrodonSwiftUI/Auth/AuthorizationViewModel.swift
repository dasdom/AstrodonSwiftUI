//  Created by Dominik Hauser on 16.04.26.
//  
//


import Foundation

@Observable
class AuthorizationViewModel {
  var apiClient: APIClientProtocol
  var serverHost: String = ""
  var code: String = ""
  var fetchTask: Task<Void, Error>?

  init(apiClient: APIClientProtocol = APIClient()) {
    self.apiClient = apiClient
  }

  func fetchToken() throws {
    fetchTask = Task {
      _ = try await apiClient.token(code: code)
    }
  }
}
