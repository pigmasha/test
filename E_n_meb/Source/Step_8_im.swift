//
//  Created by M on 02.04.17.
//
//

import Foundation

struct Step_8_im
{
    static func runCase() -> Bool
    {
        OutputFile.writeLog(2, "N=%d, S=%d, Char=%d",  PathAlg.n, PathAlg.s, PathAlg.charK)
        for deg in 1...12 * PathAlg.twistPeriod + 2 {
            let r = deg % PathAlg.twistPeriod
            let ell = Int(deg / PathAlg.twistPeriod)

            let diff = Diff(deg: deg)
            let im = ImMatrix(diff: diff)
            let k = KoefIntMatrix(im: im)!

            //printMatrixDeg(diff, deg + 1, deg);
            //printImDeg(im, deg);
            //printKoefIntMatrix(k, deg, 0);

            let rk1 = k.rank()
            let rk2 = Dim.dimIm(deg)

            if rk1 != rk2 {
                OutputFile.writeLog(1, "Rk %d and %d (deg=%d, r=%d, ell=%d, char=%d)",
                                    rk1, rk2, deg, r, ell, PathAlg.charK)
            }
        }
        return false
    }
}
