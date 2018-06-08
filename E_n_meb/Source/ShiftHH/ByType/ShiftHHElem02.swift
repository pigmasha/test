//
//  Created by M on 10.04.16.
//
//

import Foundation

final class ShiftHHElem02 : ShiftHHElem {
    init() {
        super.init(type:2)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = myModS(-n*ell_0)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1)
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = 6 * s + myModS(-n*ell_0 - m - 1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1)
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 5 * s + myModS(-n*ell_0 - m - 1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1)
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 4 * s + myModS(-n*ell_0 - m - 1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1)

        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1)
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        let j = s + myModS(-n*ell_0 - m)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1)
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 2 * s + myModS(-n*ell_0 - m - 1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+1, koef:1)

        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+1, koef:1)
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        var j = myModS(-n*ell_0 - m)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1)

        j = 8 * s + myModS(-n*ell_0 - m - 1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1)
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 4 * s + myModS(-n*ell_0 - m - 1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1)

        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1)
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 5 * s + myModS(-n*ell_0 - m - 1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1)
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        var j = s + myModS(-n*ell_0 - m - 1)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*(j+s)+1, koef:1)

        j += s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*(j+s)+1, koef:1)
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = myModS(-n*ell_0 - m)
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1)
    }

    override func koef11(s: Int, ell: Int) -> Int {
        return PathAlg.sigmaDeg(ell, i: -6*ell, isGamma: true)
    }
}
