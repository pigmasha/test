//
//  Created by M on 02.04.17.
//

import Foundation

struct Step_9_dimhh {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")
        for deg in 1...30 * PathAlg.twistPeriod + 2 {
            let r = deg % PathAlg.twistPeriod
            let ell = Int(deg / PathAlg.twistPeriod)

            let dimHom1 = Dim.dimHom(deg)
            let dimIm1 = Dim.dimIm(deg)
            let dimIm2 = Dim.dimIm(deg - 1)
            let dimHH1 = Dim.dimHH(deg)

            if dimHH1 != dimHom1 - dimIm1 - dimIm2 || dimHH1 != dimHH2(deg) {
                OutputFile.writeLog(.error, "HH \(dimHH1) and \(dimHom1 - dimIm1 - dimIm2)"
                    + " (deg=\(deg), r=\(r), ell=\(ell), char=\(PathAlg.charK))")
            }
        }
        return false
    }

    private static func dimHH2(_ deg: Int) -> Int {
        let n = PathAlg.n
        let s = PathAlg.s
        let charK = PathAlg.charK

        let ell = deg / PathAlg.twistPeriod
        let r = deg % PathAlg.twistPeriod
        let m = r / 2

        if s == 1 {
            if r == 0 && ell % 2 == 0 && charK == 3 { return 6 }
            if r == 4 && ell % 2 == 1 && charK == 3 { return 6 }

            if r == 0 && ell % 2 == 0 && charK != 3 { return 5 }
            if r == 4 && ell % 2 == 1 && charK != 3 { return 5 }
            if r == 6 && ell % 2 == 1 && charK == 2 { return 5 }

            if r == 6 && ell % 2 == 1 && charK != 2 { return 4 }
            if r == 10 && ell % 2 == 0 { return 4 }

            if r == 6 && ell % 2 == 0 && charK == 3 { return 2 }
            if r == 10 && ell % 2 == 1 && charK == 3 { return 2 }

            if r == 1 || r == 9 { return 1 }
            if r == 2 && ell % 2 == 1 { return 1 }
            if r == 3 && (ell % 2 == 1 || charK == 2) { return 1 }
            if r == 4 && ell % 2 == 0 && charK == 2 { return 1 }
            if r == 5 && charK == 3 { return 1 }
            if r == 6 && ell % 2 == 0 && charK != 3 { return 1 }
            if r == 7 && (ell % 2 == 0 || charK == 2) { return 1 }
            if r == 8 && ell % 2 == 0 { return 1 }
            if r == 10 && ell % 2 == 1 && charK != 3 { return 1 }

            return 0;
        }

        let eq20 = ((ell * (n + s) + m) % (2 * s) == 0)
        let eq21 = ((ell * (n + s) + m) % (2 * s) == 1)

        let eq2s0 = ((ell * (n + s) + m) % (2 * s) == s)
        let eq2s1 = ((ell * (n + s) + m) % (2 * s) == s + 1)

        if (r == 0 || r == 1 || r == 8 || r == 9) && eq20 && (ell % 2 == 0 || charK == 2) { return 1 }
        if r == 0 && eq2s1 && ell % 2 == 0 && charK == 3 { return 1 }
        if (r == 1 || r == 9) && eq2s0 && (ell % 2 == 1 || charK == 2) { return 1 }
        if (r == 2 || r == 10) && eq2s1 && (ell % 2 == 1 || charK == 2) { return 1 }
        if r == 3 && eq20 { return 1 }
        if r == 3 && eq2s0 && charK == 2 { return 1 }
        if (r == 4 || r == 5) && eq2s0 && ell % 2 == 1 && charK == 3 { return 1 }
        if r == 4 && eq21 { return 1 }
        if r == 4 && eq2s1 && charK == 2 { return 1 }
        if r == 5 && eq20 && ell % 2 == 0 && charK == 3 { return 1 }
        if (r == 6 || r == 7) && eq20 && charK == 2 { return 1 }
        if (r == 6 || r == 7) && eq2s0 { return 1 }
        if r == 6 && eq21 && ell % 2 == 0 && charK == 3 { return 1 }
        if r == 10 && eq20 && ell % 2 == 1 && charK == 3 { return 1 }
        
        return 0
    }
}
