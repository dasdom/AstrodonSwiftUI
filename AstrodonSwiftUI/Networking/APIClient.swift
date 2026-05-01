//  Created by Dominik Hauser on 12.04.26.
//  
//


import Foundation

class APIClient: APIClientProtocol {
  lazy var session: URLSessionProtocol = URLSession.shared
  let keychain: KeychainProtocol
  private var token: String? {
    return keychain.token()
  }

  init(keychain: KeychainProtocol = Keychain()) {
    self.keychain = keychain
  }

  func token(code: String) async throws -> String {
    let request = try Endpoint.token(code: code).request()
    let (data, _) = try await session.data(for: request, delegate: nil)
    let tokenJSON = try JSONDecoder().decode(TokenResponse.self, from: data)
    return tokenJSON.access_token
  }

  func homeTimeline() async throws -> [Toot] {
    guard let token else {
      assertionFailure()
      return []
    }
    let request = try Endpoint.home.request(token: token)
    let (data, _) = try await session.data(for: request, delegate: nil)
    let toots = try JSONDecoder().decode([Toot].self, from: data)
    return toots
  }
}
