//
//  Created by M on 09.06.2018.
//

import Foundation

extension Diff {
    func createDiff() {
        let r = deg % PathAlg.twistPeriod
        let m = r / 2
        if r % 2 == 0 {
            createEvenDiff(m)
        } else {
            createOddDiff(m)
        }
        let l = deg / PathAlg.twistPeriod
        for _ in 0 ..< l {
            for row in rows {
                for c in row { c.twist(backward: false) }
            }
        }
    }

    private func createEvenDiff(_ m: Int) {
        switch (m) {
        case 0: createDiffWithNumber0()
        default: break
        }
    }

    private func createOddDiff(_ m: Int) {
        switch (m) {
        case 0: createDiffWithNumber1()
        default: break
        }
    }

    private func createDiffWithNumber0() {
        let s = PathAlg.s
        let m = 0
        makeZeroMatrix(8*s, h: 7*s)

        for j in 0 ..< 2*s {
            let j_2 = j / s
            addTenToPos(j%s, j, 7*(j+m), 7*(j+m)+3*j_2+1, 7*j, 7*j, 1)
            addTenToPos(j+s*(2*j_2+1), j, 7*(j+m)+3*j_2+1, 7*(j+m)+3*j_2+1, 7*j, 7*j+3*j_2+1, -1)
        }

        for j in 2*s ..< 5*s {
            let j_2 = j / s
            addTenToPos(j-s, j, 7*(j+m)+j_2-1, 7*(j+m)+j_2+2*f(j_2,4), 7*j+j_2-1, 7*j+j_2-1, 1)
            addTenToPos(j+2*s*f(j_2, 4), j, 7*(j+m)+j_2+2*f(j_2,4), 7*(j+m)+j_2+2*f(j_2,4), 7*j+j_2-1, 7*j+j_2+2*f(j_2,4), -1)
        }

        for j in 5*s ..< 7*s {
            let j_2 = j / s
            addTenToPos(j-s, j, 7*(j+m)+j_2-1, 7*(j+m)+j_2, 7*j+j_2-1, 7*j+j_2-1, 1)
            addTenToPos(j, j, 7*(j+m)+j_2, 7*(j+m)+j_2, 7*j+j_2-1, 7*j+j_2, -1)
        }

        for j in 7*s ..< 8*s {
            addTenToPos(j-s, j, 7*(j+m)+6, 7*(j+m+1), 7*j+6, 7*j+6, 1)
            addTenToPos((j+1)%s, j, 7*(j+m+1), 7*(j+m+1), 7*j+6, 7*j+7, -1)
        }
    }

    private func createDiffWithNumber1() {
    }

    private func addTenToPos(_ i: Int, _ j: Int, _ leftFrom: Int, _ leftTo: Int,
                             _ rightFrom: Int, _ rightTo: Int, _ koef: Int) {
        addTenToPosNoZero(i, j, leftFrom, leftTo, false, rightFrom, rightTo, false, koef)
    }

    private func addTenToPosNoZero(_ i: Int, _ j: Int, _ leftFrom: Int, _ leftTo: Int, _ leftNoZero: Bool,
                                   _ rightFrom: Int, _ rightTo: Int, _ rightNoZero: Bool, _ koef: Int) {
        let wL = Way(from: leftFrom, to: leftTo, noZeroLen: leftNoZero)
        let wR = Way(from: rightFrom, to: rightTo, noZeroLen : rightNoZero)
        if wL.isZero || wR.isZero { fatalError("[\(i), \(j)]: zero way \(wL.str) \(wR.str)") }
        rows[i][j].addComb(Comb(tenzor: Tenzor(left: wL, right: wR), koef: Double(koef)))
    }
}
