//
//  Created by M on 02.09.2018.
//

import Foundation

final class ShiftHHElem23: ShiftHHElem {
    init() {
        super.init(type:23)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1, noZeroLenL: true)
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = 6 * s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1, noZeroLenL: true)
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 5 * s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1, noZeroLenL: true)
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 4 * s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1, noZeroLenL: true)

        j = 5*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1, noZeroLenL: true)
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1, noZeroLenL: true)
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 2 * s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+1, koef:1, noZeroLenL: true)

        j = 3*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+1, koef:1, noZeroLenL: true)
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1, noZeroLenL: true)

        j = 8 * s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1, noZeroLenL: true)
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 4 * s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1, noZeroLenL: true)

        j = 5*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+2, koef:1, noZeroLenL: true)
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 5 * s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*j+3, koef:1, noZeroLenL: true)
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        var j = s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*(j+s)+1, koef:1, noZeroLenL: true)

        j = 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m+1), leftTo:4*(j+m+2), right:4*(j+s)+1, koef:1, noZeroLenL: true)
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*(j+m), leftTo:4*(j+m+1), right:4*j, koef:1, noZeroLenL: true)
    }
}
