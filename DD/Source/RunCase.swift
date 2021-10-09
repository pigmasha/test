//
//  Created by M on 22.01.17.
//

struct RunCase {
    static func runCase() -> Bool {
        switch PathAlg.alg.currentStep {
        case  0: return Step_0_check_alg.runCase()
        case  1: return Step_1_calc_s.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case  0: return "Alg ways"
        case  1: return "Calc Homos"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
