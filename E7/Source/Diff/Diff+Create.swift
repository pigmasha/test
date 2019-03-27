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
        case 1: createDiffWithNumber2()
        case 2: createDiffWithNumber4()
        case 3: createDiffWithNumber6()
        case 4: createDiffWithNumber2()
        case 5: createDiffWithNumber2()
        case 6: createDiffWithNumber2()
        case 7: createDiffWithNumber2()
        default: break
        }
    }

    private func createOddDiff(_ m: Int) {
        switch (m) {
        case 0: createDiffWithNumber1()
        case 1: createDiffWithNumber3()
        case 2: createDiffWithNumber5()
        case 3: createDiffWithNumber1()
        case 4: createDiffWithNumber1()
        case 5: createDiffWithNumber1()
        case 6: createDiffWithNumber1()
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
        /*for j in 0 ..< s {
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(j_1+1-f(j_1,0)), j, 7*(j+m)+1+j_1+2*f(j_1,3), 7*(j+m+1)-1, 7*j, 7*j+j_1, 1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+4-3*f(j_1,0)), j, 7*(j+m+1)-3+j_1, 7*(j+m+1)-1, 7*j, 7*j+j_1+3*(1-f(j_1,0)), -1)
            }
        }*/
    }

    private func createDiffWithNumber2() {
    }

    private func createDiffWithNumber3() {
    }

    private func createDiffWithNumber4() {
    }

    private func createDiffWithNumber5() {
    }

    private func createDiffWithNumber6() {
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
