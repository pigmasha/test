//
//  Created by M on 02.04.17.
//

import Foundation

struct Step_6_lemma2 {
    static func runCase() -> Bool {
        let s = PathAlg.s
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")
        for _ in 0...2 * PathAlg.twistPeriod {
            let matrix = KoefIntMatrix(size: s)
            createMatrix2(matrix)

            let rk2 = rankLemma2(matrix)
            let rk1 = matrix.rank

            if rk2 != 0 && rk1 != rk2 {
                OutputFile.writeLog(.error, "\(rk1) (must be \(rk2))"
                    + " N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK), matrix:")
                PrintUtils.printKoefIntMatrix(matrix, deg: 0, skipLines: 0)
                return true
            }
        }
        return false
    }

    private static func createMatrix2(_ matrix: KoefIntMatrix) {
        let s = PathAlg.s
        for i in 0 ..< s {
            matrix.rows[i][i].intValue = arc4random_uniform(2) == 0 ? 1 : -1
            matrix.rows[myModS(i + 1)][i].intValue = arc4random_uniform(2) == 0 ? 1 : -1
        }
    }

    private static func rankLemma2(_ matrix: KoefIntMatrix) -> Int {
        let charK = PathAlg.charK
        let n = matrix.rows.count

        if charK == 2 {
            return n - 1
        }

        var k = 1
        for i in 0 ..< n {
            k *= matrix.rows[i][i].intValue
            k *= matrix.rows[myMod(i + 1, mod: n)][i].intValue
        }

        return (k == minusDeg(n)) ? n - 1 : n;
    }
}
