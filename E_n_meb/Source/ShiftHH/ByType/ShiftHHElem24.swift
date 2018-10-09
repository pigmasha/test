//
//  Created by M on 02.09.2018.
//

final class ShiftHHElem24: ShiftHHElem {
    init() {
        super.init(type:24)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 5
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*j+3, leftTo:4*(j+1)+3, right:4*j+3, koef:1, noZeroLenL: true)
    }

    override func shift1(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        var j = 4*s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j+2, rightTo:4*j+2, koef:1, noZeroLenL: true)
        j = 5*s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j+2, rightTo:4*j+2, koef:1, noZeroLenL: true)
    }

    override func shift2(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenL: true)
    }

    override func shift3(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 2*s
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                           rightFrom:4*j+1, rightTo:4*j, koef:1)
        j = 3*s
        HHElem.addElemToHH(hhElem, i:j-2*s, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m)+3,
                           rightFrom:4*j+1, rightTo:4*j, koef:-1)
    }

    override func shift4(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenR: true)
        j = s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m),
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenR: true)
    }

    override func shift5(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m)+1,
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenR: true)
        j = s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+1, leftTo:4*(j+m)+1,
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenR: true)
    }

    override func shift6(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m),
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenR: true)
    }

    override func shift7(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenR: true)
        j = s
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+2, leftTo:4*(j+m)+2,
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenR: true)
    }

    override func shift8(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*j, koef:1, noZeroLenR: true)
    }

    override func shift9(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j+s, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*j+1, koef:-1)
        HHElem.addElemToHH(hhElem, i:j+2*s, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                           rightFrom:4*j, rightTo:4*(j+1)+1, koef:1)
    }

    override func shift10(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(6*s, h:6*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m),
                           rightFrom:4*j, rightTo:4*j, koef:-1, noZeroLenL: true)
        j = 5*s
        HHElem.addElemToHH(hhElem, i:j-5*s, j:j,
                           leftFrom:4*(j+m), leftTo:4*(j+m)+3,
                           rightFrom:4*j+3, rightTo:4*j, koef:1)
        HHElem.addElemToHH(hhElem, i:j, j:j,
                           leftFrom:4*(j+m)+3, leftTo:4*(j+m)+3,
                           rightFrom:4*j+3, rightTo:4*j+3, koef:1, noZeroLenL: true)
    }
}
