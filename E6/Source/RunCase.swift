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
        case  5: return Step_5_im.runCase()
        case  6: return Step_6_dimhh.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case  1: return "S resolutions"
        case  2: return "D check"
        case  3: return "Sigma deg"
        case  4: return "Dim Hom"
        case  5: return "Dim Im"
        case  6: return "Dim HH"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
