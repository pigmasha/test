//
//  Created by M on 22.01.17.
//

struct RunCase {
    static func runCase() -> Bool {
        switch PathAlg.alg.currentStep {
        case  1: return Step_1_calc_s.runCase()
        case  2: return Step_2_calc_dn.runCase()
        case  3: return Step_3_sigma_deg.runCase()
        case  4: return Step_4_dimhom.runCase()
        case  6: return Step_6_lemma2.runCase()
        case  7: return Step_7_lemma3.runCase()
        case  8: return Step_8_im.runCase()
        case  9: return Step_9_dimhh.runCase()
        case 10: return Step_10_createhh.runCase()
        case 12: return Step_12_shift_enum.runCase()
        case 13: return Step_13_select_shift.runCase()
        case 14: return Step_14_shift_check.runCase()
        case 15: return Step_15_degs_mult.runCase()
        case 16: return Step_16_mult_comm.runCase()
        case 17: return Step_17_mult.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case  1: return "S resolutions"
        case  2: return "Calc Dn"
        case  3: return "Sigma deg"
        case  4: return "Dim Hom"
        case  6: return "Lemma 2"
        case  7: return "Lemma 3"
        case  8: return "Dim Im"
        case  9: return "Dim HH"
        case 10: return "Create HH"
        case 12: return "Shift enum"
        case 13: return "Select shift"
        case 14: return "Shift check"
        case 15: return "Degs mult"
        case 16: return "Mult comm"
        case 17: return "Mults"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
