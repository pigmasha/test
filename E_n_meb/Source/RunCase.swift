//
//  Created by M on 22.01.17.
//

import Foundation

class RunCase : NSObject {
    static let kStep = 11
    class func runCase() -> Bool {
        switch kStep {
        case 11:
            return RunCase_11_shift_all_save.runCase()
        default:
            return false
        }
    }
}
