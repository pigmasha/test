//
//  Created by M on 22.01.17.
//

struct RunCase {
    static func runCase() -> Bool {
        if !PathAlg.isTex && PathAlg.alg.currentStep != 9 {
            OutputFile.writeLog(.bold, "n=\(PathAlg.n), char=\(PathAlg.charK)")
        }
        if PathAlg.isTex && PathAlg.alg.currentStep != 9 {
            OutputFile.writeLog(.normal, "{\\bf n=\(PathAlg.n)}\n")
        }
        switch PathAlg.alg.currentStep {
        case 0: return Step_0_check_alg.runCase()
        case 1: return Step_1_calc_s.runCase()
        case 2: return Step_2_bimodq.runCase()
        case 3: return Step_3_calc_dn.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case 0: return "Alg ways"
        case 1: return "Calc S"
        case 2: return "BimodQ"
        case 3: return "Diff"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
