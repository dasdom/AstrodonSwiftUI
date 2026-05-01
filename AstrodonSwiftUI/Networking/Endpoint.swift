//  Created by Dominik Hauser on 13.04.26.
//  
//


import Foundation

enum EndpointError: Error {
  case requestCreation
}

enum Endpoint {
  static var host: String? = UserDefaults.standard.string(forKey: "host")

  case authCode
  case token(code: String)
  case home
}

extension Endpoint {
  func request(token: String? = nil) throws -> URLRequest {
    guard let url else {
      throw EndpointError.requestCreation
    }
    var request = URLRequest(url: url)
    switch self {
      case .token(_):
        request.httpMethod = "POST"
      default:
        request.httpMethod = "GET"
    }
    if let token {
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    return request
  }

  private var path: String {
    switch self {
      case .token:
        "/oauth/token"
      case .authCode:
        "/oauth/authorize"
      case .home:
        "/api/v1/timelines/home"
    }
  }

  var url: URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = Self.host
    urlComponents.path = path
    switch self {
      case .token(let code):
        urlComponents.queryItems = [
          URLQueryItem(name: "client_id", value: ClientKey.client_id.rawValue),
          URLQueryItem(name: "client_secret", value: ClientKey.client_secret.rawValue),
          URLQueryItem(name: "redirect_uri", value: ClientKey.redirect_uri.rawValue),
          URLQueryItem(name: "code", value: code),
          URLQueryItem(name: "scope", value: "read+write+follow+push"),
        ]
      case .authCode:
        urlComponents.queryItems = [
          URLQueryItem(name: "client_id", value: ClientKey.client_id.rawValue),
          URLQueryItem(name: "scope", value: "read+write+follow+push"),
          URLQueryItem(name: "redirect_uri", value: ClientKey.redirect_uri.rawValue),
          URLQueryItem(name: "response_type", value: "code"),
        ]
      default:
        break
    }
    return urlComponents.url
  }
}
