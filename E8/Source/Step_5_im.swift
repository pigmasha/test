//
//  E8
//  Created by M on 13/03/2020.
//

import Foundation

struct Step_5_im {
    static func runCase() -> Bool {
        OutputFile.writeLog(.time, "S=\(PathAlg.s), Char=\(PathAlg.charK)")
        var hasErrors = false
        for deg in 1...12 * PathAlg.twistPeriod + 2 {
            let r = deg % PathAlg.twistPeriod
            let ell = Int(deg / PathAlg.twistPeriod)
            let diff = Diff(deg: deg)
            //guard r == 9 && rk2 != 0 && (ell + r / 2) % 2 == 0 else { continue }
            let im = ImMatrix(diff: diff)
            let k = KoefIntMatrix(im: im)
            //OutputFile.writeLog(.normal, "r=\(r), ell=\(ell), rk=\(rk2)")
            //PrintUtils.printMatrix("d", Diff(deg: r))
            //PrintUtils.printKoefIntMatrix(k, deg: deg, skipLines: 0)

            let rk1 = k.rank
            let rk2 = Dim.dimIm(deg)
            
            if rk1 != rk2 {
                OutputFile.writeLog(.error, "Bad \(rk2) (must be \(rk1)) (r=\(r), ell=\(ell), char=\(PathAlg.charK))")
                hasErrors = true
            }
        }
        return hasErrors
    }
}

