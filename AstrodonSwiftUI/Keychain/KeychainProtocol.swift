//  Created by Dominik Hauser on 18.04.26.
//  
//

import Foundation

protocol KeychainProtocol {
  func save(string: String, for: String)
  func get(for: String) -> String
}
