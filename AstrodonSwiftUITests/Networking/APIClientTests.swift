//  Created by Dominik Hauser on 12.04.26.
//  
//


import Testing
import Foundation
import Combine
@testable import AstrodonSwiftUI

struct APIClientTests {

  let keychainMock: KeychainProtocolMock
  let sut: APIClient

  init() {
    keychainMock = KeychainProtocolMock()
    sut = APIClient(keychain: keychainMock)
  }

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

  @MainActor
  @Test func toots() async throws {
    let urlSession = URLSessionProtocolMock()
    urlSession.okDataReturnValue = tootResponse(username: "Testuser").data(using: .utf8)
    keychainMock.tokenPublisher.send("1234")
    Endpoint.host = "foobar"
    sut.session = urlSession

    let toots = try await sut.homeTimeline()

    let request = try #require(urlSession.dataForDelegateReceivedArguments?.request)
    let url = try #require(request.url)
    let urlComponents = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    #expect(urlComponents.host == "foobar")
    #expect(request.allHTTPHeaderFields == ["Authorization": "Bearer 1234"])
    #expect(toots.count == 2)
    #expect(toots.first?.account.username == "Testuser")
  }
}

extension APIClientTests {
  func tootResponse(username: String) -> String {
    return """
      [
      {
      "id": "1",
      "account": {
      "id": "1",
      "username": "\(username)",
      "acct": "Gargron",
      "display_name": "Eugen",
      },
      "media_attachments": [],
      "mentions": [],
      "tags": [],
      "emojis": [],
      "card": null,
      "poll": null
      },
      {
      "id": "2",
      "account": {
      "id": "2",
      "username": "Two",
      "acct": "Gargron",
      "display_name": "Eugen",
      },
      "media_attachments": [],
      "mentions": [],
      "tags": [],
      "emojis": [],
      "card": null,
      "poll": null
      }
      ]
      """
  }
}
