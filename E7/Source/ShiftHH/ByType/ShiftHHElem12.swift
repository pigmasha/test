//
//  Created by M on 03/07/2019.
//

import Foundation

final class ShiftHHElem12 : ShiftHHElem {
    override func shift0(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:7*s)

        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m), leftTo:7*(j+m), rightFrom:7*j, rightTo:7*j, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+2, rightFrom:7*j+1, rightTo:7*j+1, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+3, rightFrom:7*j+2, rightTo:7*j+2, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+4, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(hhElem, i:j-4*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j+5, rightTo:7*j+5, koef:1)
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(hhElem, i:j-4*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift1(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+2, rightFrom:7*j, rightTo:7*j, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+4, rightFrom:7*j, rightTo:7*j, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m+1), rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m+1), rightFrom:7*j+1, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+1, rightTo:7*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+1, rightTo:7*j+6, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j+2, rightTo:7*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+2, rightTo:7*j+3, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m+1), rightFrom:7*j+4, rightTo:7*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+4, rightTo:7*j+5, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+4, rightTo:7*j+6, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+5, rightTo:7*j+5, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*(j+1)+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift2(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:7*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m-1)+6, leftTo:7*(j+m), rightFrom:7*j, rightTo:7*j, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+3, rightFrom:7*j+1, rightTo:7*j+1, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+4, rightFrom:7*j+1, rightTo:7*j+3, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+5, rightFrom:7*j+2, rightTo:7*j+3, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+2, rightFrom:7*j+4, rightTo:7*j+5, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+3, rightFrom:7*j+5, rightTo:7*j+5, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift3(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:9*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+3, rightFrom:7*j, rightTo:7*j, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+1, rightTo:7*j+2, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+2, rightTo:7*j+3, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+1, rightFrom:7*j+3, rightTo:7*j+3, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+5, rightTo:7*j+5, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+2, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift4(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:10*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m-1)+6, leftTo:7*(j+m-1)+6, rightFrom:7*j, rightTo:7*j, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+5, rightFrom:7*j+1, rightTo:7*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j+1, rightTo:7*j+3, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+2, rightFrom:7*j+3, rightTo:7*j+3, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+3, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+3, rightFrom:7*j+4, rightTo:7*j+5, koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+4, rightFrom:7*j+5, rightTo:7*j+5, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+6, rightTo:7*j+6, koef:-1)
        }
    }

    override func shift5(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:10*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+1, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+1, rightTo:7*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+1, rightTo:7*j+3, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+1, rightFrom:7*j+2, rightTo:7*j+3, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+2, rightFrom:7*j+3, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+3, rightTo:7*j+3, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+4, rightTo:7*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+4, rightTo:7*j+5, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+5, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+4, rightFrom:7*j+5, rightTo:7*j+5, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift6(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:12*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m-1)+6, leftTo:7*(j+m), rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m), leftTo:7*(j+m), rightFrom:7*j, rightTo:7*j, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+1, rightFrom:7*j+1, rightTo:7*j+2, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+3, rightFrom:7*j+3, rightTo:7*j+3, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+4, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+6, rightTo:7*j+6, koef:-1)
        }
    }

    override func shift7(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:12*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+2, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+1, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+1, rightFrom:7*j+1, rightTo:7*j+2, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*j+2, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+3, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+3, rightTo:7*j+6, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+4, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+4, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+4, rightFrom:7*j+4, rightTo:7*j+5, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+5, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+5, rightFrom:7*j+5, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+5, rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:6*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift8(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:13*s)

        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m-1)+6, leftTo:7*(j+m)+4, rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+4, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+4, rightFrom:7*j, rightTo:7*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+8*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+4, rightFrom:7*j, rightTo:7*j+5, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+2, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+2, rightFrom:7*j+1, rightTo:7*j+2, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+3, rightFrom:7*j+2, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+3, rightFrom:7*j+2, rightTo:7*j+3, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+3, rightTo:7*(j+1), koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+6, rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j+5, rightTo:7*j+5, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+5, rightTo:7*j+6, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift9(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(7*s, h:12*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+3, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+2, rightFrom:7*j+1, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+2, rightFrom:7*j+1, rightTo:7*j+2, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:2*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+3, rightFrom:7*j+2, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+3, rightFrom:7*j+2, rightTo:7*j+2, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j+8*s, j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+3, rightTo:7*j+6, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+4, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+5, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+5, rightFrom:7*j+4, rightTo:7*j+5, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+1, rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+2), leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift10(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(9*s, h:12*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m-1)+6, leftTo:7*(j+m)+2, rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+2, rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+7*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+2, rightFrom:7*j, rightTo:7*j+4, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m-1)+6, leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+8*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j+5, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+3, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+3, rightFrom:7*j+1, rightTo:7*j+2, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+2, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+6, rightFrom:7*j+2, rightTo:7*j+2, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+3, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+3, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m+1), rightFrom:7*j+3, rightTo:7*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+3, rightTo:7*j+6, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j+4, rightTo:7*j+4, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m+1), rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+1, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+1, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:7*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+1, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:1)
        }
    }

    override func shift11(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+5, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+4, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+1, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+3, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+2, rightTo:7*(j+1), koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+4, rightFrom:7*j+2, rightTo:7*j+2, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+5, rightFrom:7*j+3, rightTo:7*j+3, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+3, rightTo:7*j+6, koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+1, rightFrom:7*j+4, rightTo:7*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+1, rightFrom:7*j+4, rightTo:7*j+5, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+1, rightFrom:7*j+4, rightTo:7*j+6, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift12(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(10*s, h:10*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+4, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+4, rightFrom:7*j, rightTo:7*j+1, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+3, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+3, rightFrom:7*j, rightTo:7*j+3, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+3, rightFrom:7*j, rightTo:7*j+4, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+1, rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+1, rightFrom:7*j, rightTo:7*j+3, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+6, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+6, rightFrom:7*j+1, rightTo:7*j+2, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m+1), rightFrom:7*j+2, rightTo:7*j+2, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j+3, rightTo:7*j+3, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+3, rightTo:7*j+6, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+4, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m+1), rightFrom:7*j+4, rightTo:7*j+4, koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+2, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+2, rightFrom:7*j+6, rightTo:7*(j+1)+3, koef:1)
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+6, rightTo:7*j+6, koef:-1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(hhElem, i:3*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+6, rightTo:7*(j+1)+2, koef:1)
        }
    }

    override func shift13(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:9*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j+1, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+5, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+4, rightFrom:7*j+1, rightTo:7*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+4, rightFrom:7*j+1, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+6*s, j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+1, rightTo:7*j+6, koef:-1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+5, rightFrom:7*j+2, rightTo:7*j+2, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+5, rightFrom:7*j+2, rightTo:7*j+6, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+4, rightTo:7*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+2, rightFrom:7*j+4, rightTo:7*j+5, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+2, rightFrom:7*j+4, rightTo:7*j+6, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+3, rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+5, rightTo:7*j+6, koef:-1)
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*j+6, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*j+6, koef:1)
        }
    }

    override func shift14(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:7*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m-1)+6, leftTo:7*(j+m)+2, rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+2, rightFrom:7*j, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+2, rightFrom:7*j, rightTo:7*j+3, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j+1, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+4, rightFrom:7*j, rightTo:7*j+5, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+1, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m+1), rightFrom:7*j+1, rightTo:7*j+1, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j+2, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+6, rightFrom:7*j+2, rightTo:7*j+3, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+3, rightTo:7*j+6, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j+4, rightTo:7*j+4, koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+6, rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(hhElem, i:5*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*(j+1)+5, koef:1)
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*j+6, koef:-1)
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:1)
        }
    }

    override func shift15(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(13*s, h:8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j, rightTo:7*j, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j, rightTo:7*j+1, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+1, rightFrom:7*j+1, rightTo:7*j+1, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+5, rightFrom:7*j+1, rightTo:7*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m+1)+5, leftTo:7*(j+m+1)+5, rightFrom:7*j+1, rightTo:7*j+6, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+2, rightFrom:7*j+2, rightTo:7*j+2, koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m+1)+2, leftTo:7*(j+m+1)+3, rightFrom:7*j+3, rightTo:7*j+3, koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+3, rightFrom:7*j+4, rightTo:7*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+3, rightFrom:7*j+4, rightTo:7*j+6, koef:-1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(hhElem, i:j-4*s, j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
        }
        for j in 11*s ..< 12*s {
            HHElem.addElemToHH(hhElem, i:j-5*s, j:j, leftFrom:7*(j+m+1)+3, leftTo:7*(j+m+1)+6, rightFrom:7*j+6, rightTo:7*j+6, koef:-1)
        }
        for j in 12*s ..< 13*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1)+6, leftTo:7*(j+m+2), rightFrom:7*j+6, rightTo:7*(j+1), koef:-1)
        }
    }

    override func shift16(_ hhElem: HHElem, s: Int, m: Int, ell: Int) {
        hhElem.makeZeroMatrix(12*s, h:7*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+4*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+5*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+5, rightFrom:7*j, rightTo:7*j+5, koef:-1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m), leftTo:7*(j+m)+3, rightFrom:7*j, rightTo:7*j, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+3, rightFrom:7*j, rightTo:7*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j+s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+3, rightFrom:7*j, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j+2*s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+3, rightFrom:7*j, rightTo:7*j+3, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+1, leftTo:7*(j+m)+6, rightFrom:7*j+1, rightTo:7*j+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m)+6, rightFrom:7*j+1, rightTo:7*j+2, koef:1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j+1, rightTo:7*j+3, koef:-1)
            HHElem.addElemToHH(hhElem, i:j+3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+1, rightTo:7*j+6, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1), rightFrom:7*j+2, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+2, leftTo:7*(j+m+1), rightFrom:7*j+2, rightTo:7*j+2, koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+3, leftTo:7*(j+m)+6, rightFrom:7*j+3, rightTo:7*j+3, koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+4, leftTo:7*(j+m)+6, rightFrom:7*j+4, rightTo:7*j+4, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m)+6, rightFrom:7*j+4, rightTo:7*j+5, koef:-1)
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m)+6, rightFrom:7*j+4, rightTo:7*j+6, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:7*(j+m)+5, leftTo:7*(j+m+1), rightFrom:7*j+5, rightTo:7*j+5, koef:-1)
            HHElem.addElemToHH(hhElem, i:j-2*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1), rightFrom:7*j+5, rightTo:7*j+6, koef:1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(hhElem, i:s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+1, leftTo:7*(j+m+1)+2, rightFrom:7*j+6, rightTo:7*(j+1)+1, koef:1)
            HHElem.addElemToHH(hhElem, i:j-3*s, j:j, leftFrom:7*(j+m)+6, leftTo:7*(j+m+1)+2, rightFrom:7*j+6, rightTo:7*j+6, koef:-1)
        }
        for j in 11*s ..< 12*s {
            HHElem.addElemToHH(hhElem, i:+myModS(j+1), j:j, leftFrom:7*(j+m+1), leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*(j+1), koef:1)
            HHElem.addElemToHH(hhElem, i:4*s+myModS(j+1), j:j, leftFrom:7*(j+m+1)+4, leftTo:7*(j+m+1)+4, rightFrom:7*j+6, rightTo:7*(j+1)+4, koef:1)
        }
    }

    override func koef17(ell: Int) -> Int {
        return minusDeg(ell)
    }
}
