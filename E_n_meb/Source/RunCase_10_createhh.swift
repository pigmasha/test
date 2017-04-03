//
//  Created by M on 02.04.17.
//
//

import Foundation

struct RunCase_10_createhh
{
    static func runCase() -> Bool
    {
        OutputFile.writeLog(2, "N=%d, S=%d, Char=%d (types %d)",  PathAlg.alg.n, PathAlg.alg.s, PathAlg.alg.charK, 22)
        for type in 1...22 {
            if (process(type: type)) {
                return true
            }
        }
        return false
    }

    private static func process(type: Int) -> Bool
    {
        for deg in 1...30 * PathAlg.alg.twistPeriod + 2 {
            if Dim.deg(deg, hasType: type) {
                let ell = deg / PathAlg.alg.twistPeriod
                let hh = HHElem(deg: deg, type: type)
                OutputFile.writeLog(2, "HH (ell=%d)", ell)
                //printMatrix(hh)
                if (!CheckHH.check(hh, degree: deg)) {
                    return true
                }
            }
        }
        return false
    }
}