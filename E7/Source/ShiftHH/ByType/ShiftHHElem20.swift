//
//  Created by M on 26/08/2019.
//

import Foundation

final class ShiftHHElem20 : ShiftHHElem {
    override func shift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = 4*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+4, rightTo:7*j+4, koef:1, noZeroLenL:true)
    }

    override func shift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j, rightTo:7*j, koef:1, noZeroLenL:true)
    }

    override func shift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = 3*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+3, rightTo:7*j+3, koef:1, noZeroLenL:true)
    }

    override func shift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        let j = 8*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*j+6, koef:1, noZeroLenL:true)
    }

    override func shift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+2, rightTo:7*j+2, koef:1, noZeroLenL:true)
        j += 5*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+5, rightTo:7*j+5, koef:1, noZeroLenL:true)
    }

    override func shift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j, rightTo:7*j, koef:1, noZeroLenL:true)
    }

    override func shift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:12*s)

        var j = 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+1, rightTo:7*j+1, koef:1, noZeroLenL:true)
        j += 5*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+4, rightTo:7*j+4, koef:1, noZeroLenL:true)
    }

    override func shift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:12*s)

        var j = 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j, rightTo:7*j, koef:1, noZeroLenL:true)
        j += 7*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*j+6, koef:1, noZeroLenL:true)
    }

    override func shift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:13*s)

        var j = 6*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+3, rightTo:7*j+3, koef:1, noZeroLenL:true)
        j += 3*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+5, rightTo:7*j+5, koef:1, noZeroLenL:true)
    }

    override func shift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:12*s)

        let j = 11*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*j+6, koef:1, noZeroLenL:true)
    }

    override func shift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:12*s)

        var j = 4*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+2, rightTo:7*j+2, koef:1, noZeroLenL:true)
        j += 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+4, rightTo:7*j+4, koef:1, noZeroLenL:true)
    }

    override func shift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j, rightTo:7*j, koef:1, noZeroLenL:true)
    }

    override func shift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        let j = 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+1, rightTo:7*j+1, koef:1, noZeroLenL:true)
    }

    override func shift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        let j = 8*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*j+6, koef:1, noZeroLenL:true)
    }

    override func shift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = 5*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+5, rightTo:7*j+5, koef:1, noZeroLenL:true)
    }

    override func shift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        let j = 5*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+5, rightTo:7*j+5, koef:1, noZeroLenL:true)
    }

    override func shift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:7*s)

        let j = 4*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+4, rightTo:7*j+4, koef:1, noZeroLenL:true)
    }

    override func koef17(ell: Int) -> Int {
        return minusDeg(ell)
    }
}
