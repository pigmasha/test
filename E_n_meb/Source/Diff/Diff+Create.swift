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
        case 4: createDiffWithNumber8()
        case 5: createDiffWithNumber10()
        default: break
        }
    }

    private func createOddDiff(_ m: Int) {
        switch (m) {
        case 0: createDiffWithNumber1()
        case 1: createDiffWithNumber3()
        case 2: createDiffWithNumber5()
        case 3: createDiffWithNumber7()
        case 4: createDiffWithNumber9()
        default: break
        }
    }

    private func createDiffWithNumber0() {
        let s = PathAlg.s
        let m = 0
        makeZeroMatrix(7*s, h: 6*s)

        for j in 0 ..< 2*s {
            addTenToPos(j%s, j, 4*(j+m), 4*(j+m)+1, 4*j, 4*j, 1)
            addTenToPos(j+s, j, 4*(j+m)+1, 4*(j+m)+1, 4*j, 4*j+1, -1)
        }

        for j in 2*s ..< 4*s {
            addTenToPos(j-s, j, 4*(j+m)+1, 4*(j+m)+2, 4*j+1, 4*j+1, 1)
            addTenToPos(j+s, j, 4*(j+m)+2, 4*(j+m)+2, 4*j+1, 4*j+2, -1)
        }

        for j in 4*s ..< 6*s {
            addTenToPos(j-s, j, 4*(j+m)+2, 4*(j+m)+3, 4*j+2, 4*j+2, 1)
            addTenToPos(j%s+5*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+2, 4*j+3, -1)
        }

        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 4*(j+m+1), 4*(j+m+1), 4*j+3, 4*(j+1), -1)
            addTenToPos(j-s, j, 4*(j+m)+3, 4*(j+m+1), 4*j+3, 4*j+3, 1)
        }
    }

    private func createDiffWithNumber2() {
        let s = PathAlg.s
        let m = 1
        makeZeroMatrix(8*s, h: 6*s)

        for j in 0 ..< 2*s {
            addTenToPos(j%s, j, 4*(j+m-1)+3, 4*(j+m)+2, 4*j, 4*j, 1)
            addTenToPos(j+s, j, 4*(j+m)+2, 4*(j+m)+2, 4*j, 4*j+1, -f1(j,s))
            addTenToPos((j+s)%(2*s)+3*s, j, 4*(j+m)+1, 4*(j+m)+2, 4*j, 4*(j+s)+2, f1(j,s))
        }

        for j in 2*s ..< 4*s {
            let i_2 = j % s
            addTenToPos((j+1)%s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+1, 4*(j+1), -f1(j, 3*s)*f1(i_2,s-1))
            addTenToPos(j-s, j, 4*(j+m)+2, 4*(j+m)+3, 4*j+1, 4*j+1, 1)
            addTenToPos(j+s, j, 4*(j+m+s)+1, 4*(j+m)+3, 4*j+1, 4*j+2, -1)
        }

        for j in 4*s ..< 6*s {
            if (j<5*s-1 || j==6*s-1) { addTenToPos((j+1)%s, j, 4*(j+m)+3, 4*(j+m+1), 4*j+2, 4*(j+1), 1) }
            addTenToPos(j-s, j, 4*(j+m+s)+1, 4*(j+m+1), 4*j+2, 4*j+2, 1)
            addTenToPos(j%s+5*s, j, 4*(j+m+1), 4*(j+m+1), 4*j+2, 4*j+3, -1)
        }

        for j in 6*s ..< 8*s {
            if (j<7*s-1 || j==8*s-1) { addTenToPos((j+1)%s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*j+3, 4*(j+1), -1) }
            addTenToPos((j+s+1)%(2*s)+3*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*j+3, 4*(j+s+1)+2, -1)
            addTenToPos(j%s+5*s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*j+3, 4*j+3, 1)
        }
    }

    private func createDiffWithNumber4() {
        let s = PathAlg.s
        let m = 2
        makeZeroMatrix(8*s, h: 9*s)

        for j in 0 ..< 2*s {
            if (j<s) { addTenToPos(j, j, 4*(j+m-1)+3, 4*(j+m)+1, 4*j, 4*j, 1) }
            addTenToPos(j%s+s, j, 4*(j+m), 4*(j+m)+1, 4*j, 4*j, -f1(j,s))
            addTenToPos((j+s)%(2*s)+2*s, j, 4*(j+m)+1, 4*(j+m)+1, 4*j, 4*(j+s)+1, -1)
            addTenToPos(j+(5-f0(j,s))*s, j, 4*(j+m)+1, 4*(j+m)+1, 4*j, 4*j+2, 1)
        }

        for j in 2*s ..< 4*s {
            let i_2 = j % s
            if(j<3*s-1||j==4*s-1) { addTenToPos((j+1)%s, j, 4*(j+m)+3, 4*(j+m+1), 4*j+1, 4*(j+1), 1) }
            addTenToPos((j+1)%s+s, j, 4*(j+m+1), 4*(j+m+1), 4*j+1, 4*(j+1), -f1(i_2,s-1)*f1(j,3*s))
            addTenToPos(j, j, 4*(j+m+s)+1, 4*(j+m+1), 4*j+1, 4*j+1, 1)
            addTenToPos(j+(4-f0(j,3*s))*s, j, 4*(j+m+s)+2, 4*(j+m+1), 4*j+1, 4*j+2, -1)
        }

        for j in 4*s ..< 6*s {
            if(j<5*s-1||j==6*s-1) { addTenToPos((j+1)%s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+2, 4*(j+1), 1) }
            addTenToPos(j+(1-f0(j,5*s))*s, j, 4*(j+m)+1, 4*(j+m)+3, 4*j+2, 4*j+2, 1)
            addTenToPos(j+(2-f0(j,5*s))*s, j, 4*(j+m+s)+2, 4*(j+m)+3, 4*j+2, 4*j+2, -1)
            addTenToPos(j%s+8*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+2, 4*j+3, -f1(j,5*s))
        }

        for j in 6*s ..< 8*s {
            if j<7*s-1||j==8*s-1 { addTenToPos((j+1)%s, j, 4*(j+m)+3, 4*(j+m+1)+2, 4*j+3, 4*(j+1), -f1(j,7*s)) }
            addTenToPos((j+s+1)%(2*s)+2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+2, 4*j+3, 4*(j+s+1)+1, f1(j,7*s))
            if j<7*s-1||j==8*s-1 { addTenToPos((j+1)%s+7*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*j+3, 4*(j+s+1)+2, -f1(j,7*s)) }
            if j>=7*s-1&&j<8*s-1 { addTenToPos((j+1)%s+5*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*j+3, 4*(j+s+1)+2, -f1(j,7*s)) }
            addTenToPos(j%s+8*s, j, 4*(j+m)+3, 4*(j+m+1)+2, 4*j+3, 4*j+3, 1)
        }
    }

    private func createDiffWithNumber6() {
        let s = PathAlg.s
        let m = 3
        makeZeroMatrix(8*s, h: 9*s)

        for j in 0 ..< 2*s {
            let j_2 = j / s
            addTenToPos(j%s, j, 4*(j+m), 4*(j+m)+2, 4*j, 4*j, 1)
            addTenToPos(j+(j_2+1)*s, j, 4*(j+m)+1, 4*(j+m)+2, 4*j, 4*j+1, -1)
            addTenToPos(j+(4-3*j_2)*s, j, 4*(j+m)+2, 4*(j+m)+2, 4*j, 4*(j+s)+1, -1)
            addTenToPos(j+5*s, j, 4*(j+m)+2, 4*(j+m)+2, 4*j, 4*j+2, 1)
        }

        for j in 2*s ..< 4*s {
            let j_2 = j / s
            addTenToPos(j+s*(j_2-3), j, 4*(j+m)+1, 4*(j+m)+3, 4*j+1, 4*j+1, 1)
            addTenToPos(j+s*(j_2-2), j, 4*(j+m+s)+2, 4*(j+m)+3, 4*j+1, 4*j+1, -1)
            addTenToPos(j+3*s, j, 4*(j+m)+2, 4*(j+m)+3, 4*j+1, 4*j+2, -1)
            addTenToPos(j%s+7*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+1, 4*j+3, 1)
        }

        for j in 4*s ..< 6*s {
            if (j>=5*s) { addTenToPos((j+1)%s, j, 4*(j+m+1), 4*(j+m+1), 4*j+2, 4*(j+1), 1) }
            addTenToPos(j+s, j, 4*(j+m)+2, 4*(j+m+1), 4*j+2, 4*j+2, 1)
            if (j>=5*s) { addTenToPos(j+2*s, j, 4*(j+m)+3, 4*(j+m+1), 4*j+2, 4*j+3, -1) }
            addTenToPos(j%s+8*s, j, 4*(j+m+1), 4*(j+m+1), 4*j+2, 4*j+3, -f1(j,5*s))
        }

        for j in 6*s ..< 8*s {
            if (j<7*s) { addTenToPos((j+1)%s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*j+3, 4*(j+1), -1) }
            if (j<7*s-1||j==8*s-1) { addTenToPos((j+1)%(2*s)+s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*j+3, 4*(j+1)+1, 1) }
            if (j>=7*s-1&&j<8*s-1) { addTenToPos((j+1)%(2*s)+2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*j+3, 4*(j+1)+1, 1) }
            if (j<7*s) { addTenToPos(j+s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*j+3, 4*j+3, 1) }
            addTenToPos(j%s+8*s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*j+3, 4*j+3, -f1(j,7*s))
        }
    }

    private func createDiffWithNumber8() {
        let s = PathAlg.s
        let m = 4
        makeZeroMatrix(7*s, h: 6*s)

        for j in 0 ..< s {
            addTenToPosNoZero(j, j, 4*(j+m-1)+3, 4*(j+m)+3, true, 4*j, 4*j, false, 1)
            addTenToPosNoZero((j+1)%s, j, 4*(j+m)+3, 4*(j+m)+3, false, 4*j, 4*(j+1), true, -f1(j,s-1))
            addTenToPos(j+s, j, 4*(j+m)+2, 4*(j+m)+3, 4*j, 4*j+1, -1)
            addTenToPos(j+2*s, j, 4*(j+m+s)+2, 4*(j+m)+3, 4*j, 4*(j+s)+1, 1)
            addTenToPos(j+3*s, j, 4*(j+m+s)+1, 4*(j+m)+3, 4*j, 4*j+2, 1)
            addTenToPos(j+4*s, j, 4*(j+m)+1, 4*(j+m)+3, 4*j, 4*(j+s)+2, -1)
        }

        for j in s ..< 3*s {
            if(j<2*s-1||j==3*s-1) { addTenToPos((j+1)%s, j, 4*(j+m)+3, 4*(j+m+1), 4*(j+s)+1, 4*(j+1), 1) }
            addTenToPos(j, j, 4*(j+m+s)+2, 4*(j+m+1), 4*(j+s)+1, 4*(j+s)+1, 1)
            addTenToPos(j+2*s, j, 4*(j+m)+1, 4*(j+m+1), 4*(j+s)+1, 4*(j+s)+2, -1)
            addTenToPos(j%s+5*s, j, 4*(j+m+1), 4*(j+m+1), 4*(j+s)+1, 4*j+3, 1)
        }

        for j in 3*s ..< 5*s {
            if(j<4*s-1||j==5*s-1) { addTenToPos((j+1)%s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*(j+s)+2, 4*(j+1), -1) }
            addTenToPosNoZero(j, j, 4*(j+m)+1, 4*(j+m+1)+1, true, 4*(j+s)+2, 4*(j+s)+2, false, 1)
            addTenToPosNoZero((j+s+1)%(2*s)+3*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, false, 4*(j+s)+2, 4*(j+s+1)+2, true, -1)
            addTenToPos(j%s+5*s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+2, 4*j+3, -1)
        }

        for j in 5*s ..< 7*s {
            if(j>=6*s-1&&j<7*s-1) { addTenToPos((j+1)%s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*j+3, 4*(j+1), 1) }
            addTenToPos((j+s+1)%(2*s)+s, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*j+3, 4*(j+s+1)+1, 1)
            addTenToPos((j+1)%(2*s)+3*s, j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+2, 4*j+3, 4*(j+1)+2, 1)
            addTenToPos(j%s+5*s, j, 4*(j+m+1), 4*(j+m+s+1)+2, 4*j+3, 4*j+3, 1)
        }
    }

    private func createDiffWithNumber10() {
        let s = PathAlg.s
        let m = 5
        makeZeroMatrix(6*s, h: 6*s)

        for j in 0 ..< s {
            addTenToPosNoZero((j+1)%s, j, 4*(j+m+1), 4*(j+m+1), false, 4*j, 4*(j+1), true, -f1(j,s-1))
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2*j_1+1)*s, j, 4*(j+m+s)+1+j_1, 4*(j+m+1), 4*j, 4*j+1+j_1, -f1(j_1, 1))
            }
            for j_1 in 0 ... 2 {
                addTenToPosNoZero(j+2*j_1*s, j, 4*(j+m)+j_1, 4*(j+m+1), true, 4*j, 4*(j+s)+j_1, false, f1(j_1, 2))
            }
        }

        for j in s ..< 3*s {
            let i_2 = j % s
            addTenToPos((j+1)%s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+1), f1(i_2, s-1)*f1(j,2*s))
            addTenToPos(j, j, 4*(j+m)+1, 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s)+1, 1)
            addTenToPos((j+s+1)%(2*s)+s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s+1)+1, -1)
            addTenToPos(j+2*s, j, 4*(j+m)+2, 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s)+2, -1)
            addTenToPos(j%s+5*s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*(j+s)+1, 4*j+3, -f1(j,2*s))
        }

        for j in 3*s ..< 5*s {
            let i_2 = j % s
            addTenToPos((j+1)%s, j, 4*(j+m+1), 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+1), -f1(i_2,s-1)*f1(j,4*s))
            addTenToPos((j+s+1)%(2*s)+s, j, 4*(j+m+1)+1, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+s+1)+1, 1)
            addTenToPos(j, j, 4*(j+m)+2, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+s)+2, 1)
            addTenToPos((j+s+1)%(2*s)+3*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+s+1)+2, -1)
            addTenToPos(j%s+5*s, j, 4*(j+m)+3, 4*(j+m+1)+2, 4*(j+s)+2, 4*j+3, f1(j,4*s))
        }

        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 4*(j+m+1), 4*(j+m+1)+3, 4*j+3, 4*(j+1), -f1(j,6*s-1))
            addTenToPos(j-4*s+1, j, 4*(j+m+1)+1, 4*(j+m+1)+3, 4*j+3, 4*(j+s+1)+1, 1)
            addTenToPos((j+1)%(2*s)+s, j, 4*(j+m+s+1)+1, 4*(j+m+1)+3, 4*j+3, 4*(j+1)+1, -1)
            addTenToPos(j-2*s+1, j, 4*(j+m+1)+2, 4*(j+m+1)+3, 4*j+3, 4*(j+s+1)+2, -1)
            addTenToPos((j+1)%(2*s)+3*s, j, 4*(j+m+s+1)+2, 4*(j+m+1)+3, 4*j+3, 4*(j+1)+2, 1)
            addTenToPosNoZero(j, j, 4*(j+m)+3, 4*(j+m+1)+3, true, 4*j+3, 4*j+3, false, 1)
            addTenToPosNoZero((j+1)%s+5*s, j, 4*(j+m+1)+3, 4*(j+m+1)+3, false, 4*j+3, 4*(j+1)+3, true, -f1(j,6*s-1))
        }
    }

    private func createDiffWithNumber1() {
        let s = PathAlg.s
        let m = 0
        makeZeroMatrix(6*s, h:7*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+2*j_1*s, j, 4*(j+m)+1+j_1, 4*(j+m)+3, 4*j, 4*j+j_1, 1)
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2*j_1+1)*s, j, 4*(j+m+s)+1+j_1, 4*(j+m)+3, 4*j, 4*(j+s)+j_1, -1)
            }
        }

        for j in s ..< 3*s {
            addTenToPos(j<2*s ? j-s+1 : (j+s+1)%(2*s), j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+1), 1)
            addTenToPosNoZero(j+s, j, 4*(j+m+s)+2, 4*(j+m+s+1)+2, true, 4*(j+s)+1, 4*(j+s)+1, false, 1)
            addTenToPosNoZero(j<2*s ? j+s+1 : (j+s+1)%(2*s)+2*s, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, false, 4*(j+s)+1, 4*(j+s+1)+1, true, 1)
            addTenToPos(j+3*s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+s)+2, 1)
            addTenToPos(j%s+6*s, j, 4*(j+m+1), 4*(j+m+s+1)+2, 4*(j+s)+1, 4*j+3, 1)
        }

        for j in 3*s ..< 5*s {
            addTenToPos((j<4*s) ? (j+1)%(2*s):j-4*s+1, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*(j+s)+2, 4*(j+1), 1)
            addTenToPos(j+s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*(j+s)+2, 4*(j+s)+2, 1)
            addTenToPos(j%s+6*s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+2, 4*j+3, 1)
        }

        for j in 5*s ..< 6*s {
            let i_2 = j % s
            addTenToPos((j+1)%s, j, 4*(j+m+(1-f(i_2,s-1))*s+1)+1, 4*(j+m+2), 4*j+3, 4*(j+1), 1)
            addTenToPos((j+1)%s+2*s, j, 4*(j+m+(1-f(i_2,s-1))*s+1)+2, 4*(j+m+2), 4*j+3, 4*(j+(1-f(i_2,s-1))*s+1)+1, 1)
            addTenToPos((j+1)%s+4*s, j, 4*(j+m+1)+3, 4*(j+m+2), 4*j+3, 4*(j+(1-f(i_2,s-1))*s+1)+2, 1)
            addTenToPosNoZero(j+s, j, 4*(j+m+1), 4*(j+m+2), true, 4*j+3, 4*j+3, false, 1)
            addTenToPosNoZero((j+1)%s+6*s, j, 4*(j+m+2), 4*(j+m+2), false, 4*j+3, 4*(j+1)+3, true, 1)
        }
    }

    private func createDiffWithNumber3() {
        let s = PathAlg.s
        let m = 1
        makeZeroMatrix(9*s, h: 8*s)

        for j in 0 ..< 2*s {
            let j_2 = j / s
            addTenToPos(j%s, j, 4*(j+m+j_2*s)+2, 4*(j+m)+3+j_2, 4*j, 4*j, 1)
            addTenToPos(j+s+3*j_2*s, j, 4*(j+m+s)+2+2*j_2, 4*(j+m)+3+j_2, 4*j, 4*j+2*j_2, -1)
            addTenToPos(j+(2+j_2)*s, j, 4*(j+m)+3+j_2, 4*(j+m)+3+j_2, 4*j, 4*(j+j_2*s)+1+j_2, 1)
            addTenToPos((j+s)%(2*s)+2*s, j, 4*(j+m)+3, 4*(j+m)+3+j_2, 4*j, 4*(j+s)+1, 1)
        }

        for j in 2*s ..< 4*s {
            addTenToPos(j, j, 4*(j+m)+3, 4*(j+m+s+1)+1, 4*j+1, 4*j+1, 1)
            addTenToPos(j+2*s, j, 4*(j+m+1), 4*(j+m+s+1)+1, 4*j+1, 4*j+2, 1)
            addTenToPos((j+s)%(2*s)+6*s, j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+1, 4*j+1, 4*j+3, 1)
        }

        for j in 4*s ..< 6*s {
            let j_2 = j / s
            if j>=5*s { addTenToPos((j+1)%(2*s), j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+1), -f1(j,6*s-1)) }
            addTenToPos(j%s+4*s, j, 4*(j+m+1), 4*(j+m+1)+j_2-3, 4*(j+(j_2-4)*s)+2, 4*(j+(j_2-4)*s)+2, 1)
            addTenToPos(j+2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+j_2-3, 4*(j+(j_2-4)*s)+2, 4*j+3, 1)
        }

        for j in 6*s ..< 8*s {
            let j_2 = j / s
            if j>=7*s { addTenToPos(j-7*s+1, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*j+2, 4*(j+1), f1(j,8*s-1)) }
            addTenToPos(j%s+5*s, j, 4*(j+m+1), 4*(j+m+s+1)+1+j_2-6, 4*(j+(7-j_2)*s)+2, 4*(j+(7-j_2)*s)+2, 1)
            addTenToPos((j+s)%(2*s)+6*s, j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+1+j_2-6, 4*(j+(7-j_2)*s)+2, 4*j+3, 1)
        }

        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 4*(j+m+f(j,9*s-1)*s+1)+2, 4*(j+m+1)+3, 4*j+3, 4*(j+1), f1(j,9*s-1))
            addTenToPos((j+1)%s+2*s, j, 4*(j+m+1)+3, 4*(j+m+1)+3, 4*j+3, 4*(j+f(j,9*s-1)*s+1)+1, f1(j,9*s-1))
            addTenToPos(j-2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+3, 4*j+3, 4*j+3, 1)
            addTenToPos(j-s, j, 4*(j+m+s+1)+1, 4*(j+m+1)+3, 4*j+3, 4*j+3, -1)
        }
    }

    private func createDiffWithNumber5() {
        let s = PathAlg.s
        let m = 2
        makeZeroMatrix(9*s, h: 8*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+2*j_1*s, j, 4*(j+m)+1+j_1+2*f(j_1,1), 4*(j+m+1), 4*j, 4*j+j_1, f1(j_1,2))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2*j_1+1)*s, j, 4*(j+m+s)+1+j_1+2*f(j_1,1), 4*(j+m+1), 4*j, 4*(j+s)+j_1, f1(j_1,2))
            }
        }

        for j in s ..< 3*s {
            let j_2 = j / s
            addTenToPos((j+s+1)%(2*s), j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+j_2, 4*(j+s*(2-j_2))+1, 4*(j+1), -f1(j,2*s))
            addTenToPos(j%s+2*s, j, 4*(j+m+1), 4*(j+m+s+1)+j_2, 4*(j+s*(2-j_2))+1, 4*(j+s*(2-j_2))+1, 1)
            if j>=2*s { addTenToPos(j+2*s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*j+1, 4*j+2, -1) }
            if j>=2*s { addTenToPos(j+5*s, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*j+1, 4*j+3, -1) }
        }

        for j in 3*s ..< 5*s {
            let j_2 = j / s
            addTenToPos((j+1)%(2*s), j, 4*(j+m+1)+1, 4*(j+m+1)+j_2-2, 4*(j+s*(j_2-3))+1, 4*(j+1), -f1(j,4*s))
            addTenToPos(j%s+3*s, j, 4*(j+m+1), 4*(j+m+1)+j_2-2, 4*(j+s*(j_2-3))+1, 4*(j+s*(j_2-3))+1, 1)
            if j>=4*s { addTenToPos(j+s, j, 4*(j+m)+3, 4*(j+m+1)+2, 4*(j+s)+1, 4*(j+s)+2, -1) }
            if j>=4*s { addTenToPos(j+2*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*(j+s)+1, 4*j+3, 1) }
        }

        for j in 5*s ..< 7*s {
            addTenToPos(j-s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*(j+s)+2, 4*(j+s)+2, 1)
            addTenToPos(j+s, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*(j+s)+2, 4*j+3, f1(j,6*s))
        }

        for j in 7*s ..< 8*s {
            addTenToPos(j-7*s+1, j, 4*(j+m+s+1)+1, 4*(j+m+1)+3, 4*j+3, 4*(j+1), 1)
            addTenToPos((j+1)%(2*s), j, 4*(j+m+1)+1, 4*(j+m+1)+3, 4*j+3, 4*(j+1), 1)
            addTenToPos(j-3*s+1, j, 4*(j+m+1)+3, 4*(j+m+1)+3, 4*j+3, 4*(j+s+1)+2, -1)
            addTenToPos((j+1)%(2*s)+4*s, j, 4*(j+m+1)+3, 4*(j+m+1)+3, 4*j+3, 4*(j+1)+2, -1)
            addTenToPos(j-s, j, 4*(j+m+s+1)+2, 4*(j+m+1)+3, 4*j+3, 4*j+3, 1)
            addTenToPos(j, j, 4*(j+m+1)+2, 4*(j+m+1)+3, 4*j+3, 4*j+3, -1)
        }

        for j in 8*s ..< 9*s {
            addTenToPos((j+s+1)%(2*s)+2*s, j, 4*(j+m+2), 4*(j+m+2), 4*j+3, 4*(j+s+1)+1, -1)
            addTenToPos(j-2*s, j, 4*(j+m+1)+2, 4*(j+m+2), 4*j+3, 4*j+3, 1)
        }
    }

    private func createDiffWithNumber7() {
        let s = PathAlg.s
        let m = 3
        makeZeroMatrix(6*s, h: 8*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 4*(j+m)+2, 4*(j+m)+3, 4*j, 4*j, 1)
            addTenToPos(j+s, j, 4*(j+m+s)+2, 4*(j+m)+3, 4*j, 4*j, -1)
            addTenToPos(j+2*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j, 4*j+1, 1)
            addTenToPos(j+3*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j, 4*(j+s)+1, -1)
        }

        for j in s ..< 3*s {
            addTenToPos((j+s+1)%(2*s), j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+1), -1)
            addTenToPos(j+s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+s)+1, 1)
            addTenToPos(j+3*s, j, 4*(j+m+1), 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+s)+2, 1)
            addTenToPos(j+5*s, j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*j+3, -1)
        }

        for j in 3*s ..< 5*s {
            addTenToPos(j+s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+2, 4*(j+s)+2, 1)
            addTenToPos(j%(2*s)+6*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*(j+s)+2, 4*j+3, 1)
        }

        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s+s, j, 4*(j+m+1+s*f(j,6*s-1))+2, 4*(j+m+2), 4*j+3, 4*(j+1), 1)
            addTenToPos((j+1)%s+2*s, j, 4*(j+m+1)+3, 4*(j+m+2), 4*j+3, 4*(j+1+(1+f(j,6*s-1))*s)+1, -1)
            addTenToPos((j+1)%s+4*s, j, 4*(j+m+2), 4*(j+m+2), 4*j+3, 4*(j+1+(1+f(j,6*s-1))*s)+2, -1)
            addTenToPos((j+1)%s+5*s, j, 4*(j+m+2), 4*(j+m+2), 4*j+3, 4*(j+1+s*f(j,6*s-1))+2, -1)
            addTenToPos(j+s, j, 4*(j+m+s+1)+1, 4*(j+m+2), 4*j+3, 4*j+3, 1)
            addTenToPos(j+2*s, j, 4*(j+m+1)+1, 4*(j+m+2), 4*j+3, 4*j+3, 1)
        }
    }

    private func createDiffWithNumber9() {
        let s = PathAlg.s
        let m = 4
        makeZeroMatrix(6*s, h: 7*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 4*(j+m)+3, 4*(j+m+1), 4*j, 4*j, 1)
            addTenToPos(j+s, j, 4*(j+m+1), 4*(j+m+1), 4*j, 4*j+1, 1)
            addTenToPos(j+2*s, j, 4*(j+m+1), 4*(j+m+1), 4*j, 4*(j+s)+1, -1)
        }

        for j in s ..< 3*s {
            addTenToPos(j, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s)+1, 1)
            addTenToPos(j+2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s)+2, 1)
        }

        for j in 3*s ..< 5*s {
            addTenToPos(j, j, 4*(j+m+1)+1, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+s)+2, 1)
            addTenToPos(j%(2*s)+5*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*(j+s)+2, 4*j+3, 1)
        }

        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 4*(j+m+1)+3, 4*(j+m+1)+3, 4*j+3, 4*(j+1), f1(j,6*s-1))
            addTenToPos(j, j, 4*(j+m+s+1)+2, 4*(j+m+1)+3, 4*j+3, 4*j+3, 1)
            addTenToPos(j+s, j, 4*(j+m+1)+2, 4*(j+m+1)+3, 4*j+3, 4*j+3, -1)
        }
    }


    private func addTenToPos(_ i: Int, _ j: Int, _ leftFrom: Int, _ leftTo: Int,
                             _ rightFrom: Int, _ rightTo: Int, _ koef: Int) {
        addTenToPosNoZero(i, j, leftFrom, leftTo, false, rightFrom, rightTo, false, koef)
    }

    private func addTenToPosNoZero(_ i: Int, _ j: Int, _ leftFrom: Int, _ leftTo: Int, _ leftNoZero: Bool,
                                   _ rightFrom: Int, _ rightTo: Int, _ rightNoZero: Bool, _ koef: Int) {
        let wL = Way(from: leftFrom, to: leftTo, noZeroLen: leftNoZero)
        let wR = Way(from: rightFrom, to: rightTo, noZeroLen : rightNoZero)
        if wL.isZero || wR.isZero { return }
        rows[i][j].addComb(Comb(tenzor: Tenzor(left: wL, right: wR), koef: Double(koef)))
    }

    private func addTenToPosLen(_ i: Int, _ j: Int, _ leftTo: Int, _ leftLen: Int,
                                _ rightFrom: Int, _ rightLen: Int, _ koef: Int) {
        let wL = Way(to: leftTo, len: leftLen)
        let wR = Way(from: rightFrom, len: rightLen)
        if wL.isZero || wR.isZero { return }
        rows[i][j].addComb(Comb(tenzor: Tenzor(left: wL, right: wR), koef: Double(koef)))
    }
}
