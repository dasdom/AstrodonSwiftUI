//  Created by Dominik Hauser on 12.04.26.
//  
//


import Testing
import Foundation
@testable import AstrodonSwiftUI

struct APIClientTests {

  let sut = APIClient()

  @MainActor
  @Test func token() async throws {
    let urlSession = URLSessionProtocolMock()
    let token = "ZA-Yj3aBD8U8Cm7lKUp-lm9O9BmDgdhHzDeqsY8tlL0"
    let jsonResponse = """
      {
      "access_token": "\(token)",
      "token_type": "Bearer",
      "scope": "read write follow push",
      "created_at": 1573979017
      }
      """
    urlSession.okDataReturnValue = jsonResponse.data(using: .utf8)
    Endpoint.host = "foobar"
    sut.session = urlSession

    let code = "1234"
    let fetchedToken = try await sut.token(code: code)

    let url = try #require(urlSession.dataForDelegateReceivedArguments?.request.url)
    let urlComponents = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    #expect(urlComponents.host == "foobar")
    let queryItems = try #require(urlComponents.queryItems, "urlComponents: \(urlComponents)")
    #expect(queryItems == [
      URLQueryItem(name: "client_id", value: ClientKey.client_id.rawValue),
      URLQueryItem(name: "client_secret", value: ClientKey.client_secret.rawValue),
      URLQueryItem(name: "redirect_uri", value: ClientKey.redirect_uri.rawValue),
      URLQueryItem(name: "code", value: code),
      URLQueryItem(name: "scope", value: "read+write+follow+push"),
    ])
    #expect(fetchedToken == token)
  }

}
