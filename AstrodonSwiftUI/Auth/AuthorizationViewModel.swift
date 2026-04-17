//  Created by Dominik Hauser on 16.04.26.
//  
//


import Foundation

@Observable
class AuthorizationViewModel {
  var apiClient: APIClientProtocol
  var serverHost: String = ""
  var code: String = ""

  init(apiClient: APIClientProtocol = APIClient()) {
    self.apiClient = apiClient
  }
}
