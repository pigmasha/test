//
//  Created by M on 31.01.18.
//

final class ShiftHHElem06 : ShiftHHElem {
    init() {
        super.init(type:6, withTwist: false)
    }

    override func shift0(_ hhElem: HHElem, degree: Int, shift: Int, n: Int, s: Int, m: Int, ell_0: Int, ell: Int) {
        hhElem.makeZeroMatrix(8*s, h:6*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(hhElem, i:j, j:j, leftFrom:4*j, leftTo:4*j+2, right:4*j, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:4*j+1, leftTo:4*j+3, right:4*j+1, koef:-PathAlg.k1J(ell, j: j, m: m+1))
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:4*j+2, leftTo:4*(j+1), right:4*j+2,
                               koef:-PathAlg.k1JPlus1(ell, j: j, m: m+1))
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(hhElem, i:j-s, j:j, leftFrom:4*j+3, leftTo:4*(j+1)+1, right:4*j+3, koef:1)
        }
    }
}
