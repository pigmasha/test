//
//  Created by M on 21/03/2020.
//

import Foundation

//#if SHIFTS
final class ShiftHHElem03 : ShiftHHElem {
    override func shift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:8*s)

        for j in 0 ..< 2*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:j-j_2*s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+2+4*j_2, rightFrom:8*j, rightTo:8*j, koef:minusDeg(j_2))
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m+1), rightFrom:8*j+4, rightTo:8*j+4, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*j+7, koef:1)
        }
    }

    override func shift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:9*s)

        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:-1)
            for j_1 in 1 ... 3 {
                HHElem.addElemToHH(hhElem, i:j+j_1*s, j:j, leftFrom:8*(j+m)+j_1+1, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+j_1, koef:-1)
            }
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*(j+1)+1, koef:-1, noZeroLenR:true)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1)+2, koef:1, noZeroLenR:true)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        }
        for j in 6*s ..< 8*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:j+(j_2-7)*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+1, rightFrom:8*j+j_2-2, rightTo:8*j+2*(j_2-4), koef:-1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+6, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j+6, rightTo:8*j+6, koef:1)
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*j+7, koef:-1)
        }
    }

    override func shift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:8*s)

        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j, koef:1)
        }
        for j in 4*s ..< 6*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+j_2+3, rightFrom:8*j+j_2-2, rightTo:8*(j+1), koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+7, rightFrom:8*j+4, rightTo:8*j+4, koef:-1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+7, rightFrom:8*j+6, rightTo:8*j+6, koef:1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
        }
    }

    override func shift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:10*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+3, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+1, rightTo:8*(j+1)+1, koef:-1, noZeroLenR:true)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+5, rightTo:8*(j+1), koef:1)
        }
    }

    override func shift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(14*s, h:11*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+8*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+4, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        }
        for j in 12*s ..< 13*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        }
    }

    override func shift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:11*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+2, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+3, koef:1)
        }
        for j in 3*s ..< 5*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+j_2+2, rightFrom:8*j+j_2-2, rightTo:8*(j+1), koef:minusDeg(j_2+1))
        }
        for j in 5*s ..< 7*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+j_2-4, rightFrom:8*j+j_2-3, rightTo:8*(j+1), koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        }
        for j in 12*s ..< 13*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+6, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+4, rightFrom:8*j+6, rightTo:8*(j+1), koef:1)
        }
        for j in 14*s ..< 16*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+j_2-7, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+j_2-7, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        }
    }

    override func shift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:13*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j+2, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+8*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j+3, koef:-1)
        }
        for j in 5*s ..< 7*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:(j_2-5)*s+myModS(j+1), j:j, leftFrom:8*(j+m)+j_2+2, leftTo:8*(j+m)+j_2+2, rightFrom:8*j+j_2-3, rightTo:8*(j+1), koef:minusDeg(j_2+1))
        }
        for j in 13*s ..< 14*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        }
    }

    override func shift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:14*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+1, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+2, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 5*s ..< 7*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+j_2-3, rightFrom:8*j+j_2-3, rightTo:8*(j+1), koef:minusDeg(j_2))
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+4, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
        }
        for j in 17*s ..< 18*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
        }
    }

    override func shift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:16*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+3, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+2, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+10*s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j+1, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        }
    }

    override func shift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:16*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+2, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        }
        for j in 18*s ..< 19*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:8*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:1)
        }
    }

    override func shift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:19*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+1, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+3, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+8*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
        }
        for j in 14*s ..< 15*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:-1)
        }
        for j in 16*s ..< 17*s {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        }
    }

    override func shift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(20*s, h:18*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+1, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+2, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+8*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+5, koef:1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+4, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+1, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        }
    }

    override func shift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:19*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+1, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+10*s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+3, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+12*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j+2, koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        }
        for j in 14*s ..< 15*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        }
    }

    override func shift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:18*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+5, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+2, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+2, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        }
    }

    override func shift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(18*s, h:20*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+8*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+14*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+11*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+2, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j+1, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        }
        for j in 13*s ..< 14*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        }
    }

    override func shift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(19*s, h:18*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+1, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+10*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+5, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+2, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 4*s ..< 6*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+j_2-3, rightFrom:8*j+j_2-3, rightTo:8*(j+1), koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        }
        for j in 14*s ..< 15*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+4, rightFrom:8*j+6, rightTo:8*(j+1), koef:1)
        }
        for j in 16*s ..< 18*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+j_2-9, rightFrom:8*j+7, rightTo:8*(j+1), koef:minusDeg(j_2+1))
        }
    }

    override func shift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:19*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+3, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+13*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+1, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+1, rightFrom:8*j, rightTo:8*j+2, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j+5, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        }
        for j in 13*s ..< 14*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        }
    }

    override func shift17(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(16*s, h:18*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+10*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+5, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+2, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+4, rightFrom:8*j+3, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
        }
        for j in 13*s ..< 15*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+j_2-6, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        }
    }

    override func shift18(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(14*s, h:19*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+2, rightFrom:8*j, rightTo:8*j+2, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+3, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+13*s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+5, koef:-1)
        }
        for j in 3*s ..< 5*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:(j_2-3)*s+myModS(j+1), j:j, leftFrom:8*(j+m)+j_2+4, leftTo:8*(j+m)+j_2+4, rightFrom:8*j+j_2-2, rightTo:8*(j+1), koef:minusDeg(j_2))
        }
        for j in 11*s ..< 12*s {
            HHElem.addElemToHH(hhElem, i:11*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:-1)
        }
        for j in 13*s ..< 14*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        }
    }

    override func shift19(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:16*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+5, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+10*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+6, koef:1)
        }
        for j in 2*s ..< 4*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+3, leftTo:8*(j+m+1)+j_2+1, rightFrom:8*j+j_2-1, rightTo:8*(j+1), koef:minusDeg(j_2+1))
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+5, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        }
        for j in 12*s ..< 13*s {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        }
    }

    override func shift20(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:16*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+10*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+3, rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+11*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+5, rightFrom:8*j, rightTo:8*j+6, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        }
        for j in 8*s ..< 10*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:10*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2*(j_2-7), rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:minusDeg(j_2))
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        }
    }

    override func shift21(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(11*s, h:14*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+3, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+4, leftTo:8*(j+m+1)+4, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+6, leftTo:8*(j+m+1)+6, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        }
    }

    override func shift22(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:13*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m-1)+7, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:8*(j+m)+1, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m)+2, leftTo:8*(j+m)+4, rightFrom:8*j, rightTo:8*j+5, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+9*s, j:j, leftFrom:8*(j+m)+6, leftTo:8*(j+m)+6, rightFrom:8*j, rightTo:8*j+6, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        }
        for j in 3*s ..< 5*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+j_2-3, rightFrom:8*j+j_2-1, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+j_2-3, rightFrom:8*j+j_2-1, rightTo:8*(j+1), koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+2, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j+4, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+4, rightTo:8*(j+1)+4, koef:1, noZeroLenR:true)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+7, rightTo:8*(j+1)+5, koef:-1)
        }
    }

    override func shift23(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:11*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+3, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+1, rightTo:8*(j+1), koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+2), leftTo:8*(j+m+2), rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:-1)
        }
    }

    override func shift24(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:11*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m), leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+5, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+1, koef:-1)
            for j_1 in 1 ... 3 {
                HHElem.addElemToHH(hhElem, i:j+(j_1+3)*s, j:j, leftFrom:8*(j+m)+j_1, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+2+j_1, koef:1-2*f(j_1,1))
            }
        }
        for j in s ..< 3*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+j_2-1, rightFrom:8*j+j_2, rightTo:8*(j+1), koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+2, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+3, rightTo:8*(j+1)+3, koef:-1, noZeroLenR:true)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*(j+1)+3, koef:-1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+4, rightTo:8*(j+1)+4, koef:1, noZeroLenR:true)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1), koef:-1)
            for j_1 in 1 ... 3 {
                HHElem.addElemToHH(hhElem, i:(j_1+3)*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+j_1, leftTo:8*(j+m+1)+4, rightFrom:8*j+7, rightTo:8*(j+1)+j_1+2, koef:-1+2*f(j_1,1))
            }
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+7, rightTo:8*(j+1)+1, koef:1)
        }
    }

    override func shift25(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:10*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:8*(j+m)+4, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+6, koef:-1)
        }
    }

    override func shift26(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        for j in 0 ..< s {
            for j_1 in 1 ... 4 {
                HHElem.addElemToHH(hhElem, i:j+(j_1+1)*s, j:j, leftFrom:8*(j+m)+j_1, leftTo:8*(j+m+1), rightFrom:8*j, rightTo:8*j+j_1+1, koef:1-2*f(j_1,2))
            }
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+1, rightFrom:8*j+1, rightTo:8*(j+1), koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+2, rightFrom:8*j+2, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+2, rightTo:8*(j+1)+2, koef:1, noZeroLenR:true)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*(j+1)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+3, rightTo:8*(j+1)+3, koef:-1, noZeroLenR:true)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+4, rightFrom:8*j+4, rightTo:8*(j+1), koef:1)
            for j_1 in 1 ... 3 {
                HHElem.addElemToHH(hhElem, i:(j_1+1)*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+j_1, leftTo:8*(j+m+1)+4, rightFrom:8*j+4, rightTo:8*(j+1)+j_1+1, koef:minusDeg(j_1+1), noZeroLenR:true)
            }
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+6, rightTo:8*(j+1)+6, koef:1, noZeroLenR:true)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1), koef:1, noZeroLenL:true)
            for j_1 in 1 ... 4 {
                HHElem.addElemToHH(hhElem, i:(j_1+1)*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+j_1, leftTo:8*(j+m+1)+7, rightFrom:8*j+7, rightTo:8*(j+1)+j_1+1, koef:1-2*f(j_1,2))
            }
        }
    }

    override func shift27(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+1, rightFrom:8*j, rightTo:8*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+1, rightFrom:8*j, rightTo:8*j+5, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1)+7, leftTo:8*(j+m+1)+7, rightFrom:8*j+6, rightTo:8*(j+1), koef:-1)
        }
    }

    override func shift28(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:8*s)

        for j in 0 ..< s {
            for j_1 in 1 ... 7 {
                HHElem.addElemToHH(hhElem, i:j+j_1*s, j:j, leftFrom:8*(j+m)+j_1, leftTo:8*(j+m)+7, rightFrom:8*j, rightTo:8*j+j_1, koef:1-2*(f(j_1,1)+f(j_1,3)+f(j_1,6)))
            }
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+2, rightFrom:8*j+1, rightTo:8*(j+1)+1, koef:-1, noZeroLenR:true)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+1, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*(j+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+2, leftTo:8*(j+m+1)+3, rightFrom:8*j+2, rightTo:8*(j+1)+2, koef:1, noZeroLenR:true)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 1 ... 3 {
                HHElem.addElemToHH(hhElem, i:j_1*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+j_1, leftTo:8*(j+m+1)+4, rightFrom:8*j+3, rightTo:8*(j+1)+j_1, koef:minusDeg(j_1), noZeroLenR:true)
            }
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+6, rightFrom:8*j+5, rightTo:8*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:8*(j+m+1)+5, leftTo:8*(j+m+1)+6, rightFrom:8*j+5, rightTo:8*(j+1)+5, koef:-1, noZeroLenR:true)
        }
        for j in 6*s ..< 8*s {
            let j_2 = j / s
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:8*(j+m+1), leftTo:8*(j+m+1)+1+7*(j_2-6), rightFrom:8*j+j_2, rightTo:8*(j+1), koef:-1, noZeroLenL:true)
        }
    }
}
//#endif /* SHIFTS */
