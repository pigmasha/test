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
            for j in 0 ... 8 {
                let way = Way(from: v, to: v + j)
                if v < 7 {
                    isZeros[v * 10 + j] = way.isZero
                } else {
                    if way.isZero != isZeros[(v % 7) * 10 + j]! { return .zeroCheck }
                }
                if v < 7 || (!way.isZero && j != 0) {
                    OutputFile.writeLog(.normal, "\(v) → \(v + j): \(way.str)")
                }
                if j == 0 && (way.isZero || way.len != 0) { return .badZeroLenWay }
                if j == 8 && !way.isZero { return .longWay }
                if way.isZero || j == 0 { continue }
                if !way.startsWith.isEq(Vertex(i: v)) { return .startsWith }
                if !way.endsWith.isEq(Vertex(i: v + j)) { return .endsWith }
                let koef1 = way.arrays[0].i
                let from: Int
                switch way.arrays[0].type {
                case .gamma: from = 7 * koef1 + 6
                case .alpha: from = 7 * (koef1 / 4) + (koef1 % 4)
                case .beta: from = 7 * (koef1 / 3) + (koef1 % 3) + ((koef1 % 3) == 0 ? 0 : 3)
                }
                if !way.startsWith.isEq(Vertex(i: from)) { return .parseStart }
                let koef2 = way.arrays.last!.i
                let to: Int
                switch way.arrays.last!.type {
                case .alpha: to = 7 * (koef2 / 4) + (koef2 % 4) + ((koef2 % 4) == 3 ? 3 : 1)
                case .beta: to = 7 * (koef2 / 3) + (koef2 % 3) + 4
                case .gamma: to = 7 * (koef2 + 1)
                }
                if !way.endsWith.isEq(Vertex(i: to)) { return .parseEnd }
            }
            OutputFile.writeLog(.normal, "")
        }
        return nil
    }
}
