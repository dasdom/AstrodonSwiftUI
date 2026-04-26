//  Created by Dominik Hauser on 18.04.26.
//  
//

import Foundation

protocol KeychainProtocol {
  func save(token: String?) throws
  func token() -> String?
}
