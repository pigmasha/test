//
//  Created by M on 22.01.17.
//

struct RunCase {
    static func runCase() -> Bool {
        switch PathAlg.alg.currentStep {
        case  0: return Step_0_check_alg.runCase()
        case  1: return Step_1_calc_s.runCase()
        case  2: return Step_2_calc_dn.runCase()
        case  3: return Step_3_sigma_deg.runCase()
        case  4: return Step_4_dimhom.runCase()
        case  5: return Step_5_im.runCase()
        case  6: return Step_6_dimhh.runCase()
        case  7: return Step_7_createhh.runCase()
        case  8: return Step_8_shift_enum.runCase()
        case  9: return Step_9_select_shift.runCase()
        case 10: return Step_10_shift_check.runCase()
        case 11: return Step_11_degs_mult.runCase()
        case 12: return Step_12_degs_mult_check.runCase()
        case 13: return Step_13_mult_comm.runCase()
        case 14: return Step_14_mult.runCase()
        case 15: return Step_15_mult_34.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case  0: return "Alg ways"
        case  1: return "S resolutions"
        case  2: return "D check"
        case  3: return "Sigma deg"
        case  4: return "Dim Hom"
        case  5: return "Dim Im"
        case  6: return "Dim HH"
        case  7: return "HH gen"
        case  8: return "HH Shift"
        case  9: return "Select Shift"
        case 10: return "Check Shift"
        case 11: return "Mult table"
        case 12: return "Mult degs check"
        case 13: return "Comm check"
        case 14: return "Mult"
        case 15: return "Proof 4*3"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
