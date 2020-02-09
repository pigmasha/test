//
//  Created by M on 09.06.2018.
//

import Foundation

extension Diff {
    func createDiff() {
        let r = deg % PathAlg.twistPeriod
        let m = r / 2
        r % 2 == 0 ? createEvenDiff(m) : createOddDiff(m)
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
        case 6: createDiffWithNumber12()
        case 7: createDiffWithNumber14()
        case 8: createDiffWithNumber16()
        case 9: createDiffWithNumber18()
        case 10: createDiffWithNumber20()
        case 11: createDiffWithNumber22()
        case 12: createDiffWithNumber24()
        case 13: createDiffWithNumber26()
        case 14: createDiffWithNumber28()
        default: fatalError()
        }
    }

    private func createOddDiff(_ m: Int) {
        switch (m) {
        case 0: createDiffWithNumber1()
        case 1: createDiffWithNumber3()
        case 2: createDiffWithNumber5()
        case 3: createDiffWithNumber7()
        case 4: createDiffWithNumber9()
        case 5: createDiffWithNumber11()
        case 6: createDiffWithNumber13()
        case 7: createDiffWithNumber15()
        case 8: createDiffWithNumber17()
        case 9: createDiffWithNumber19()
        case 10: createDiffWithNumber21()
        case 11: createDiffWithNumber23()
        case 12: createDiffWithNumber25()
        case 13: createDiffWithNumber27()
        default: fatalError()
        }
    }

    private func createDiffWithNumber0() {
        let s = PathAlg.s
        let m = 0
        makeZeroMatrix(9*s, h: 8*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j+1, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m), 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+5, -1)
        }
        for j in 2*s ..< 5*s {
            let j_2 = j / s
            addTenToPos(j-s, j, 8*(j+m)+j_2-1, 8*(j+m)+j_2, 8*j+j_2-1, 8*j+j_2-1, 1)
            addTenToPos(j, j, 8*(j+m)+j_2, 8*(j+m)+j_2, 8*j+j_2-1, 8*j+j_2, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+7, -1)
        }
        for j in 6*s ..< 8*s {
            let j_2 = j / s
            addTenToPos(j-s, j, 8*(j+m)+j_2-1, 8*(j+m)+j_2, 8*j+j_2-1, 8*j+j_2-1, 1)
            addTenToPos(j, j, 8*(j+m)+j_2, 8*(j+m)+j_2, 8*j+j_2-1, 8*j+j_2, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+7, 8*(j+1), -1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber1() {
        let s = PathAlg.s
        let m = 0
        makeZeroMatrix(8*s, h: 9*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+7, 8*j, 8*j, -1)
            for j_1 in 1 ... 6 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m)+j_1+1+2*f(j_1, 4), 8*(j+m)+7, 8*j, 8*j+j_1, 1-2*f(j_1, 5, 6))
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ... 1 {
                addTenToPos(2*j_1*s+(j+1)%s, j, 8*(j+m+1)+1+j_1, 8*(j+m+1)+2, 8*j+1, 8*(j+1)+j_1, 1)
            }
            for j_1 in 1 ... 4 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+1+j_1+2*f(j_1,4), 8*(j+m+1)+2, 8*j+1, 8*j+j_1, 1)
            }
            addTenToPos(j+7*s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+1, 8*j+7, 1)
        }
        for j in 2*s ..< 3*s {
            for j_1 in 1 ... 3 {
                addTenToPos((j_1-f(j_1,1))*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+3, 8*j+2, 8*(j+1)+j_1-1, 1)
            }
            for j_1 in 1 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+2+j_1+2*f(j_1,3), 8*(j+m+1)+3, 8*j+2, 8*j+1+j_1, 1)
            }
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+2, 8*j+7, 1)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 1 ... 4 {
                addTenToPos((j_1-f(j_1,1))*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+4, 8*j+3, 8*(j+1)+j_1-1, 1)
            }
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m+1)+4, 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+3, 8*j+4, 1)
            addTenToPos(j+5*s, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+3, 8*j+7, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+4, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+5, 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+4, 8*j+7, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+5, 8*(j+1), 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+5, 8*(j+1)+5, 1)
            for j_1 in 1 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+5+j_1, 8*(j+m+1)+6, 8*j+5, 8*j+4+j_1, 1)
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+6, 8*(j+1), 1)
            for j_1 in 1 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+6+j_1, 8*(j+m+1)+1, 8*j+6, 8*j+5+j_1, 1)
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 1 ... 6 {
                addTenToPos((j_1-f(j_1,1)+2*f(j_1,6))*s+(j+1)%s, j, 8*(j+m+1)+j_1+2*f(j_1,5,6), 8*(j+m+2), 8*j+7, 8*(j+1)+j_1-1+2*f(j_1,6), 1)
            }
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber2() {
        let s = PathAlg.s
        let m = 1
        makeZeroMatrix(10*s, h: 8*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m-1)+7+3*j_1, 8*(j+m)+2, 8*j, 8*j+j_1, minusDeg(j_1))
            }
            addTenToPos(j+6*s, j, 8*(j+m)+1, 8*(j+m)+2, 8*j, 8*j+6, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m)+6, 8*j, 8*j, 1)
            for j_1 in 3 ... 4 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+2+j_1, 8*(j+m)+6, 8*j, 8*j+j_1+1, minusDeg(j_1))
            }
        }
        for j in 2*s ..< 4*s {
            let j_2 = j / s
            addTenToPos(j-s, j, 8*(j+m)+j_2, 8*(j+m)+j_2+1, 8*j+j_2-1, 8*j+j_2-1, 1)
            addTenToPos(j, j, 8*(j+m)+j_2+1, 8*(j+m)+j_2+1, 8*j+j_2-1, 8*j+j_2, -1)
        }

        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+4+j_1, 8*(j+m)+7, 8*j+3, 8*j+3+j_1, minusDeg(j_1))
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+4, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(3*j_1-1)*s, j, 8*(j+m)+5+3*j_1, 8*(j+m+1), 8*j+4, 8*j+4+3*j_1, minusDeg(j_1))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+6-5*j_1, 8*(j+m)+7, 8*j+5, 8*j+5+j_1, minusDeg(j_1))
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+1+7*j_1, 8*(j+m+1), 8*j+6, 8*j+6+j_1, minusDeg(j_1))
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+1, 8*j+7, 8*(j+1), -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+7, 8*(j+1)+6, -1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+7, 8*j+7, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+7, 8*(j+1)+4, -1)
            addTenToPos(j-2*s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber3() {
        let s = PathAlg.s
        let m = 1
        makeZeroMatrix(11*s, h: 10*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+2+4*j_1, 8*(j+m)+7, 8*j, 8*j, minusDeg(j_1))
            }
            for j_1 in 1 ... 3 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m)+2+j_1+2*f(j_1,3), 8*(j+m)+7, 8*j, 8*j+j_1, 1)
            }
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+5, 1)
        }
        for j in s ..< 2*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+4*j_1*s, j, 8*(j+m)+6+2*j_1, 8*(j+m+1), 8*j, 8*j+4*j_1, 1)
            }
            for j_1 in 5 ... 6 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+2+j_1, 8*(j+m+1), 8*j, 8*j+j_1, -1)
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ... 1 {
                addTenToPos(2*j_1*s+(j+1)%s, j, 8*(j+m+1)+2+j_1, 8*(j+m+1)+3, 8*j+1, 8*(j+1)+j_1, 1)
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+3+j_1+2*f(j_1,2), 8*(j+m+1)+3, 8*j+1, 8*j+1+j_1, 1)
            }
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ... 2 {
                addTenToPos((1+j_1-f(j_1,0))*s+(j+1)%s, j, 8*(j+m+1)+2+j_1, 8*(j+m+1)+4, 8*j+2, 8*(j+1)+j_1, 1)
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+4+3*j_1, 8*(j+m+1)+4, 8*j+2, 8*j+2+j_1, 1)
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+5, 8*j+3, 8*j+3+j_1, 1)
            }
            addTenToPos(j+5*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+3, 8*j+7, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+4, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+4*j_1*s, j, 8*(j+m+1)+5*j_1, 8*(j+m+1)+6, 8*j+4, 8*j+4+3*j_1, 1)
            }
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+(3*j_1-1)*s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+1, 8*j+4, 8*j+4+3*j_1, 1)
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+1, 8*j+5, 8*j+5+j_1, 1)
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+6, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+2, 8*j+6, 8*j+6+j_1, 1)
            }
        }
        for j in 9*s ..< 10*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+(2*j_1-2)*s, j, 8*(j+m+1)+5*j_1, 8*(j+m+1)+5, 8*j+6, 8*j+6+j_1, 1)
            }
        }
        for j in 10*s ..< 11*s {
            for j_1 in 1 ... 4 {
                addTenToPos((j_1-f(j_1,1))*s+(j+1)%s, j, 8*(j+m+1)+1+j_1+2*f(j_1,4), 8*(j+m+1)+7, 8*j+7, 8*(j+1)+j_1-1, 1)
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-2)*s, j, 8*(j+m+1)+1+4*j_1, 8*(j+m+1)+7, 8*j+7, 8*j+7, minusDeg(j_1))
            }
        }
    }

    private func createDiffWithNumber4() {
        let s = PathAlg.s
        let m = 2
        makeZeroMatrix(11*s, h: 11*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m-1)+7+j_1, 8*(j+m)+5, 8*j, 8*j, 1)
            }
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+3, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+6, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j+1, -1)
            for j_1 in 1 ... 2 {
                addTenToPos(j+(5+j_1)*s, j, 8*(j+m)+j_1, 8*(j+m)+3, 8*j, 8*j+4+j_1, minusDeg(j_1))
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m)+1, 8*j, 8*j, 1)
            for j_1 in 4 ... 5 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j+j_1, minusDeg(j_1+1))
            }
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+3+j_1, 8*(j+m)+4, 8*j+1, 8*j+1+j_1, minusDeg(j_1))
            }
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+4+j_1, 8*(j+m)+7, 8*j+2, 8*j+2+j_1, minusDeg(j_1))
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+3, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+5+j_1, 8*(j+m+1), 8*j+3, 8*j+3+j_1, minusDeg(j_1))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*(j+1), -1)
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+7, 1)
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7+j_1, 8*(j+m+1), 8*j+5, 8*(j+1), 1)
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+1+j_1, 8*(j+m+1), 8*j+5, 8*j+5+j_1, minusDeg(j_1))
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m)+5+2*j_1, 8*(j+m)+7, 8*j+6, 8*j+6+j_1, -1)
            }
        }
        for j in 9*s ..< 10*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+2, 8*j+7, 8*(j+1), -1)
            }
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+4, 1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+6, -1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+2, 8*j+7, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ... 1 {
                addTenToPos((4+j_1)*s+(j+1)%s, j, 8*(j+m+1)+5+j_1, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+3+j_1, minusDeg(j_1+1))
            }
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber5() {
        let s = PathAlg.s
        let m = 2
        makeZeroMatrix(13*s, h: 11*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m)+7, 8*j, 8*j+1, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+2*(2+j_1)*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+2*(j_1+1), 1-2*f(j_1,0))
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+(1+j_1-f(j_1,0))*s, j, 8*(j+m)+3+j_1+2*f(j_1,2,3), 8*(j+m+1), 8*j, 8*j+j_1, 1)
            }
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+5, 1)
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ... 1 {
                addTenToPos((2*j_1+1)*s+(j+1)%s, j, 8*(j+m+1)+3+j_1, 8*(j+m+1)+4, 8*j+1, 8*(j+1)+j_1, 1)
            }
            for j_1 in 1 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+1+3*j_1, 8*(j+m+1)+4, 8*j+1, 8*j+j_1, 1)
            }
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+2, 8*(j+1), 1)
            for j_1 in 1 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+6+j_1, 8*(j+m+1)+5, 8*j+2, 8*j+1+j_1, 1)
            }
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+3, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m+1)-j_1, 8*(j+m+1)+6, 8*j+3, 8*j+3+j_1, 1)
            }
            addTenToPos(j+6*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+3, 8*j+7, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+3, 8*(j+1), 1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+3, 8*j+3, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+4, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+3*j_1*s, j, 8*(j+m)+7+3*j_1, 8*(j+m+1)+2, 8*j+4, 8*j+4+3*j_1, minusDeg(j_1))
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m+1)-j_1+4*f(j_1,2), 8*(j+m+1)+2, 8*j+5, 8*j+5+j_1, 1)
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+5, 8*(j+1), -1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+5, 8*j+5, 1)
        }
        for j in 9*s ..< 10*s {
            for j_1 in 0 ... 1 {
                addTenToPos((j_1+1)*s+(j+1)%s, j, 8*(j+m+1)+3-2*j_1, 8*(j+m+1)+3, 8*j+6, 8*(j+1), 1)
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+7+3*j_1, 8*(j+m+1)+3, 8*j+6, 8*j+6+j_1, 1)
            }
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+2*(j_1-1)*s, j, 8*(j+m)+7*(j_1+1), 8*(j+m+1)+6, 8*j+6, 8*j+6+j_1, 1)
            }
        }
        for j in 11*s ..< 12*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+7, 8*j+7, 8*(j+1), 1)
            for j_1 in 0 ... 2 {
                addTenToPos((j_1+2)*s+(j+1)%s, j, 8*(j+m+1)+1+3*j_1, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+j_1, 1)
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-2)*s, j, 8*(j+m+1)+2+4*j_1, 8*(j+m+1)+7, 8*j+7, 8*j+7, minusDeg(j_1))
            }
        }
        for j in 12*s ..< 13*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+3, 1)
            addTenToPos(j-2*s, j, 8*(j+m+1)+6, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber6() {
        let s = PathAlg.s
        let m = 3
        makeZeroMatrix(14*s, h: 13*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m-1)+7+j_1, 8*(j+m)+2, 8*j, 8*j, 1)
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(5+j_1)*s, j, 8*(j+m)+2-f(j_1,0), 8*(j+m)+2, 8*j, 8*j+3+j_1, -1)
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+4*j_1, 8*(j+m)+4, 8*j, 8*j+j_1, minusDeg(j_1))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+2*(2+j_1)*s, j, 8*(j+m)+1+j_1, 8*(j+m)+4, 8*j, 8*j+j_1+4-f(j_1,0), -1+2*f(j_1,2))
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m)+6, 8*j, 8*j, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(1+j_1)*s, j, 8*(j+m)+5+j_1, 8*(j+m)+6, 8*j, 8*j+2+j_1, minusDeg(j_1))
            }
            addTenToPos(j+8*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j+6, -1)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+2*(j_1-1)*s, j, 8*(j+m)+5*j_1, 8*(j+m)+5, 8*j, 8*j+2*j_1, minusDeg(j_1))
            }
            addTenToPos(j+5*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+5, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*(j+1), 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-2+f(j_1,2))*s, j, 8*(j+m)+4+j_1-5*f(j_1,2), 8*(j+m)+7, 8*j+1, 8*j+1+j_1, minusDeg(j_1))
            }
        }
        for j in 5*s ..< 6*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7+j_1, 8*(j+m+1), 8*j+2, 8*(j+1), -1)
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+2*(j_1-1)*s, j, 8*(j+m)+5-4*j_1, 8*(j+m+1), 8*j+2, 8*j+2+j_1, minusDeg(j_1))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*(j+1), -1)
            addTenToPos(j-2*s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+1+j_1, 8*(j+m)+7, 8*j+3, 8*j+3+j_1, -1)
            }
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+7, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+4, 8*(j+1), -1)
            addTenToPos(j-s, j, 8*(j+m)+2, 8*(j+m+1), 8*j+4, 8*j+4, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(4+j_1)*s, j, 8*(j+m)+7+j_1, 8*(j+m+1), 8*j+4, 8*j+7, 1)
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+2+3*j_1, 8*(j+m)+7, 8*j+5, 8*j+5, minusDeg(j_1))
            }
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+7, 8*j+5, 8*j+6, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m)+6+j_1, 8*(j+m)+7, 8*j+6, 8*j+6+j_1, -1)
            }
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+2*j_1*s, j, 8*(j+m)+6+2*j_1, 8*(j+m+1), 8*j+6, 8*j+6+j_1, minusDeg(j_1))
            }
        }
        for j in 11*s ..< 12*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+7, 8*(j+1)+2, -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+5, 8*j+7, 8*j+7, 1)
            }
        }
        for j in 12*s ..< 13*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+7, 8*(j+1), 1)
            for j_1 in 2 ... 3 {
                addTenToPos(3*j_1*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+3, 8*j+7, 8*(j+1)+2*j_1, -1)
            }
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+7, 8*j+7, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+7, 8*(j+1)+3, -1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber7() {
        let s = PathAlg.s
        let m = 3
        makeZeroMatrix(16*s, h: 14*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(1+j_1-f(j_1,0))*s, j, 8*(j+m)+7-j_1-5*f(j_1,0), 8*(j+m)+7, 8*j, 8*j, -1+2*f(j_1,0))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(7+j_1-f(j_1,0))*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+4+j_1-f(j_1,0), 1-2*f(j_1,0))
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+2*j_1*s, j, 8*(j+m)+4+j_1, 8*(j+m)+7, 8*j, 8*j, minusDeg(j_1))
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(3+4*j_1)*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+1+4*j_1, 1)
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m+1), 8*j, 8*j, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(3+j_1)*s, j, 8*(j+m+1)-f(j_1,1), 8*(j+m+1), 8*j, 8*j+2+j_1, 1-2*f(j_1,0))
            }
            addTenToPos(j+8*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+6, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+1, 8*(j+1), 1)
            for j_1 in 1 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+6+j_1, 8*(j+m+1)+5, 8*j+1, 8*j+j_1, 1)
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ... 1 {
                addTenToPos((2+j_1)*s+(j+1)%s, j, 8*(j+m+1)+6-j_1, 8*(j+m+1)+6, 8*j+2, 8*(j+1), 1)
            }
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+2, 8*j+2, 1)
        }
        for j in 5*s ..< 6*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m+1)-f(j_1,1), 8*(j+m+1)+1, 8*j+2, 8*j+2+j_1, -1+2*f(j_1,0))
            }
            addTenToPos(j+8*s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+2, 8*j+7, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+3, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+2, 8*j+3, 8*j+3+j_1, 1)
            }
            addTenToPos(j+7*s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+3, 8*j+7, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+4, 8*(j+1), 1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+4, 8*j+4, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(5+j_1)*s, j, 8*(j+m+1)+3-2*j_1, 8*(j+m+1)+3, 8*j+4, 8*j+7, -1)
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+4, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(4*j_1-1)*s, j, 8*(j+m+1)+5*j_1, 8*(j+m+1)+5, 8*j+4, 8*j+4+3*j_1, minusDeg(j_1))
            }
        }
        for j in 9*s ..< 10*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1+2*f(j_1,2))*s, j, 8*(j+m)+7+4*f(j_1,2), 8*(j+m+1)+3, 8*j+5, 8*j+5+j_1, 1)
            }
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+5, 8*(j+1), 1)
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+5, 8*j+5, 1)
        }
        for j in 11*s ..< 12*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-2)*s, j, 8*(j+m)+7+j_1+4*f(j_1,2), 8*(j+m+1)+5, 8*j+6, 8*j+6+f(j_1,2), 1)
            }
        }
        for j in 12*s ..< 13*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+2+2*j_1, 8*(j+m+1)+4, 8*j+6, 8*(j+1), minusDeg(j_1+1))
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+3*(j_1-1)*s, j, 8*(j+m)+7+4*j_1, 8*(j+m+1)+4, 8*j+6, 8*j+6+j_1, 1)
            }
        }
        for j in 13*s ..< 14*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+3*(j_1-1)*s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+1, 8*j+6, 8*j+6+j_1, 1)
            }
        }
        for j in 14*s ..< 15*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+2+2*j_1, 8*(j+m+1)+7, 8*j+7, 8*(j+1), minusDeg(j_1))
            }
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+1, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-3)*s, j, 8*(j+m+1)+5-2*j_1, 8*(j+m+1)+7, 8*j+7, 8*j+7, -1+2*f(j_1,0))
            }
        }
        for j in 15*s ..< 16*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+2+2*j_1, 8*(j+m+2), 8*j+7, 8*(j+1), minusDeg(j_1+1))
            }
            for j_1 in 0 ... 1 {
                addTenToPos((4+j_1)*s+(j+1)%s, j, 8*(j+m+1)+7+j_1, 8*(j+m+2), 8*j+7, 8*(j+1)+1+j_1, 1)
            }
            addTenToPos(j-3*s, j, 8*(j+m+1)+3, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber8() {
        let s = PathAlg.s
        let m = 4
        makeZeroMatrix(16*s, h: 16*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m-1)+7+f(j_1,2)+6*f(j_1,3), 8*(j+m)+5, 8*j, 8*j+f(j_1,3), 1-2*f(j_1,1))
            }
            addTenToPos(j+8*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+4, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+6, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m)+3, 8*j, 8*j, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(5+j_1)*s, j, 8*(j+m)+2+j_1, 8*(j+m)+3, 8*j, 8*j+3+j_1, minusDeg(j_1))
            }
            addTenToPos(j+8*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j+5, -1)
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-f(j_1,0))*s, j, 8*(j+m)+4+j_1-5*f(j_1,0), 8*(j+m)+6, 8*j, 8*j+j_1, minusDeg(j_1))
            }
            addTenToPos(j+8*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j+5, -1)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+(3*j_1-1)*s, j, 8*(j+m)+j_1, 8*(j+m)+1, 8*j, 8*j+2*j_1, 1)
            }
            addTenToPos(j+10*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j+6, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+1, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+5+j_1, 8*(j+m+1), 8*j+1, 8*j+1+j_1, minusDeg(j_1))
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+1+j_1, 8*(j+m)+7, 8*j+2, 8*j+2+j_1, -1)
            }
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7+f(j_1,2), 8*(j+m+1), 8*j+3, 8*(j+1), minusDeg(j_1+1))
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+2+j_1, 8*(j+m+1), 8*j+3, 8*j+3+j_1, minusDeg(j_1))
            }
            addTenToPos(j+9*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+3, 8*j+7, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+3+2*j_1, 8*(j+m)+7, 8*j+4, 8*j+4, minusDeg(j_1))
            }
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+7, -1)
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*(j+1), minusDeg(j_1+1))
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m)+3+3*j_1, 8*(j+m)+7, 8*j+5, 8*j+5, minusDeg(j_1))
            }
            addTenToPos(j+4*s, j, 8*(j+m)+4, 8*(j+m)+7, 8*j+5, 8*j+6, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+5, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m+1), 8*j+5, 8*j+5, 1)
        }
        for j in 10*s ..< 11*s {
            for j_1 in 1 ... 4 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+6-j_1-2*f(j_1,3)+5*f(j_1,4), 8*(j+m)+7, 8*j+6, 8*j+6+f(j_1,4), -1+2*f(j_1,1))
            }
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m+1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+6, 8*j+7, -1)
        }
        for j in 12*s ..< 13*s {
            for j_1 in 0 ... 1 {
                addTenToPos((5+j_1)*s+(j+1)%s, j, 8*(j+m+1)+1+j_1, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+2+j_1, -1)
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+2, 8*j+7, 8*j+7, 1)
            }
        }
        for j in 13*s ..< 14*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+7, 8*(j+1), minusDeg(j_1))
            }
            for j_1 in 0 ... 2 {
                addTenToPos((5+2*j_1+3*f(j_1,2))*s+(j+1)%s, j, 8*(j+m+1)+2+j_1-f(j_1,0), 8*(j+m+1)+4, 8*j+7, 8*(j+1)+2*(j_1+1), -1)
            }
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+7, 8*j+7, 1)
        }
        for j in 14*s ..< 15*s {
            for j_1 in 0 ... 1 {
                addTenToPos((3+j_1)*s+(j+1)%s, j, 8*(j+m+1)+5+j_1, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+1+j_1, minusDeg(j_1))
            }
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+7, 8*(j+1)+1, -1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber9() {
        let s = PathAlg.s
        let m = 4
        makeZeroMatrix(19*s, h: 16*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+5-2*j_1+5*f(j_1,2)+2*f(j_1,3), 8*(j+m)+7, 8*j, 8*j, minusDeg(j_1))
            }
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+2, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(7+j_1+f(j_1,2))*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+4+j_1, -1+2*f(j_1,2))
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m+1), 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+3, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(7+j_1+f(j_1,2))*s, j, 8*(j+m)+7+j_1-f(j_1,2), 8*(j+m+1), 8*j, 8*j+5+f(j_1,2), 1)
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+2*j_1*s, j, 8*(j+m)+6+2*j_1, 8*(j+m+1), 8*j, 8*j+j_1, 1)
            }
            addTenToPos(j+7*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+5, 1)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ... 1 {
                addTenToPos(2*j_1*s+(j+1)%s, j, 8*(j+m+1)+5+j_1, 8*(j+m+1)+6, 8*j+1, 8*(j+1), -1)
            }
            for j_1 in 1 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m+1)+1-j_1, 8*(j+m+1)+6, 8*j+1, 8*j+j_1, 1)
            }
        }
        for j in 4*s ..< 5*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+1, 8*(j+1), -1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+1, 8*j+1, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+2, 8*(j+1), 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7+f(j_1,1), 8*(j+m+1)+2, 8*j+2, 8*j+2+j_1, 1)
            }
            addTenToPos(j+7*s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+2, 8*j+7, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+3, 8*(j+1), 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+3, 8*j+3, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m+1)-j_1, 8*(j+m+1)+3, 8*j+3, 8*j+3+j_1, 1)
            }
            addTenToPos(j+6*s, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+3, 8*j+7, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+3, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+3, 8*j+3, 1)
            addTenToPos(j+8*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+3, 8*j+7, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+4, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+4, 8*j+4, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(4+j_1)*s, j, 8*(j+m+1)+2+2*j_1, 8*(j+m+1)+4, 8*j+4, 8*j+7, minusDeg(j_1))
            }
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+4, 8*(j+1), 1)
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+4, 8*j+4, 1)
            addTenToPos(j+5*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+4, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+5, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-2)*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+5, 8*j+5, 8*j+5, 1)
            }
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+5, 8*j+5, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+2*j_1*s, j, 8*(j+m+1)+4*j_1, 8*(j+m+1)+4, 8*j+5, 8*j+6+j_1, 1)
            }
        }
        for j in 12*s ..< 13*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+5, 8*(j+1), 1)
            addTenToPos(j-3*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+5, 8*j+5, 1)
        }
        for j in 13*s ..< 14*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-3)*s, j, 8*(j+m)+7+j_1+f(j_1,2), 8*(j+m+1)+2, 8*j+6, 8*j+6+f(j_1,2), 1)
            }
        }
        for j in 14*s ..< 15*s {
            addTenToPos(j-4*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+6, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-4*s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+6, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+2, -1)
            addTenToPos(j-4*s, j, 8*(j+m+1)+2, 8*(j+m+1)+7, 8*j+7, 8*j+7, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-2)*s, j, 8*(j+m+1)+6-j_1, 8*(j+m+1)+7, 8*j+7, 8*j+7, -1)
            }
        }
        for j in 17*s ..< 18*s {
            for j_1 in 1 ... 2 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+3*j_1, 8*(j+m+1)+7, 8*j+7, 8*(j+1), minusDeg(j_1))
            }
            for j_1 in 0 ... 1 {
                addTenToPos((5+3*j_1)*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+2+3*j_1, -1)
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+2*(j_1-2)*s, j, 8*(j+m+1)+4+j_1, 8*(j+m+1)+7, 8*j+7, 8*j+7, minusDeg(j_1))
            }
        }
        for j in 18*s ..< 19*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+1, -1)
            addTenToPos(j-4*s, j, 8*(j+m+1)+6, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber10() {
        let s = PathAlg.s
        let m = 5
        makeZeroMatrix(18*s, h: 19*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m-1)+7+j_1, 8*(j+m)+2, 8*j, 8*j, 1)
            }
            addTenToPos(j+5*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j+2, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(12+j_1)*s, j, 8*(j+m)+1+j_1, 8*(j+m)+2, 8*j, 8*j+5+j_1, -1)
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m)+6, 8*j, 8*j, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m)+6*j_1, 8*(j+m)+6, 8*j, 8*j+j_1, minusDeg(j_1+1))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(8+j_1+3*f(j_1,2))*s, j, 8*(j+m)+6-f(j_1,1), 8*(j+m)+6, 8*j, 8*j+4+j_1, 1-2*f(j_1,2))
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m)+4, 8*j, 8*j, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(4+2*j_1+f(j_1,2))*s, j, 8*(j+m)+4-f(j_1,0), 8*(j+m)+4, 8*j, 8*j+3+j_1, -1+2*f(j_1,0))
            }
            addTenToPos(j+10*s, j, 8*(j+m)+1, 8*(j+m)+4, 8*j, 8*j+5, -1)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+(2*j_1-1)*s, j, 8*(j+m)+j_1, 8*(j+m)+1, 8*j, 8*j+j_1, minusDeg(j_1))
            }
            addTenToPos(j+9*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j+5, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j-3*s, j, 8*(j+m), 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+3, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+5, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+6, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*(j+1), 1)
            addTenToPos(j-2*s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+1+j_1, 8*(j+m)+7, 8*j+1, 8*j+1+j_1, -1+2*f(j_1,2))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+2, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+2+j_1, 8*(j+m+1), 8*j+2, 8*j+2+j_1, minusDeg(j_1))
            }
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m)+3, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2*j_1+5*f(j_1,2))*s, j, 8*(j+m)+5+j_1, 8*(j+m)+7, 8*j+3, 8*j+3+j_1+2*f(j_1,2), -1)
            }
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+4+2*j_1, 8*(j+m)+7, 8*j+4, 8*j+4, minusDeg(j_1))
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(8+j_1)*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+7, minusDeg(j_1+1))
            }
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+4, 8*(j+1), -1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m+1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+9*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+4, 8*j+7, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+5-j_1-2*f(j_1,2), 8*(j+m)+7, 8*j+5, 8*j+5, -1+2*f(j_1,0))
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(5+2*j_1)*s, j, 8*(j+m)+5+2*j_1, 8*(j+m)+7, 8*j+5, 8*j+6+j_1, 1)
            }
        }
        for j in 11*s ..< 12*s {
            for j_1 in 1 ... 2 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+5, 8*(j+1), minusDeg(j_1))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(4*j_1-2*f(j_1,2))*s, j, 8*(j+m)+4+j_1+f(j_1,2), 8*(j+m+1), 8*j+5, 8*j+5+j_1, -1+2*f(j_1,0))
            }
        }
        for j in 12*s ..< 13*s {
            for j_1 in 1 ... 4 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+8-j_1-5*f(j_1,1)+3*f(j_1,4), 8*(j+m)+7, 8*j+6, 8*j+6+f(j_1,4), -1+2*f(j_1,1))
            }
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m+1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+5*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+6, 8*j+7, -1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+7, 8*(j+1), 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+7, 8*(j+1)+5, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m)+7+f(j_1,2), 8*(j+m+1)+5, 8*j+7, 8*j+7, minusDeg(j_1))
            }
        }
        for j in 15*s ..< 16*s {
            for j_1 in 0 ... 1 {
                addTenToPos((5+j_1)*s+(j+1)%s, j, 8*(j+m+1)+2+j_1, 8*(j+m+1)+3, 8*j+7, 8*(j+1)+2+j_1, minusDeg(j_1))
            }
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+7, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            for j_1 in 0 ... 1 {
                addTenToPos((2+j_1)*s+(j+1)%s, j, 8*(j+m+1)+6*j_1, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+j_1, minusDeg(j_1+1))
            }
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+7, 8*(j+1)+1, 1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber11() {
        let s = PathAlg.s
        let m = 5
        makeZeroMatrix(19*s, h: 18*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1+f(j_1,2))*s, j, 8*(j+m)+2+4*j_1-9*f(j_1,2), 8*(j+m)+7, 8*j, 8*j, -1+2*f(j_1,0))
            }
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+7, 8*j, 8*j, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(5+2*j_1+3*f(j_1,2))*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+1+2*j_1+f(j_1,2), minusDeg(j_1))
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m)+2, 8*(j+m+1), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m+1), 8*j, 8*j, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(6+j_1-f(j_1,0))*s, j, 8*(j+m+1)-f(j_1,1), 8*(j+m+1), 8*j, 8*j+4-2*f(j_1,0), -1)
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(10+j_1)*s, j, 8*(j+m+1)-f(j_1,1), 8*(j+m+1), 8*j, 8*j+6-f(j_1,0), 1-2*f(j_1,0))
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+7, 8*j, 8*j, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(5+j_1+f(j_1,2))*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+3+j_1, minusDeg(j_1+1))
            }
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+1, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+2, 8*j+1, 8*j+1+j_1, 1)
            }
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+2, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m+1)-j_1, 8*(j+m+1)+3, 8*j+2, 8*j+2+j_1, 1)
            }
            addTenToPos(j+11*s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+2, 8*j+7, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+2, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+2, 8*j+2, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+4, 8*j+3, 8*(j+1), -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+3, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+3, 8*j+3, 1)
            addTenToPos(j+9*s, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+3, 8*j+7, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+3, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+3, 8*j+3+j_1, minusDeg(j_1))
            }
            addTenToPos(j+9*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+3, 8*j+7, 1)
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+5, 8*j+4, 8*j+4, 1)
            }
            addTenToPos(j+6*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+4, 8*j+7, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+4, 8*(j+1), 1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+4, 8*j+4, 1)
            addTenToPos(j+8*s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+4, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+5, 8*(j+1), 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+5, 8*(j+1), -1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+2, 8*j+5, 8*j+5, 1)
            }
        }
        for j in 11*s ..< 12*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+5, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+5, 8*j+5, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m)+7+j_1+4*f(j_1,2), 8*(j+m+1)+6, 8*j+5, 8*j+6+f(j_1,2), 1)
            }
        }
        for j in 12*s ..< 13*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+5, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+5, 8*j+5, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7+j_1+4*f(j_1,2), 8*(j+m+1)+5, 8*j+5, 8*j+6+f(j_1,2), -1)
            }
        }
        for j in 13*s ..< 14*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+7+j_1+4*f(j_1,2), 8*(j+m+1)+6, 8*j+6, 8*j+6+f(j_1,2), 1)
            }
            addTenToPos(j+3*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+6, 8*j+7, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+6, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-2*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+6, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+1, -1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1-2)*s, j, 8*(j+m+1)+5-2*j_1+5*f(j_1,2)+2*f(j_1,3), 8*(j+m+1)+7, 8*j+7, 8*j+7, minusDeg(j_1))
            }
        }
        for j in 17*s ..< 18*s {
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+2, -1)
            addTenToPos(j-2*s, j, 8*(j+m+1)+3, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
        for j in 18*s ..< 19*s {
            for j_1 in 0 ... 2 {
                addTenToPos((2+j_1)*s+(j+1)%s, j, 8*(j+m+1)+4-3*j_1+7*f(j_1,2), 8*(j+m+2), 8*j+7, 8*(j+1), 1-2*f(j_1,0))
            }
            for j_1 in 0 ... 3 {
                addTenToPos((5+j_1)*s+(j+1)%s, j, 8*(j+m+1)+7+f(j_1,1), 8*(j+m+2), 8*j+7, 8*(j+1)+1+j_1, -1+2*f(j_1,2))
            }
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+5, -1)
            addTenToPos(j-2*s, j, 8*(j+m+1)+6, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber12() {
        let s = PathAlg.s
        let m = 6
        makeZeroMatrix(18*s, h: 19*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m-1)+7+f(j_1,1)+3*f(j_1,3), 8*(j+m)+2, 8*j, 8*j+f(j_1,3), -1+2*f(j_1,0))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(9+j_1+4*f(j_1,2))*s, j, 8*(j+m)+1+f(j_1,1), 8*(j+m)+2, 8*j, 8*j+4+j_1, -1+2*f(j_1,2))
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m)+3, 8*j, 8*j, 1)
            for j_1 in 1 ... 2 {
                addTenToPos(j+(1+j_1)*s, j, 8*(j+m)+1+j_1, 8*(j+m)+3, 8*j, 8*j+j_1, minusDeg(j_1))
            }
            addTenToPos(j+13*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j+6, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m)+6, 8*j, 8*j, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(5+4*j_1)*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j+3+2*j_1, 1)
            }
            addTenToPos(j+11*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j+6, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-2*s, j, 8*(j+m), 8*(j+m)+5, 8*j, 8*j, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2+3*j_1+f(j_1,2))*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+2+2*j_1-f(j_1,2), 1)
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ... 1 {
                addTenToPos((1+j_1)*s+(j+1)%s, j, 8*(j+m+1)-j_1, 8*(j+m+1), 8*j+1, 8*(j+1), 1)
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(2*j_1-1)*s, j, 8*(j+m)+2+3*j_1, 8*(j+m+1), 8*j+1, 8*j+1+j_1, minusDeg(j_1))
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*(j+1), 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+3+2*j_1-3*f(j_1,2), 8*(j+m)+7, 8*j+2, 8*j+2+f(j_1,2), -1+2*f(j_1,0))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*(j+1), 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*(j+1), -1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+4+2*j_1-3*f(j_1,2)-9*f(j_1,3), 8*(j+m)+7, 8*j+3, 8*j+3+f(j_1,2,3), 1-2*f(j_1,1,2))
            }
            addTenToPos(j+10*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+7, 1)
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7+f(j_1,1), 8*(j+m+1), 8*j+3, 8*(j+1), 1-2*f(j_1,0))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+6-j_1-3*f(j_1,2), 8*(j+m+1), 8*j+3, 8*j+4-f(j_1,0), 1-2*f(j_1,2))
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+(9+j_1)*s, j, 8*(j+m)+7+j_1, 8*(j+m+1), 8*j+3, 8*j+7, -1)
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+4, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+5-4*j_1, 8*(j+m+1), 8*j+4, 8*j+4, minusDeg(j_1))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(8+j_1)*s, j, 8*(j+m+1)-f(j_1,0), 8*(j+m+1), 8*j+4, 8*j+7, -1+2*f(j_1,2))
            }
        }
        for j in 9*s ..< 10*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m)+2+4*j_1-5*f(j_1,2), 8*(j+m)+7, 8*j+5, 8*j+5, -1+2*f(j_1,0))
            }
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7+j_1, 8*(j+m+1), 8*j+5, 8*(j+1), minusDeg(j_1))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(1+2*j_1+3*f(j_1,2))*s, j, 8*(j+m)+6+2*f(j_1,2), 8*(j+m+1), 8*j+5, 8*j+5+j_1, minusDeg(j_1))
            }
        }
        for j in 11*s ..< 12*s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m)+1+2*j_1+5*f(j_1,0)-4*f(j_1,2), 8*(j+m)+7, 8*j+6, 8*j+6+f(j_1,3), -1+2*f(j_1,0))
            }
        }
        for j in 12*s ..< 13*s {
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m+1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+5*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+6, 8*j+7, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+1, 1)
            for j_1 in 0 ... 1 {
                addTenToPos(j+(3+j_1)*s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+2, 8*j+7, 8*j+7, 1)
            }
        }
        for j in 14*s ..< 15*s {
            for j_1 in 0 ... 1 {
                addTenToPos((j_1+1)*s+(j+1)%s, j, 8*(j+m+1)-j_1, 8*(j+m+1)+6, 8*j+7, 8*(j+1), minusDeg(j_1))
            }
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+4, 1)
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+5, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+7, 8*j+7, -1)
        }
        for j in 15*s ..< 16*s {
            for j_1 in 0 ... 1 {
                addTenToPos((4+2*j_1)*s+(j+1)%s, j, 8*(j+m+1)+3+j_1, 8*(j+m+1)+4, 8*j+7, 8*(j+1)+2+j_1, minusDeg(j_1))
            }
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+7, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7+j_1, 8*(j+m+1)+1, 8*j+7, 8*(j+1), minusDeg(j_1))
            }
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+7, 8*(j+1)+4, -1)
            addTenToPos(15*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+7, 8*(j+1)+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+7, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+7, 8*(j+1)+2, 1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber13() {
        let s = PathAlg.s
        let m = 6
        makeZeroMatrix(20*s, h: 18*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+2+j_1+2*f(j_1,2), 8*(j+m)+7, 8*j, 8*j, 1-2*f(j_1,1))
            }
            for j_1 in 0 ... 3 {
                addTenToPos(j+(5+j_1+2*f(j_1,2)+3*f(j_1,3))*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+2+j_1+f(j_1,2,3), 1)
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m+1), 8*j, 8*j, 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(3+j_1)*s, j, 8*(j+m+1)-f(j_1,1,2), 8*(j+m+1), 8*j, 8*j+1+j_1-f(j_1,3), -1+2*f(j_1,0))
            }
            addTenToPos(j+11*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+6, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m+1), 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+3, -1)
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+4, 1)
            addTenToPos(j+8*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+5, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+1, 8*(j+1), 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+1, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+1, 8*(j+1), -1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+5, 8*j+1, 8*j+2, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+4, 8*j+2, 8*(j+1), 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+2, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                 addTenToPos(j+j_1*s, j, 8*(j+m)+7+f(j_1,2), 8*(j+m+1)+4, 8*j+2, 8*j+3-f(j_1,0), 1)
            }
            addTenToPos(j+10*s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+2, 8*j+7, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+2, 8*(j+1), -1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+2, 8*j+2, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+3, 8*(j+1), -1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m+1)+5, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+3, 8*j+3, 1)
            addTenToPos(j+10*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+3, 8*j+7, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+3, 8*j+4, -1)
            addTenToPos(j+8*s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+3, 8*j+7, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+4, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+4, 8*j+7, 1)
            addTenToPos(j+7*s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+4, 8*j+7, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+4, 8*(j+1), -1)
            addTenToPos(j-2*s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+4, 8*j+7, 1)
            addTenToPos(j+7*s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+4, 8*j+7, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+5, 8*(j+1), 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-2)*s, j, 8*(j+m)+7+f(j_1,1), 8*(j+m+1)+6, 8*j+5, 8*j+5+f(j_1,2), 1)
            }
            addTenToPos(j+3*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+5, 8*j+7, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+5, 8*(j+1), 1)
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+5, 8*j+5, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j-3*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+5, 8*j+7, -1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m+1)+2, 8*j+6, 8*j+6, 1)
            addTenToPos(j-2*s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+6, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-3*s, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+6, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(j-4*s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+6, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+7, 8*j+7, 8*(j+1), 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+7, 8*j+7, 8*(j+1), 1)
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+5, 1)
            addTenToPos(j-4*s, j, 8*(j+m+1)+2, 8*(j+m+1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-3*s, j, 8*(j+m+1)+6, 8*(j+m+1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m+1)+1, 8*(j+m+1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m+1)+5, 8*(j+m+1)+7, 8*j+7, 8*j+7, -1)
        }
        for j in 18*s ..< 19*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+1, -1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+2), 8*j+7, 8*(j+1)+2, 1)
            addTenToPos(j-5*s, j, 8*(j+m+1)+2, 8*(j+m+2), 8*j+7, 8*j+7, 1)
            addTenToPos(j-3*s, j, 8*(j+m+1)+4, 8*(j+m+2), 8*j+7, 8*j+7, -1)
        }
        for j in 19*s ..< 20*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+2, -1)
            addTenToPos(j-4*s, j, 8*(j+m+1)+4, 8*(j+m+1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m+1)+5, 8*(j+m+1)+7, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffWithNumber14() {
        let s = PathAlg.s
        let m = 7
        makeZeroMatrix(18*s, h: 20*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j+1, -1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(8+j_1+2*f(j_1,2)+3*f(j_1,3))*s, j, 8*(j+m)+1+j_1-2*f(j_1,3), 8*(j+m)+3, 8*j, 8*j+3+j_1, 1-2*f(j_1,2,3))
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m)+6, 8*j, 8*j, -1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(5+j_1+2*f(j_1,2,3))*s, j, 8*(j+m)+6-f(j_1,1), 8*(j+m)+6, 8*j, 8*j+2+j_1, -1+2*f(j_1,2))
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+4, 8*j, 8*j+1, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j+2, 1)
            addTenToPos(j+13*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j+6, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j+3, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j+5, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j-3*s, j, 8*(j+m), 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+1, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+3, 1)
            addTenToPos(j+12*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+6, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*(j+1), -1)
            addTenToPos(j-2*s, j, 8*(j+m)+3, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+1, 8*j+2, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*(j+1), -1)
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+7, 8*j+2, 8*j+3, -1)
            addTenToPos(j+13*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+7, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+2, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m+1), 8*j+2, 8*j+2, 1)
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)-f(j_1,0), 8*(j+m+1), 8*j+3, 8*(j+1), 1-2*f(j_1,2))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+j_1+5*f(j_1,0), 8*(j+m+1), 8*j+3, 8*j+3+f(j_1,2), -1+2*f(j_1, 0))
            }
            addTenToPos(j+10*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+3, 8*j+7, 1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+3, 8*j+7, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+7, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*(j+1), -1)
            for j_1 in 1 ... 4 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+j_1-2+7*f(j_1,1)+3*f(j_1,2), 8*(j+m)+7, 8*j+5, 8*j+5+f(j_1,4), -1+2*f(j_1,1))
            }
            addTenToPos(j+6*s, j, 8*(j+m)+5, 8*(j+m)+7, 8*j+5, 8*j+6, 1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+7, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+5, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m+1), 8*j+5, 8*j+5, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m+1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m+1), 8*j+6, 8*j+6, -1)
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+6, 8*j+7, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+7, -1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+2, 8*j+7, 8*(j+1), -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+7, 8*(j+1), -1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+3, -1)
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+4, -1)
            addTenToPos(14*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+6, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(3+j_1)*s, j, 8*(j+m)+7+f(j_1,1), 8*(j+m+1)+2, 8*j+7, 8*j+7, -1+2*f(j_1,0))
            }
        }
        for j in 15*s ..< 16*s {
            addTenToPos(12*s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+7, 8*(j+1)+5, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+7, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+2, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+7, 8*(j+1)+1, 1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber15() {
        let s = PathAlg.s
        let m = 7
        makeZeroMatrix(19*s, h: 18*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1+f(j_1,2,3))*s, j, 8*(j+m)+3-j_1+4*f(j_1,1)+5*f(j_1,3), 8*(j+m)+7, 8*j, 8*j, -1+2*f(j_1,0))
            }
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+1, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+4, -1)
            addTenToPos(j+10*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+5, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m)+3, 8*(j+m+1), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m+1), 8*j, 8*j, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(5+j_1)*s, j, 8*(j+m+1)-f(j_1,0), 8*(j+m+1), 8*j, 8*j+2+f(j_1,2), 1)
            }
            addTenToPos(j+10*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+5, 1)
            addTenToPos(j+11*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+6, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+7, 8*j, 8*j, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m)+7-2*f(j_1,0), 8*(j+m)+7, 8*j, 8*j+j_1, minusDeg(j_1+1))
            }
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+6, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+1, 8*(j+1), 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+1, 8*(j+1), -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+1, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+1, 8*j+1, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+1, 8*j+2, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+2, 8*(j+1), -1)
            for j_1 in 1 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m+1)-f(j_1,1), 8*(j+m+1)+5, 8*j+2, 8*j+2+f(j_1,3), 1)
            }
            addTenToPos(j+12*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+2, 8*j+7, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+2, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+2, 8*j+2, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+3, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+2, 8*j+3, 8*j+4, 1)
            addTenToPos(j+7*s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+3, 8*j+7, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+3, 8*(j+1), -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+3, 8*(j+1), -1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+3, 8*j+3, 1)
            addTenToPos(j+8*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+3, 8*j+7, -1)
            addTenToPos(j+9*s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+3, 8*j+7, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+4, 8*j+4, 1)
            addTenToPos(j+6*s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+4, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ... 4 {
                addTenToPos(j+j_1*s, j, 8*(j+m+1)-f(j_1,0)-f(j_1,3)+2*f(j_1,4), 8*(j+m+1)+2, 8*j+5, 8*j+4+j_1+f(j_1,0)-f(j_1,3,4), 1-2*f(j_1,4))
            }
        }
        for j in 11*s ..< 12*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+5, 8*(j+1), 1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+5, 8*j+5, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+5, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+5, 8*j+5, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+6, 8*(j+1), -1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m+1)+j_1-2*f(j_1,1), 8*(j+m+1)+3, 8*j+6, 8*j+6+f(j_1,2,3), 1-2*f(j_1,2))
            }
        }
        for j in 14*s ..< 15*s {
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+6, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-3*s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+6, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+7, 8*j+7, 8*(j+1), 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+1, 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1-2)*s, j, 8*(j+m+1)+2+j_1+2*f(j_1,2), 8*(j+m+1)+7, 8*j+7, 8*j+7, 1-2*f(j_1,1))
            }
        }
        for j in 17*s ..< 18*s {
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+5, 1)
            addTenToPos(j-2*s, j, 8*(j+m+1)+3, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
        for j in 18*s ..< 19*s {
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+2, -1)
            addTenToPos(j-2*s, j, 8*(j+m+1)+6, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber16() {
        let s = PathAlg.s
        let m = 8
        makeZeroMatrix(18*s, h: 19*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m-1)+7+f(j_1,1), 8*(j+m)+2, 8*j, 8*j, -1+2*f(j_1,0))
            }
            addTenToPos(j+6*s, j, 8*(j+m)+1, 8*(j+m)+2, 8*j, 8*j+2, 1)
            addTenToPos(j+7*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j+3, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j+5, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m)+4, 8*j, 8*j, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(7+j_1-5*f(j_1,0))*s, j, 8*(j+m)+4-j_1, 8*(j+m)+4, 8*j, 8*j+3+j_1-2*f(j_1,0), 1-2*f(j_1,0))
            }
            addTenToPos(j+10*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j+5, -1)
            addTenToPos(j+12*s, j, 8*(j+m)+3, 8*(j+m)+4, 8*j, 8*j+6, -1)
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+(2*j_1-f(j_1,2))*s, j, 8*(j+m)+6-7*f(j_1,0)-f(j_1,2), 8*(j+m)+6, 8*j, 8*j+j_1, minusDeg(j_1))
            }
            addTenToPos(j+12*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j+6, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-2*s, j, 8*(j+m), 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+2, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+5, -1)
            addTenToPos(j+12*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+6, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*(j+1), -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+7, 8*j+1, 8*j+2, 1)
        }
        for j in 5*s ..< 6*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7+f(j_1,1), 8*(j+m+1), 8*j+1, 8*(j+1), -1+2*f(j_1,0))
            }
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m+1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m+1), 8*j+1, 8*j+2, -1)
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m)+7+f(j_1,1), 8*(j+m+1), 8*j+2, 8*(j+1), -1+2*f(j_1,0))
            }
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m+1), 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m+1), 8*j+2, 8*j+2, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m+1), 8*j+2, 8*j+3, -1)
            addTenToPos(j+12*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+2, 8*j+7, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*(j+1), 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+2+4*f(j_1,1)+f(j_1,2), 8*(j+m)+7, 8*j+3, 8*j+3+f(j_1,2), -1+2*f(j_1,0))
            }
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+7, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m+1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+9*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+4, 8*j+7, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+5, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m+1), 8*j+5, 8*j+5, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+2*(1+j_1+f(j_1,2))*s, j, 8*(j+m)+4-j_1+6*f(j_1,2), 8*(j+m+1), 8*j+5, 8*j+5+j_1, -1+2*f(j_1,2))
            }
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
        }
        for j in 11*s ..< 12*s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m)+3+j_1+2*f(j_1,1)+f(j_1,3), 8*(j+m)+7, 8*j+6, 8*j+6+f(j_1,3), 1-2*f(j_1,1,2))
            }
        }
        for j in 12*s ..< 13*s {
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m+1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+6, 8*j+7, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+7, 8*(j+1), -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+7, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos((6+j_1+f(j_1,2))*s+(j+1)%s, j, 8*(j+m+1)+1+j_1, 8*(j+m+1)+3, 8*j+7, 8*(j+1)+2+j_1, 1-2*f(j_1,2))
            }
            addTenToPos(13*s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+7, 8*(j+1)+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+7, 8*j+7, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+1, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+7, 8*j+7, -1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+7, 8*(j+1)+5, -1)
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+7, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+7, 8*(j+1)+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+7, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(12*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+7, 8*(j+1)+5, -1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber17() {
        let s = PathAlg.s
        let m = 8
        makeZeroMatrix(19*s, h: 18*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 4 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+2+2*j_1-3*f(j_1,3,4), 8*(j+m)+7, 8*j, 8*j+f(j_1,4), 1-2*f(j_1,1)-2*f(j_1,4))
            }
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+3, -1)
            addTenToPos(j+10*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+5, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+6, -1)
        }
        for j in s ..< 2*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2+j_1-2*f(j_1,0))*s, j, 8*(j+m)+6+j_1-2*f(j_1,0), 8*(j+m+1), 8*j, 8*j+1-f(j_1,0), 1)
            }
            addTenToPos(j+7*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+4, -1)
            addTenToPos(j+8*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+5, -1)
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2+j_1-2*f(j_1,0))*s, j, 8*(j+m+1)-2*f(j_1,0), 8*(j+m+1), 8*j, 8*j+j_1, 1-2*f(j_1,2))
            }
            addTenToPos(j+10*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+6, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+1, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+5, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+1, 8*j+2, -1)
            addTenToPos(j+12*s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+1, 8*j+7, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+2, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(j+11*s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+2, 8*j+7, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+2, 8*(j+1), 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+2, 8*(j+1), 1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+2, 8*j+3, -1)
            addTenToPos(j+8*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+2, 8*j+7, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+3, 8*(j+1), -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+3, 8*j+4, 1)
            addTenToPos(j+6*s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+3, 8*j+7, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+4, 8*j+4, 1)
            addTenToPos(j+7*s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+4, 8*j+7, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+4, 8*j+4, 1)
            addTenToPos(j+8*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+4, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+7+f(j_1,0), 8*(j+m+1)+3, 8*j+5, 8*j+5+f(j_1,2), 1)
            }
            addTenToPos(j+3*s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+5, 8*j+7, -1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+5, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+5, 8*j+5, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+5, 8*(j+1), 1)
            addTenToPos(j-3*s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j+5*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+5, 8*j+7, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+6, 8*j+7, -1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+4, 8*j+6, 8*(j+1), 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+6, 8*(j+1), -1)
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+6, 8*j+7, -1)
            addTenToPos(j+s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+6, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-3*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+6, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+7, 8*j+7, 8*(j+1), -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+7, 8*j+7, 8*(j+1), 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+1, 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+5, 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1-3+f(j_1,2,3))*s, j, 8*(j+m+1)+3-j_1+4*f(j_1,1)+5*f(j_1,3), 8*(j+m+1)+7, 8*j+7, 8*j+7, -1+2*f(j_1,0))
            }
        }
        for j in 17*s ..< 18*s {
            for j_1 in 0 ... 3 {
                addTenToPos((j_1+2*f(j_1,2,3))*s+(j+1)%s, j, 8*(j+m+1)+2+2*j_1+f(j_1,2), 8*(j+m+2), 8*j+7, 8*(j+1)+f(j_1,2,3), 1-2*f(j_1,0))
            }
            addTenToPos(j-4*s, j, 8*(j+m+1)+3, 8*(j+m+2), 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m+1)+4, 8*(j+m+2), 8*j+7, 8*j+7, -1)
        }
        for j in 18*s ..< 19*s {
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+5, 1)
            addTenToPos(j-3*s, j, 8*(j+m+1)+4, 8*(j+m+1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m+1)+5, 8*(j+m+1)+7, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffWithNumber18() {
        let s = PathAlg.s
        let m = 9
        makeZeroMatrix(16*s, h: 19*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m)+3, 8*j, 8*j, 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1+3-2*f(j_1,0)+f(j_1,3))*s, j, 8*(j+m)+j_1, 8*(j+m)+3, 8*j, 8*j+j_1, 1-2*f(j_1,1,2))
            }
            addTenToPos(j+10*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j+5, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m)+6, 8*j, 8*j, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1+1+2*f(j_1,2))*s, j, 8*(j+m)+4+j_1-4*f(j_1,0), 8*(j+m)+6, 8*j, 8*j+j_1, minusDeg(j_1+1))
            }
            addTenToPos(j+10*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j+5, 1)
            addTenToPos(j+12*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j+6, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j+1, -1)
            addTenToPos(j+13*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j+6, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-2*s, j, 8*(j+m), 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+1, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+4, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+5, 1)
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)-f(j_1,0), 8*(j+m+1), 8*j+1, 8*(j+1), -1+2*f(j_1,2))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+j_1+5*f(j_1,0), 8*(j+m+1), 8*j+1, 8*j+1+f(j_1,2), -1+2*f(j_1,0))
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+2*j_1*s, j, 8*(j+m)+2+j_1+f(j_1,2), 8*(j+m)+7, 8*j+2, 8*j+2+j_1, minusDeg(j_1))
            }
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+7, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+3, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m+1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m+1), 8*j+3, 8*j+4, -1)
            addTenToPos(j+11*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+3, 8*j+7, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+7, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*(j+1), 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m)+3+j_1+2*f(j_1,1), 8*(j+m)+7, 8*j+5, 8*j+5, -1+2*f(j_1,0))
            }
            addTenToPos(j+5*s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+5, 8*j+6, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+1, 8*(j+m)+7, 8*j+5, 8*j+6, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+7, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+5, 8*(j+1), -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m+1), 8*j+5, 8*j+5, 1)
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(3+j_1)*s, j, 8*(j+m)+6-2*j_1-f(j_1,2), 8*(j+m)+7, 8*j+6, 8*j+6, -1+2*f(j_1,0))
            }
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+7, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+7, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m+1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+6, 8*j+7, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+1, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+2, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(4+j_1)*s, j, 8*(j+m)+7+f(j_1,1), 8*(j+m+1)+2, 8*j+7, 8*j+7, -1+2*f(j_1,0))
            }
        }
        for j in 13*s ..< 14*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+7, 8*(j+1), 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+7, 8*(j+1)+3, 1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+7, 8*(j+1)+4, -1)
            addTenToPos(14*s+(j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+7, 8*(j+1)+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+7, 8*j+7, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+5, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+7, 8*(j+1)+1, -1)
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber19() {
        let s = PathAlg.s
        let m = 9
        makeZeroMatrix(16*s, h: 16*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+3-j_1+4*f(j_1,1)+5*f(j_1,3), 8*(j+m)+7, 8*j, 8*j, -1+2*f(j_1,0))
            }
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+2, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+5, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m)+3, 8*(j+m+1), 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m+1), 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+1, -1)
            for j_1 in 0 ... 5 {
                addTenToPos(j+(5+j_1)*s, j, 8*(j+m+1)-f(j_1,1,2)-f(j_1,4), 8*(j+m+1), 8*j, 8*j+3+j_1-f(j_1,3,4)-2*f(j_1,5), -1)
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+1, 8*(j+1), -1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m+1)-f(j_1,1)-f(j_1,3), 8*(j+m+1)+2, 8*j+1, 8*j+1+j_1, 1)
            }
            addTenToPos(j+10*s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+1, 8*j+7, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+1, 8*(j+1), 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+1, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+2, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1+1)*s, j, 8*(j+m)+7+f(j_1,1), 8*(j+m+1)+3, 8*j+2, 8*j+2+j_1, 1)
            }
            addTenToPos(j+8*s, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+2, 8*j+7, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+3, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+3, 8*j+4, 1)
            addTenToPos(j+7*s, j, 8*(j+m+1)+2, 8*(j+m+1)+4, 8*j+3, 8*j+7, -1)
            addTenToPos(j+8*s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+3, 8*j+7, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+3, 8*(j+1), -1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+3, 8*j+3, 1)
            addTenToPos(j+9*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+3, 8*j+7, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+4, 8*j+4, 1)
            addTenToPos(j+7*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+4, 8*j+7, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+5, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7+f(j_1,1), 8*(j+m+1)+6, 8*j+5, 8*j+5+f(j_1,2), 1)
            }
            addTenToPos(j+6*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+5, 8*j+7, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+5, 8*j+5, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+5, 8*j+7, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+5, 8*(j+1), 1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+5, 8*j+5, 1)
        }
        for j in 11*s ..< 12*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+7+j_1+f(j_1,2), 8*(j+m+1)+2, 8*j+6, 8*j+6+f(j_1,2), 1)
            }
        }
        for j in 12*s ..< 13*s {
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+6, 8*j+7, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+7, 8*j+7, 8*(j+1), 1)
            for j_1 in 0 ... 3 {
                addTenToPos((3+2*j_1-f(j_1,0)+f(j_1,3))*s+(j+1)%s, j, 8*(j+m+1)+7-6*f(j_1,0), 8*(j+m+1)+7, 8*j+7, 8*(j+1)+2*j_1, -1+2*f(j_1,0))
            }
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m+1)+2*(j_1+1)-3*f(j_1,3), 8*(j+m+1)+7, 8*j+7, 8*j+7, 1-2*f(j_1,1))
            }
        }
        for j in 14*s ..< 15*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+2), 8*j+7, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos((3+j_1-f(j_1,0))*s+(j+1)%s, j, 8*(j+m+2)+1-j_1-8*f(j_1,0), 8*(j+m+2), 8*j+7, 8*(j+1)+j_1, 1-2*f(j_1,0))
            }
            for j_1 in 0 ... 2 {
                addTenToPos((8+j_1-f(j_1,0))*s+(j+1)%s, j, 8*(j+m+1)+7+f(j_1,1), 8*(j+m+2), 8*j+7, 8*(j+1)+4+j_1, 1)
            }
            addTenToPos(j-s, j, 8*(j+m+1)+4, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+5, 1)
            addTenToPos(j-s, j, 8*(j+m+1)+6, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber20() {
        let s = PathAlg.s
        let m = 10
        makeZeroMatrix(14*s, h: 16*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m-1)+7+j_1+f(j_1,2), 8*(j+m)+2, 8*j, 8*j+f(j_1,2), -1+2*f(j_1,0))
            }
            addTenToPos(j+10*s, j, 8*(j+m)+1, 8*(j+m)+2, 8*j, 8*j+5, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j+6, -1)
        }
        for j in s ..< 2*s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1+f(j_1,2,3))*s, j, 8*(j+m)+j_1+1-f(j_1,0), 8*(j+m)+4, 8*j, 8*j+j_1, 1-2*f(j_1,2))
            }
            addTenToPos(j+8*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j+5, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+1, 8*(j+m)+4, 8*j, 8*j+5, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+2, 8*(j+m)+4, 8*j, 8*j+6, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j+1, 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(4+j_1+3*f(j_1,3))*s, j, 8*(j+m)+5+f(j_1,1,2), 8*(j+m)+6, 8*j, 8*j+3+j_1, 1)
            }
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m)+9-3*j_1-7*f(j_1,0), 8*(j+m)+7, 8*j+1, 8*j+1+f(j_1,2), -1+2*f(j_1,0))
            }
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+2, 8*(j+1), -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+2, 8*(j+1), 1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m+1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m+1), 8*j+2, 8*j+3, -1)
            addTenToPos(j+10*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+2, 8*j+7, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*(j+1), 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1+5*f(j_1,3))*s, j, 8*(j+m)+4+j_1, 8*(j+m)+7, 8*j+3, 8*j+3+f(j_1,2)+4*f(j_1,3), 1-2*f(j_1,1,2))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m+1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+9*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+4, 8*j+7, -1)
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(1+j_1)*s, j, 8*(j+m)+6-2*j_1-f(j_1,2), 8*(j+m)+7, 8*j+5, 8*j+5, -1+2*f(j_1,0))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+(4+j_1)*s, j, 8*(j+m)+3+2*j_1-f(j_1,0), 8*(j+m)+7, 8*j+5, 8*j+6+f(j_1,2), 1-2*f(j_1,0))
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+5, 8*(j+1), -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+5, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m+1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+5, 8*j+7, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m+1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m+1), 8*j+6, 8*j+6, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(4+j_1)*s, j, 8*(j+m+1)-f(j_1,0), 8*(j+m+1), 8*j+6, 8*j+7, -1+2*f(j_1,2))
            }
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+7, 8*(j+1)+1, -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+7, 8*(j+1)+2, 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+3, 8*j+7, 8*(j+1)+5, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+7, 8*j+7, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+7, 8*(j+1), 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+4, 1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+7, 8*j+7, -1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+7, 8*(j+1)+5, -1)
            addTenToPos(j+3*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+7, 8*j+7, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+5, 8*j+7, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos((6*j_1+f(j_1,0))*s+(j+1)%s, j, 8*(j+m+1)+5-5*f(j_1,0), 8*(j+m+1)+5, 8*j+7, 8*(j+1)+3*j_1, 1)
            }
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber21() {
        let s = PathAlg.s
        let m = 10
        makeZeroMatrix(13*s, h: 14*s)

        for j in 0 ..< s {
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m+1), 8*j, 8*j, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+4*j_1*s, j, 8*(j+m+1)-6*f(j_1,0), 8*(j+m+1), 8*j, 8*j+2*j_1+f(j_1,2), 1-2*f(j_1,2))
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j, 8*j, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+2*(j_1+1)*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+1+2*j_1, -1+2*f(j_1,2))
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+1, 8*(j+1), 1)
            for j_1 in 1 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+7+f(j_1,2), 8*(j+m+1)+3, 8*j+1, 8*j+j_1, 1)
            }
            addTenToPos(j+8*s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+1, 8*j+7, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+2, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+2, 8*j+3, 1)
            addTenToPos(j+7*s, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+2, 8*j+7, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+2, 8*j+2, 1)
            addTenToPos(j+9*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+2, 8*j+7, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+3, 8*j+4, 1)
            addTenToPos(j+6*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+3, 8*j+7, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+4, 8*j+4, 1)
            addTenToPos(j+6*s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+4, 8*j+7, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+5, 8*(j+1), 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1+2*f(j_1,3))*s, j, 8*(j+m)+7+j_1-f(j_1,2,3), 8*(j+m+1)+2, 8*j+5, 8*j+4+j_1+f(j_1,0), 1-2*f(j_1,3))
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j+5*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+5, 8*j+7, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+6, 8*j+7, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1)+1, 8*(j+m+1)+3, 8*j+6, 8*j+7, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+6, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2*j_1-1)*s, j, 8*(j+m+1)+7-j_1-7*f(j_1,0), 8*(j+m+1)+6, 8*j+6, 8*j+7-f(j_1,0), 1)
            }
        }
        for j in 11*s ..< 12*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+7, 8*j+7, 8*(j+1), 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+1, 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m+1)+3-j_1+4*f(j_1,1)+5*f(j_1,3), 8*(j+m+1)+7, 8*j+7, 8*j+7, -1+2*f(j_1,0))
            }
        }
        for j in 12*s ..< 13*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+2), 8*j+7, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos((4+j_1)*s+(j+1)%s, j, 8*(j+m+2)-f(j_1,1), 8*(j+m+2), 8*j+7, 8*(j+1)+2+j_1, -1)
            }
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+6, -1)
            addTenToPos(j-2*s, j, 8*(j+m+1)+3, 8*(j+m+2), 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+5, 8*(j+m+2), 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffWithNumber22() {
        let s = PathAlg.s
        let m = 11
        makeZeroMatrix(11*s, h: 13*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)-j_1+5*f(j_1,2), 8*(j+m)+3, 8*j, 8*j+f(j_1,2), -1+2*f(j_1,0))
            }
            addTenToPos(j+7*s, j, 8*(j+m)+2, 8*(j+m)+3, 8*j, 8*j+5, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j+6, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m), 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+2, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j+5, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+1, 8*(j+1), -1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m+1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m+1), 8*j+1, 8*j+2, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*(j+1), 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+4+j_1-6*f(j_1,3), 8*(j+m)+7, 8*j+2, 8*j+1+j_1+f(j_1,0), 1-2*f(j_1,1,2))
            }
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+7, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+3, 8*(j+1), 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+3, 8*(j+1), -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m+1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m+1), 8*j+3, 8*j+4, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+3, 8*j+7, -1)
            addTenToPos(j+8*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+3, 8*j+7, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+4, 8*(j+1), -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+1, 8*j+4, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m+1)+1, 8*j+4, 8*j+4, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+4, 8*(j+1)+4, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m+1)+1, 8*j+4, 8*j+7, 1)
            addTenToPos(j+7*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+4, 8*j+7, -1)
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ... 3 {
                addTenToPos(j+(j_1+1+2*f(j_1,3))*s, j, 8*(j+m)+2+3*j_1-5*f(j_1,2)-3*f(j_1,3), 8*(j+m+1), 8*j+5, 8*j+4+j_1+f(j_1,0), 1-2*f(j_1,1,2))
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(2+j_1)*s, j, 8*(j+m)+5+j_1-2*f(j_1,0), 8*(j+m)+7, 8*j+6, 8*j+6+f(j_1,2), -1+2*f(j_1,0))
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+7, 8*(j+1), -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+2, 8*j+7, 8*(j+1), 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+4, -1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+7, 8*(j+1)+5, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m+1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+7, 8*j+7, -1)
        }
        for j in 9*s ..< 10*s {
            for j_1 in 0 ... 3 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+1+j_1-f(j_1,0)-3*f(j_1,1), 8*(j+m+1)+4, 8*j+7, 8*(j+1)-1+j_1+f(j_1,0), 1-2*f(j_1,1,2))
            }
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+4, 8*j+7, 8*(j+1)+4, 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+4, 8*j+7, 8*(j+1)+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+7, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+2, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+3, 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber23() {
        let s = PathAlg.s
        let m = 11
        makeZeroMatrix(11*s, h: 11*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 4 {
                addTenToPos(j+j_1*s, j, 8*(j+m+1)-5*f(j_1,0)-3*f(j_1,1)-f(j_1,3), 8*(j+m+1), 8*j, 8*j-1+j_1+f(j_1,0), 1-2*f(j_1,1))
            }
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+5, -1)
        }
        for j in s ..< 2*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+1, 8*(j+1), 1)
            for j_1 in 1 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m+1)-f(j_1,2), 8*(j+m+1)+4, 8*j+1, 8*j+j_1, 1)
            }
            addTenToPos(j+8*s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+1, 8*j+7, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+1, 8*(j+1), 1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+1, 8*j+1, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+2, 8*(j+1), -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+2, 8*j+3, 1)
            addTenToPos(j+7*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+2, 8*j+7, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+3, 8*j+4, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+4, 8*j+7, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+5, 8*(j+1), 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m+1)+j_1-2*f(j_1,1), 8*(j+m+1)+3, 8*j+5, 8*j+5+j_1, 1)
            }
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+5, 8*j+7, -1)
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+(j_1-1)*s, j, 8*(j+m+1)+2*j_1-f(j_1,0), 8*(j+m+1)+4, 8*j+6, 8*j+7-f(j_1,0), 1)
            }
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+1, 1)
            addTenToPos(j-s, j, 8*(j+m+1)+2, 8*(j+m+2), 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m+1)+4, 8*(j+m+2), 8*j+7, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+3, 8*(j+m+1)+7, 8*j+7, 8*(j+1), -1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+2, -1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+6, -1)
            addTenToPos(j-s, j, 8*(j+m+1)+4, 8*(j+m+1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m+1)+6, 8*(j+m+1)+7, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffWithNumber24() {
        let s = PathAlg.s
        let m = 12
        makeZeroMatrix(10*s, h: 11*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j+1, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+3, 8*(j+m)+4, 8*j, 8*j+5, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j+6, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m), 8*(j+m)+6, 8*j, 8*j, 1)
            for j_1 in 1 ... 3 {
                addTenToPos(j+(j_1+3*f(j_1,3))*s, j, 8*(j+m)+6-f(j_1,1), 8*(j+m)+6, 8*j, 8*j+j_1+2*f(j_1,3), -1+2*f(j_1,3))
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+7, 8*j+1, 8*j+2, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+7, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j+2, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+j_1+6*f(j_1,0), 8*(j+m+1), 8*j+2, 8*j+2+j_1, minusDeg(j_1))
            }
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+2, 8*j+7, 1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+2, 8*j+7, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+3, 8*(j+1), 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m+1)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+3, 8*(j+1)+3, -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m+1)+1, 8*j+3, 8*j+4, -1)
            addTenToPos(j+5*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+3, 8*j+7, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m+1)+1, 8*j+3, 8*j+7, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+4, 8*(j+1), -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+4, 8*(j+1)+3, 1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m+1)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+4, 8*(j+1)+4, -1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+4, 8*j+7, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m+1)+2, 8*j+4, 8*j+7, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+(1+j_1+f(j_1,2))*s, j, 8*(j+m)+6-2*j_1+5*f(j_1,2), 8*(j+m)+7, 8*j+5, 8*j+5+j_1, -1+2*f(j_1,2))
            }
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m+1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+6, 8*j+7, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+7, 8*(j+1), -1)
            for j_1 in 0 ... 2 {
                addTenToPos((4+j_1)*s+(j+1)%s, j, 8*(j+m+1)+1+j_1, 8*(j+m+1)+3, 8*j+7, 8*(j+1)+3+j_1, -1+2*f(j_1,0))
            }
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+7, 8*j+7, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+7, 8*(j+1)+1, -1)
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber25() {
        let s = PathAlg.s
        let m = 12
        makeZeroMatrix(8*s, h: 10*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+5+j_1-f(j_1,0), 8*(j+m)+7, 8*j, 8*j+f(j_1,2), minusDeg(j_1))
            }
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j+5, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+1, 8*(j+1), 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m+1)+6, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+1, 8*j+2, 1)
            addTenToPos(j+8*s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+1, 8*j+7, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+2, 8*j+3, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j+s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+3, 8*j+4, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j+s, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+4, 8*j+7, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+5, 8*(j+1), 1)
            for j_1 in 1 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+6+j_1+2*f(j_1,3), 8*(j+m+1)+4, 8*j+5, 8*j+4+j_1, 1)
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+6, 8*j+7, 1)
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ... 2 {
                addTenToPos((1+j_1-f(j_1,0))*s+(j+1)%s, j, 8*(j+m+1)+6+j_1-2*f(j_1,0), 8*(j+m+2), 8*j+7, 8*(j+1)+j_1, 1)
            }
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m+2), 8*(j+m+2), 8*j+7, 8*(j+1)+6, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+3, 8*(j+m+2), 8*j+7, 8*j+7, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1)+5, 8*(j+m+2), 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffWithNumber26() {
        let s = PathAlg.s
        let m = 13
        makeZeroMatrix(9*s, h: 8*s)

        for j in 0 ..< s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*(j+1), -1)
            for j_1 in 0 ... 6 {
                addTenToPos(j+j_1*s, j, 8*(j+m-1)+7+j_1+6*f(j_1,1), 8*(j+m)+7, 8*j, 8*j+j_1, minusDeg(j_1)+2*f(j_1,5)-2*f(j_1,6))
            }
        }
        for j in s ..< 2*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1), 8*j+1, 8*(j+1), 1)
            for j_1 in 0 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+j_1+6*f(j_1,0), 8*(j+m+1), 8*j+1, 8*j+1+j_1, minusDeg(j_1))
            }
            addTenToPos(j+6*s, j, 8*(j+m+1), 8*(j+m+1), 8*j+1, 8*j+7, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+1, 8*j+2, 8*(j+1), -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+2, 8*(j+1)+2, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+1+j_1, 8*(j+m+1)+1, 8*j+2, 8*j+2+j_1, minusDeg(j_1))
            }
            addTenToPos(j+5*s, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+2, 8*j+7, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+2, 8*j+3, 8*(j+1), 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+3, 8*(j+1)+2, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+3, 8*(j+1)+3, -1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m+1)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m+1)+2, 8*j+3, 8*j+4, -1)
            addTenToPos(j+4*s, j, 8*(j+m+1), 8*(j+m+1)+2, 8*j+3, 8*j+7, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+4, 8*(j+1), -1)
            for j_1 in 1 ... 3 {
                addTenToPos((1+j_1)*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+3, 8*j+4, 8*(j+1)+1+j_1, minusDeg(j_1))
            }
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m+1)+3, 8*j+4, 8*j+4, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1), 8*(j+m+1)+3, 8*j+4, 8*j+7, 1)
        }
        for j in 5*s ..< 6*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+4+j_1+2*f(j_1,2), 8*(j+m+1), 8*j+5, 8*j+5+j_1, -1+2*f(j_1,0))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m+1)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+6, 8*(j+1)+6, -1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+6, 8*j+7, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+7, 8*(j+1), -1)
            for j_1 in 1 ... 4 {
                addTenToPos((1+j_1)*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+4, 8*j+7, 8*(j+1)+1+j_1, -1+2*f(j_1,2))
            }
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+4, 8*j+7, 8*j+7, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+1, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+7, 8*(j+1)+6, -1)
            addTenToPos(j-s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffWithNumber27() {
        let s = PathAlg.s
        let m = 13
        makeZeroMatrix(8*s, h: 9*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m+1), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+1, 1)
            addTenToPos(j+5*s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*j+5, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+1, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+1, 8*(j+m+1)+1, 8*j+1, 8*j+2, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m+1)+1, 8*(j+m+1)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+2, 8*(j+m+1)+2, 8*j+2, 8*j+3, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j, j, 8*(j+m+1)+2, 8*(j+m+1)+3, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+3, 8*(j+m+1)+3, 8*j+3, 8*j+4, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j, j, 8*(j+m+1)+3, 8*(j+m+1)+4, 8*j+4, 8*j+4, 1)
            addTenToPos(j+3*s, j, 8*(j+m+1)+4, 8*(j+m+1)+4, 8*j+4, 8*j+7, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+5, 8*j+6, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j, j, 8*(j+m+1)+5, 8*(j+m+1)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m+1)+6, 8*(j+m+1)+6, 8*j+6, 8*j+7, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1)+7, 8*(j+m+1)+7, 8*j+7, 8*(j+1), 1)
            addTenToPos(j, j, 8*(j+m+1)+4, 8*(j+m+1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m+1)+6, 8*(j+m+1)+7, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffWithNumber28() {
        let s = PathAlg.s
        let m = 14
        makeZeroMatrix(8*s, h: 8*s)

        for j in 0 ..< s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1), 8*j, 8*(j+1), -1)
            for j_1 in 0 ... 7 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+j_1, 8*(j+m+1), 8*j, 8*j+j_1, minusDeg(j_1)+2*f(j_1,5)-2*f(j_1,6)+2*f(j_1,7))
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ... 1 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+1, 8*j+1, 8*(j+1)+j_1, minusDeg(j_1))
            }
            for j_1 in 0 ... 3 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+1+j_1, 8*(j+m+1)+1, 8*j+1, 8*j+1+j_1, minusDeg(j_1))
            }
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m+1)+1, 8*j+1, 8*j+7, -1)
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ... 2 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+2, 8*j+2, 8*(j+1)+j_1, minusDeg(j_1+1))
            }
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+2+j_1, 8*(j+m+1)+2, 8*j+2, 8*j+2+j_1, minusDeg(j_1))
            }
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m+1)+2, 8*j+2, 8*j+7, 1)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ... 3 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+3, 8*j+3, 8*(j+1)+j_1, minusDeg(j_1))
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+3+j_1, 8*(j+m+1)+3, 8*j+3, 8*j+3+j_1, minusDeg(j_1))
            }
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m+1)+3, 8*j+3, 8*j+7, -1)
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ... 4 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+4, 8*j+4, 8*(j+1)+j_1, minusDeg(j_1+1))
            }
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m+1)+4, 8*j+4, 8*j+4, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m+1)+4, 8*j+4, 8*j+7, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+5, 8*j+5, 8*(j+1), -1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m+1)+5, 8*(j+m+1)+5, 8*j+5, 8*(j+1)+5, -1)
            for j_1 in 0 ... 2 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+5+j_1, 8*(j+m+1)+5, 8*j+5, 8*j+5+j_1, minusDeg(j_1))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m+1), 8*(j+m+1)+6, 8*j+6, 8*(j+1), 1)
            for j_1 in 0 ... 1 {
                addTenToPos((5+j_1)*s+(j+1)%s, j, 8*(j+m+1)+5+j_1, 8*(j+m+1)+6, 8*j+6, 8*(j+1)+5+j_1, minusDeg(j_1))
            }
            for j_1 in 0 ... 1 {
                addTenToPos(j+j_1*s, j, 8*(j+m)+6+j_1, 8*(j+m+1)+6, 8*j+6, 8*j+6+j_1, minusDeg(j_1))
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ... 7 {
                addTenToPos(j_1*s+(j+1)%s, j, 8*(j+m+1)+j_1, 8*(j+m+1)+7, 8*j+7, 8*(j+1)+j_1, minusDeg(j_1+1)-2*f(j_1,5)+2*f(j_1,6)-2*f(j_1,7))
            }
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m+1)+7, 8*j+7, 8*j+7, 1)
        }
    }

    private func addTenToPos(_ i: Int, _ j: Int, _ leftFrom: Int, _ leftTo: Int,
                             _ rightFrom: Int, _ rightTo: Int, _ koef: Int) {
        addTenToPosNoZero(i, j, leftFrom, leftTo, leftFrom != leftTo, rightFrom, rightTo, rightFrom != rightTo, koef)
    }

    private func addTenToPosNoZero(_ i: Int, _ j: Int, _ leftFrom: Int, _ leftTo: Int, _ leftNoZero: Bool,
                                   _ rightFrom: Int, _ rightTo: Int, _ rightNoZero: Bool, _ koef: Int) {
        let wL = Way(from: leftFrom, to: leftTo, noZeroLen: leftNoZero)
        let wR = Way(from: rightFrom, to: rightTo, noZeroLen : rightNoZero)
        if wL.isZero || wR.isZero { fatalError("[\(i), \(j)]: zero way \(wL.str) \(wR.str)") }
        rows[i][j].addComb(Comb(tenzor: Tenzor(left: wL, right: wR), koef: Double(koef)))
    }
}
