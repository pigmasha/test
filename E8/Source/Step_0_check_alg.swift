//
//  Created by M on 22/06/2019.
//

struct Step_0_check_alg {
    enum StepErr: String {
        case badZeroLenWay, zeroCheck, longWay, startsWith, endsWith, parseStart, parseEnd
    }
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "S=\(PathAlg.s)")
        if let err = run() {
            OutputFile.writeLog(.error, "Code=\(err.rawValue)")
            return true
        }
        return false
    }

    private static func run() -> StepErr? {
        var isZeros: [Int: Bool] = [:]
        for v in 0 ..< PathAlg.vertexMod {
            for j in 0 ... 9 {
                let way = Way(from: v, to: v + j)
                if v < 8 {
                    isZeros[v * 10 + j] = way.isZero
                } else {
                    if way.isZero != isZeros[(v % 8) * 10 + j]! {
                        OutputFile.writeLog(.error, "\(v) → \(v + j): \(way.str)")
                        return .zeroCheck
                    }
                }
                if v < 8 || (!way.isZero && j != 0) {
                    OutputFile.writeLog(.normal, "\(v) → \(v + j): \(way.str)")
                }
                if j == 0 && (way.isZero || way.len != 0) { return .badZeroLenWay }
                if j == 9 && !way.isZero { return .longWay }
                if way.isZero || j == 0 { continue }
                if !way.startsWith.isEq(Vertex(i: v)) { return .startsWith }
                if !way.endsWith.isEq(Vertex(i: v + j)) { return .endsWith }
                let koef1 = way.arrays[0].i
                let from: Int
                switch way.arrays[0].type {
                case .gamma: from = 8 * koef1 + 7
                case .alpha: from = 8 * (koef1 / 5) + (koef1 % 5)
                case .beta: from = 8 * (koef1 / 3) + (koef1 % 3) + ((koef1 % 3) == 0 ? 0 : 4)
                }
                if !way.startsWith.isEq(Vertex(i: from)) { return .parseStart }
                let koef2 = way.arrays.last!.i
                let to: Int
                switch way.arrays.last!.type {
                case .alpha: to = 8 * (koef2 / 5) + (koef2 % 5) + ((koef2 % 5) == 4 ? 3 : 1)
                case .beta: to = 8 * (koef2 / 3) + (koef2 % 3) + 5
                case .gamma: to = 8 * (koef2 + 1)
                }
                if !way.endsWith.isEq(Vertex(i: to)) { return .parseEnd }
            }
            OutputFile.writeLog(.normal, "")
        }
        return nil
    }
}
