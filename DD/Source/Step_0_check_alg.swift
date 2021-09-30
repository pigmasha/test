//
//  Created by M on 30/09/2021.
//

struct Step_0_check_alg {
    enum StepErr: String {
        case badZeroLenWay, zeroCheck, longWay, startsWith, endsWith, parseStart, parseEnd
    }
    static func runCase() -> Bool {
        var ways: [Way] = []
        for l in 0 ... 3 * PathAlg.k {
            let way1 = Way(type: .x, len: l)
            let way2 = Way(type: .y, len: l)
            if !way1.isZero && !ways.contains(where: { way1.isEq($0) }) { ways.append(way1) }
            if !way2.isZero && !ways.contains(where: { way2.isEq($0) }) { ways.append(way2) }
            OutputFile.writeLog(.normal, "w1=" + way1.str + ", w2=" + way2.str)
        }
        OutputFile.writeLog(.normal, "ways=" + ways.map { $0.str }.joined(separator: ", "))
        return false
    }
}
