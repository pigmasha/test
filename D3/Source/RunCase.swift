//
//  Created by M on 22.01.17.
//

struct RunCase {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "n1=\(PathAlg.n1), n2=\(PathAlg.n2), n3=\(PathAlg.n3), char=\(PathAlg.charK)")
        switch PathAlg.alg.currentStep {
        case 0: return Step_0_check_alg.runCase()
        case 1: return Step_1_diff.runCase()
        case 2: return Step_2_im.runCase()
        case 3: return Step_3_rk.runCase()
        case 4: return Step_4_gen.runCase()
        case 5: return Step_5_shift.runCase()
        case 6: return Step_6_comm.runCase()
        case 7: return Step_7_mult.runCase()
        case 8: return Step_8_tex.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case 0: return "Alg ways"
        case 1: return "Diff"
        case 2: return "Im"
        case 3: return "Rk"
        case 4: return "Gen"
        case 5: return "Shift"
        case 6: return "Commitative"
        case 7: return "Mult"
        case 8: return "Tex"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
