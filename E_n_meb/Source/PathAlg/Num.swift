//
//  Created by M on 17.04.16.
//
//

import Foundation

final class NumInt: NSObject {
    var intValue: Int

    init(intValue: Int) {
        self.intValue = intValue
        super.init()
    }

    class func numWithInt(_ intValue: Int) -> NumInt {
        return NumInt(intValue: intValue)
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? NumInt {
            return intValue == object.intValue
        } else {
            return false
        }
    }

    override var hash: Int {
        return intValue
    }

    override var description: String {
        return "<\(type(of: self)): \(intValue)>"
    }
}

final class NumFloat: NSObject {
    var floatValue: Double

    init(floatValue: Double) {
        self.floatValue = floatValue
        super.init()
    }

    class func numWithFloat(_ floatValue: Double) -> NumFloat {
        return NumFloat(floatValue: floatValue)
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? NumFloat {
            return floatValue == object.floatValue
        } else {
            return false
        }
    }

    override var hash: Int {
        return Int(floatValue)
    }

    override var description: String {
        return "<\(type(of: self)): \(floatValue)>"
    }
}
