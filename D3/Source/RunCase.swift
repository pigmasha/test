//
//  Created by M on 22.01.17.
//

struct RunCase {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "n1=\(PathAlg.n1), n2=\(PathAlg.n2), n3=\(PathAlg.n3), char=\(PathAlg.charK)")
        switch PathAlg.alg.currentStep {
        case  0: return Step_0_check_alg.runCase()
        case  1: return Step_1_diff.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case  0: return "Alg ways"
        case  1: return "Diff"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
