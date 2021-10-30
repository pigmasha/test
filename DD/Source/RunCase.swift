//
//  Created by M on 22.01.17.
//

struct RunCase {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "k=\(PathAlg.k), c=\(PathAlg.c), d=\(PathAlg.d), char=\(PathAlg.charK)")
        switch PathAlg.alg.currentStep {
        case  0: return Step_0_check_alg.runCase()
        case  1: return Step_1_calc_s.runCase()
        case  2: return Step_2_diff.runCase()
        case  3: return Step_3_im.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case  0: return "Alg ways"
        case  1: return "Calc Homos"
        case  2: return "Diff"
        case  3: return "Im"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
