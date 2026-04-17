//  Created by Dominik Hauser on 12.04.26.
//  
//



import Foundation

extension HTTPURLResponse {
  static let okResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                          statusCode: 200,
                                          httpVersion: "HTTP/1.1",
                                          headerFields: nil)!
}
