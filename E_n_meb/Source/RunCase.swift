//
//  Created by M on 22.01.17.
//

import Foundation

class RunCase : NSObject {
    static let kStep = 13
    class func runCase() -> Bool {
        switch kStep {
        case 6:
            return Step_6_lemma2.runCase()
        case 7:
            return Step_7_lemma3.runCase()
        case 8:
            return Step_8_im.runCase()
        case 9:
            return Step_9_dimhh.runCase()
        case 10:
            return Step_10_createhh.runCase()
        case 11:
            return Step_11_shift_all_save.runCase()
        case 12:
            return Step_12_shift_enum.runCase()
        case 13:
            return Step_13_select_shift.runCase()
        default:
            return false
        }
    }
}
