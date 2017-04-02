//
//  Created by M on 22.01.17.
//

import Foundation

class RunCase : NSObject {
    static let kStep = 11
    class func runCase() -> Bool {
        switch kStep {
        case 6:
            return RunCase_6_lemma2.runCase()
        case 7:
            return RunCase_7_lemma3.runCase()
        case 8:
            return RunCase_8_im.runCase()
        case 9:
            return RunCase_9_dimhh.runCase()
        case 10:
            return RunCase_10_createhh.runCase()
        case 11:
            return RunCase_11_shift_all_save.runCase()
        default:
            return false
        }
    }
}
