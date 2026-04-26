//  Created by Dominik Hauser on 18.04.26.
//  
//

import Foundation

protocol KeychainProtocol {
  func save(string: String, for key: String) throws
  func get(for key: String) -> String?
}
