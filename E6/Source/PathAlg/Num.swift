//
//  Created by M on 17.04.16.
//

import Foundation

final class NumInt: CustomStringConvertible {
    var intValue: Int

    init(intValue: Int) {
        self.intValue = intValue
    }

    func isEq(_ object: Any?) -> Bool {
        if let object = object as? NumInt {
            return intValue == object.intValue
        } else {
            return false
        }
    }

    var description: String {
        return "<\(type(of: self)): \(intValue)>"
    }
}
