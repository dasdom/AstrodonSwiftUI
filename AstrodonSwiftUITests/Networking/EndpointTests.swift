//  Created by Dominik Hauser on 13.04.26.
//  
//


import Testing
import Foundation
@testable import AstrodonSwiftUI

struct EndpointTests {

  @MainActor
  @Test func authorize() async throws {
    Endpoint.host = "blabla"

    let url = try #require(Endpoint.authCode.url)
    let urlComponents = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    #expect(urlComponents.host == "blabla")
    let queryItems = try #require(urlComponents.queryItems, "urlComponents: \(urlComponents)")
    #expect(queryItems == [
      URLQueryItem(name: "client_id", value: ClientKey.client_id.rawValue),
      URLQueryItem(name: "scope", value: "read+write+follow+push"),
      URLQueryItem(name: "redirect_uri", value: ClientKey.redirect_uri.rawValue),
      URLQueryItem(name: "response_type", value: "code"),
    ])
  }

}
