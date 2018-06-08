//
//  Created by M on 02.04.17.
//

import Foundation

struct Step_8_im {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")
        for deg in 1...12 * PathAlg.twistPeriod + 2 {
            let r = deg % PathAlg.twistPeriod
            let ell = Int(deg / PathAlg.twistPeriod)

            let diff = Diff(deg: deg)
            let im = ImMatrix(diff: diff)
            let k = KoefIntMatrix(im: im)

            //PrintUtils.printMatrixDeg(diff, deg + 1, deg)
            //PrintUtils.printIm(im, deg:deg)
            //printKoefIntMatrix(k, deg, 0);

            let rk1 = k.rank
            let rk2 = Dim.dimIm(deg)

            if rk1 != rk2 {
                OutputFile.writeLog(.error, "Rk \(rk1) and \(rk2) (deg=\(deg), r=\(r), ell=\(ell), char=\(PathAlg.charK))")
            }
        }
        return false
    }
}
