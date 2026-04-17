//  Created by Dominik Hauser on 13.04.26.
//  
//


import Foundation

struct TokenResponse: Decodable {
  let access_token: String
  let token_type: String
  let scope: String
  let created_at: Int
}
