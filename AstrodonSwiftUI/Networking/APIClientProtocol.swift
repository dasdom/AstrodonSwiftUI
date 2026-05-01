//  Created by Dominik Hauser on 26.04.26.
//  
//

protocol APIClientProtocol {
  func token(code: String) async throws -> String
  func homeTimeline() async throws -> [Toot]
}
