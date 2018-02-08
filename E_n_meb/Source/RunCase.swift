//
//  Created by M on 22.01.17.
//

struct RunCase {
    static let kStep = 13
    static let kCurrentType = 5
    
    static func runCase() -> Bool {
        switch kStep {
        case 1:
            return Step_1_calc_dn.runCase()
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
            return Step_11_shift_alg.runCase()
        case 12:
            return Step_12_shift_enum.runCase()
        case 13:
            return Step_13_select_shift.runCase()
        case 14:
            return Step_14_shift_check.runCase()
        default:
            return false
        }
    }
}
