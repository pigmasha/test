//
//  Created by M on 29/05/2019.
//

import Foundation

struct Step_5_im {
    static func runCase() -> Bool {
        OutputFile.writeLog(.time, "S=\(PathAlg.s), Char=\(PathAlg.charK)")
        // s = 2 .. 25
        for deg in 1...12 * PathAlg.twistPeriod + 2 {
            let r = deg % PathAlg.twistPeriod
            let ell = Int(deg / PathAlg.twistPeriod)
            let diff = Diff(deg: deg)
            //guard r == 0 && (r / 2 + 9 * ell) % PathAlg.s == 0 else { continue }
            let im = ImMatrix(diff: diff)
            let k = KoefIntMatrix(im: im)
            OutputFile.writeLog(.normal, "r=\(r), ell=\(ell)")
            //PrintUtils.printMatrix("d", Diff(deg: r))
            //PrintUtils.printKoefIntMatrix(k, deg: deg, skipLines: 0)

            let rk1 = k.rank
            let rk2 = Dim.dimIm(deg)

            if rk1 != rk2 {
                OutputFile.writeLog(.error, "Rk \(rk1) and \(rk2) (deg=\(deg), r=\(r), ell=\(ell), char=\(PathAlg.charK))")
                return true
            }
        }
        return false
    }
}
