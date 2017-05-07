//
//  Created by M on 02.04.17.
//
//

import Foundation

struct Step_7_lemma3
{
    static func runCase() -> Bool
    {
        let s = PathAlg.s
        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)
        for _ in 0...2 * PathAlg.twistPeriod {
            let matrix = KoefIntMatrix(size: s)!
            createMatrix3(matrix)

            let rk2 = rankLemma3(matrix)
            let rk1 = matrix.rank()
            
            if rk2 != 0 && rk1 != rk2 {
                OutputFile.writeLog(.error, "%d (must be %d)! N=%d, S=%d, char=%d, matrix:",
                                    rk1, rk2, PathAlg.n, s, PathAlg.charK)
                printKoefIntMatrix(matrix, 0, 0)
                return true
            }
        }
        return false
    }

    private static func createMatrix3(_ matrix: KoefIntMatrix)
    {
        let s = PathAlg.s
        for i in 0 ..< s {
            matrix.rows()[i][i].intValue = arc4random_uniform(2) == 0 ? 1 : -1
            matrix.rows()[myModS(i + 1)][i].intValue = arc4random_uniform(2) == 0 ? 1 : -1
        }
        for i in 0 ..< s - 1 {
            let n = matrix.rows()[myModS(i + 2)][i]
            let n1 = matrix.rows()[myModS(i + 1)][i]
            let n2 = matrix.rows()[i + 1][i + 1]
            let n3 = matrix.rows()[myModS(i + 2)][i + 1]
            n.intValue = n.intValue + n1.intValue * n2.intValue * n3.intValue
        }
        for i in s-1 ..< s {
            let n = matrix.rows()[myModS(i + 2)][i]
            n.intValue = n.intValue + (arc4random_uniform(2) == 0 ? 1 : -1)
        }
    }

    private static func rankLemma3(_ matrix: KoefIntMatrix) -> Int
    {
        let charK = PathAlg.charK
        let n = matrix.rows().count

        if charK == 2 {
            return (n % 3 == 0) ? n - 2 : n
        }

        var k = 1
        for i in 0 ..< n {
            k *= matrix.rows()[i][i].intValue
            k *= matrix.rows()[myMod(i + 1, mod: n)][i].intValue
        }

        var g = matrix.rows()[myMod(n + 1, mod: n)][n - 1].intValue
        g *= matrix.rows()[0][0].intValue
        g *= matrix.rows()[1][0].intValue
        g *= matrix.rows()[0][n - 1].intValue

        if charK > 0 {
            k = myMod(k, mod: charK);
            if (k > 1) { k -= charK }
            g = myMod(g, mod: charK);
            if (g > 1) { g -= charK }
        }

        if n % 3 == 0 {
            if k == 1 {
                return g == 1 ? n - 2 : n - 1
            }
            return g == -1 ? n - 1 : n
        }

        return (charK == 3 && k == 1 && g == 1) ? n - 1 : n
    }
}
