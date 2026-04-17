//  Created by Dominik Hauser on 17.04.26.
//  
//

import Foundation

protocol URLSessionProtocol {
  func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
  func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
