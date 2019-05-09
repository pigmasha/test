//
//  Created by M on 22.01.17.
//

struct RunCase {
    static func runCase() -> Bool {
        switch PathAlg.alg.currentStep {
        case  1: return Step_1_calc_s.runCase()
        case  2: return Step_2_calc_dn.runCase()
        case  3: return Step_3_sigma_deg.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case  1: return "S resolutions"
        case  2: return "D check"
        case  3: return "Sigma deg"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
