//
//  Created by M on 22.01.17.
//

struct RunCase {
    static func runCase() -> Bool {
        if !PathAlg.isTex && PathAlg.alg.currentStep != 9 {
            OutputFile.writeLog(.bold, "k=\(PathAlg.kk), char=\(PathAlg.charK)")
        }
        if PathAlg.isTex && PathAlg.alg.currentStep != 9 {
            OutputFile.writeLog(.normal, "{\\bf k=\(PathAlg.kk)}\n")
        }
        switch PathAlg.alg.currentStep {
        case 0: return Step_0_check_alg.runCase()
        case 1: return Step_1_calc_s.runCase()
        case 2: return Step_2_diff.runCase()
        case 3: return Step_3_im.runCase()
        case 4: return Step_4_dim.runCase()
        case 5: return Step_5_gen.runCase()
        case 6: return Step_6_shift.runCase()
        case 7: return Step_7_mult.runCase()
        case 8: return Step_8_comm.runCase()
        case 9: return Step_9_tex.runCase()
        default: return false
        }
    }

    static var stepTitle: String {
        switch PathAlg.alg.currentStep {
        case 0: return "Alg ways"
        case 1: return "Calc S"
        case 2: return "Diff"
        case 3: return "Dim Im"
        case 4: return "Dim HH"
        case 5: return "Gen"
        case 6: return "Shift"
        case 7: return "Mult"
        case 8: return "Comm"
        case 9: return "Tex"
        default: fatalError("Unknown step \(PathAlg.alg.currentStep)")
        }
    }
}
