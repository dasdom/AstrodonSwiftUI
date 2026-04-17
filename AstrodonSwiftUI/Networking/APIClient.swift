//  Created by Dominik Hauser on 12.04.26.
//  
//


import Foundation

class APIClient {
  lazy var session: URLSessionProtocol = URLSession.shared

  func token(code: String) async throws -> String {
    let request = try Endpoint.token(code: code).request()
    let (data, _) = try await session.data(for: request, delegate: nil)
    let tokenJSON = try JSONDecoder().decode(TokenResponse.self, from: data)
    return tokenJSON.access_token
  }
}
