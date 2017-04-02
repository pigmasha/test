//
//  Created by M on 02.04.17.
//
//

import Foundation

struct RunCase_6_lemma2
{
    static func runCase() -> Bool
    {
        let s = PathAlg.alg.s
        OutputFile.writeLog(2, "N=%d, S=%d, Char=%d",  PathAlg.alg.n, PathAlg.alg.s, PathAlg.alg.charK)
        for _ in 0...2 * PathAlg.alg.twistPeriod {
            let matrix = KoefIntMatrix(size: s)!
            createMatrix2(matrix)

            let rk2 = rankLemma2(matrix)
            let rk1 = matrix.rank()

            if rk2 != 0 && rk1 != rk2 {
                OutputFile.writeLog(1, "%d (must be %d)! N=%d, S=%d, char=%d, matrix:",
                                    rk1, rk2, PathAlg.alg.n, s, PathAlg.alg.charK)
                printKoefIntMatrix(matrix, 0, 0)
                return true
            }
        }
        return false
    }

    private static func createMatrix2(_ matrix: KoefIntMatrix)
    {
        let s = PathAlg.alg.s
        for i in 0 ..< s {
            matrix.rows()[i][i].intValue = arc4random_uniform(2) == 0 ? 1 : -1
            matrix.rows()[myModS(i + 1)][i].intValue = arc4random_uniform(2) == 0 ? 1 : -1
        }
    }

    private static func rankLemma2(_ matrix: KoefIntMatrix) -> Int
    {
        let charK = PathAlg.alg.charK
        let n = matrix.rows().count

        if charK == 2 {
            return n - 1
        }

        var k = 1
        for i in 0 ..< n {
            k *= matrix.rows()[i][i].intValue
            k *= matrix.rows()[myMod(i + 1, mod: n)][i].intValue
        }

        return (k == minusDeg(n)) ? n - 1 : n;
    }
}
