//  Created by Dominik Hauser on 18.04.26.
//  
//

import Foundation
import Combine

protocol KeychainProtocol {
  var tokenPublisher: CurrentValueSubject<String?, KeychainError> { get }
  func save(token: String?) throws
}
