//
//  Created by M on 04/04/2020.
//

import Foundation

//#if SHIFTS
final class ShiftHHElem32 : ShiftHHElem {
    override func shift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        let j = 3*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*j+3, koef:1, noZeroLenL:true)
    }

    override func shift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        let j = 3*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*j+2, koef:1, noZeroLenL:true)
    }

    override func shift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        let j = 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*j+2, koef:1, noZeroLenL:true)
    }

    override func shift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        let j = 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*j+1, koef:1, noZeroLenL:true)
    }

    override func shift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:11*s)

        let j = 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*j+1, koef:1, noZeroLenL:true)
    }

    override func shift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:11*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*j, koef:1, noZeroLenL:true)
    }

    override func shift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:13*s)

        let j = 9*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+6, rightTo:8*j+6, koef:1, noZeroLenL:true)
    }

    override func shift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(14*s, h:14*s)

        let j = 12*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*j+7, koef:1, noZeroLenL:true)
    }

    override func shift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:16*s)

        var j = 7*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*j+4, koef:1, noZeroLenL:true)
        j = 9*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+5, rightTo:8*j+5, koef:1, noZeroLenL:true)
    }

    override func shift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:16*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*j, koef:1, noZeroLenL:true)
    }

    override func shift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:19*s)

        let j = 6*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*j+3, koef:1, noZeroLenL:true)
    }

    override func shift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:18*s)

        let j = 15*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*j+7, koef:1, noZeroLenL:true)
    }

    override func shift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:19*s)

        var j = 4*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*j+2, koef:1, noZeroLenL:true)
        j = 14*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+6, rightTo:8*j+6, koef:1, noZeroLenL:true)
    }

    override func shift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:18*s)

        let j = s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*j, koef:1, noZeroLenL:true)
    }

    override func shift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(20*s, h:20*s)

        var j = 3*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*j+1, koef:1, noZeroLenL:true)
        j = 12*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+5, rightTo:8*j+5, koef:1, noZeroLenL:true)
    }

    override func shift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:18*s)

        var j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*j, koef:1, noZeroLenL:true)
        j = 15*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*j+7, koef:1, noZeroLenL:true)
    }

    override func shift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:19*s)

        var j = 9*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*j+4, koef:1, noZeroLenL:true)
        j = 13*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+6, rightTo:8*j+6, koef:1, noZeroLenL:true)
    }

    override func shift17(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:18*s)

        let j = 13*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*j+7, koef:1, noZeroLenL:true)
    }

    override func shift18(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:19*s)

        var j = 7*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*j+3, koef:1, noZeroLenL:true)
        j = 10*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+5, rightTo:8*j+5, koef:1, noZeroLenL:true)
    }

    override func shift19(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:16*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*j, koef:1, noZeroLenL:true)
    }

    override func shift20(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:16*s)

        let j = 4*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*j+2, koef:1, noZeroLenL:true)
    }

    override func shift21(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(14*s, h:14*s)

        let j = 10*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*j+7, koef:1, noZeroLenL:true)
    }

    override func shift22(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:13*s)

        var j = 2*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*j+1, koef:1, noZeroLenL:true)
        j = 9*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+6, rightTo:8*j+6, koef:1, noZeroLenL:true)
    }

    override func shift23(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:11*s)

        let j = 0
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j, rightTo:8*j, koef:1, noZeroLenL:true)
    }

    override func shift24(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:11*s)

        let j = 6*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+5, rightTo:8*j+5, koef:1, noZeroLenL:true)
    }

    override func shift25(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        let j = 8*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*j+7, koef:1, noZeroLenL:true)
    }

    override func shift26(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        let j = 4*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*j+4, koef:1, noZeroLenL:true)
    }

    override func shift27(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        let j = 4*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*j+4, koef:1, noZeroLenL:true)
    }

    override func shift28(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        let j = 3*s
        HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*j+3, koef:1, noZeroLenL:true)
    }

    override func koef29(ell: Int) -> Int {
        return minusDeg(ell)
    }
}
//#endif /* SHIFTS */
