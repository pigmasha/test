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
        case 6: createDiffWithNumber12()
        case 7: createDiffWithNumber14()
        case 8: createDiffWithNumber16()
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
        case 5: createDiffWithNumber11()
        case 6: createDiffWithNumber13()
        case 7: createDiffWithNumber15()
        default: break
        }
    }

    private func createDiffWithNumber0() {
        let s = PathAlg.s
        let m = 0
        makeZeroMatrix(8*s, h: 7*s)

        for j in 0 ..< 2*s {
            let j_2 = j / s
            addTenToPos(j%s, j, 7*(j+m), 7*(j+m)+1+3*f(j_2,1), 7*j, 7*j, 1)
            addTenToPos(j+s+2*s*f(j_2,1), j, 7*(j+m)+1+3*f(j_2,1), 7*(j+m)+1+3*f(j_2,1), 7*j, 7*j+1+3*f(j_2,1), -1)
        }
        for j in 2*s ..< 5*s {
            let j_2 = j / s
            addTenToPos(j-s, j, 7*(j+m)+j_2-1, 7*(j+m)+j_2+2*f(j_2,4), 7*j+j_2-1, 7*j+j_2-1, 1)
            addTenToPos(j+2*s*f(j_2,4), j, 7*(j+m)+j_2+2*f(j_2,4), 7*(j+m)+j_2+2*f(j_2,4), 7*j+j_2-1, 7*j+j_2+2*f(j_2,4), -1)
        }
        for j in 5*s ..< 7*s {
            let j_2 = j / s
            addTenToPos(j-s, j, 7*(j+m)+j_2-1, 7*(j+m)+j_2, 7*j+j_2-1, 7*j+j_2-1, 1)
            addTenToPos(j, j, 7*(j+m)+j_2, 7*(j+m)+j_2, 7*j+j_2-1, 7*j+j_2, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1), 7*(j+m+1), 7*j+6, 7*(j+1), -1)
            addTenToPos(j-s, j, 7*(j+m)+6, 7*(j+m+1), 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber1() {
        let s = PathAlg.s
        let m = 0
        makeZeroMatrix(7*s, h: 8*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(j_1+1-f(j_1,0)), j, 7*(j+m)+1+j_1+2*f(j_1,3), 7*(j+m+1)-1, 7*j, 7*j+j_1, 1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+4-3*f(j_1,0)), j, 7*(j+m+1)-3+j_1, 7*(j+m+1)-1, 7*j, 7*j+j_1+3*(1-f(j_1,0)), -1)
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+2*s*f(j_1,1), j, 7*(j+m+1)+1+j_1, 7*(j+m+1)+2, 7*j+1, 7*(j+1)+j_1, 1)
            }
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(1+j_1+2*f(j_1,3)), j, 7*(j+m)+2+j_1+2*f(j_1,2,3), 7*(j+m+1)+2, 7*j+1, 7*j+1+j_1+2*f(j_1,3), 1)
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 3 {
                addTenToPos((j+1)%s+s*(j_1+1-f(j_1,0)), j, 7*(j+m+1)+1+j_1, 7*(j+m+1)+3, 7*j+2, 7*(j+1)+j_1, 1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(1+j_1+2*f(j_1,2)), j, 7*(j+m)+3+j_1+2*f(j_1,1,2), 7*(j+m+1)+3, 7*j+2, 7*j+2+j_1+2*f(j_1,2), 1)
            }
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+3, 7*(j+1), 1)
            addTenToPos(j+s, j, 7*(j+m)+6, 7*(j+m+1)+4, 7*j+3, 7*j+3, 1)
            addTenToPos(j+4*s, j, 7*(j+m+1), 7*(j+m+1)+4, 7*j+3, 7*j+6, 1)
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*(1+4*f(j_1,1)), j, 7*(j+m+1)+4+j_1, 7*(j+m+1)+5, 7*j+4, 7*(j+1)+4*f(j_1,1), 1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+5+j_1, 7*(j+m+1)+5, 7*j+4, 7*j+4+j_1, 1)
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+1, 7*(j+m+1)+1, 7*j+5, 7*(j+1), 1)
            addTenToPos(j+s, j, 7*(j+m)+6, 7*(j+m+1)+1, 7*j+5, 7*j+5, 1)
            addTenToPos(j+2*s, j, 7*(j+m+1), 7*(j+m+1)+1, 7*j+5, 7*j+6, 1)
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 5 {
                addTenToPos((j+1)%s+s*(j_1+f(j_1,1,4)+2*f(j_1,4)), j, 7*(j+m+1)+1+j_1+2*f(j_1,3,4), 7*(j+m+2), 7*j+6, 7*(j+1)+j_1+2*f(j_1,4), 1)
            }
            addTenToPos(j+s, j, 7*(j+m+1), 7*(j+m+2), 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber2() {
        let s = PathAlg.s
        let m = 1
        makeZeroMatrix(9*s, h: 7*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 7*(j+m-1)+6, 7*(j+m)+2, 7*j, 7*j, 1)
            addTenToPos(j+s, j, 7*(j+m)+2, 7*(j+m)+2, 7*j, 7*j+1, -1)
            addTenToPos(j+5*s, j, 7*(j+m)+1, 7*(j+m)+2, 7*j, 7*j+5, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 7*(j+m-1)+6, 7*(j+m)+5, 7*j, 7*j, 1)
            addTenToPos(j+2*s, j, 7*(j+m)+4, 7*(j+m)+5, 7*j, 7*j+3, -1)
            addTenToPos(j+3*s, j, 7*(j+m)+5, 7*(j+m)+5, 7*j, 7*j+4, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 7*(j+m)+2, 7*(j+m)+3, 7*j+1, 7*j+1, 1)
            addTenToPos(j, j, 7*(j+m)+3, 7*(j+m)+3, 7*j+1, 7*j+2, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j+2, 7*(j+1), -1)
            addTenToPos(j-s, j, 7*(j+m)+3, 7*(j+m)+6, 7*j+2, 7*j+2, 1)
            addTenToPos(j, j, 7*(j+m)+4, 7*(j+m)+6, 7*j+2, 7*j+3, -1)
        }
        for j in 4*s ..< 6*s {
            let j_2 = j / s
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m+1)-f(j_2,5), 7*j+j_2-1, 7*(j+1), 1)
            addTenToPos(j-s, j, 7*(j+m)+j_2, 7*(j+m+1)-f(j_2,5), 7*j+j_2-1, 7*j+j_2-1, 1)
            addTenToPos(j+2*s*f(j_2,4), j, 7*(j+m+1)-6*f(j_2,5), 7*(j+m+1)-f(j_2,5), 7*j+j_2-1, 7*j+10-j_2, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j-s, j, 7*(j+m)+1, 7*(j+m+1), 7*j+5, 7*j+5, 1)
            addTenToPos(j, j, 7*(j+m+1), 7*(j+m+1), 7*j+5, 7*j+6, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m+1)+1, 7*j+6, 7*(j+1), -1)
            addTenToPos(5*s+(j+1)%s, j, 7*(j+m+1)+1, 7*(j+m+1)+1, 7*j+6, 7*(j+1)+5, -1)
            addTenToPos(j-s, j, 7*(j+m+1), 7*(j+m+1)+1, 7*j+6, 7*j+6, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(3*s+(j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+6, 7*(j+1)+3, -1)
            addTenToPos(j-2*s, j, 7*(j+m+1), 7*(j+m+1)+4, 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber3() {
        let s = PathAlg.s
        let m = 1
        makeZeroMatrix(10*s, h: 9*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 5 {
                addTenToPos(j+s*(j_1+f(j_1,4)), j, 7*(j+m)+2+3*f(j_1,1)+f(j_1,2)+4*f(j_1,3,4), 7*(j+m)+6, 7*j, 7*j+j_1-1+f(j_1,0)+f(j_1,4), 1-2*f(j_1,1))
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(j_1+2-2*f(j_1,0)), j, 7*(j+m+1)-2*f(j_1,0)-f(j_1,2), 7*(j+m+1), 7*j, 7*j+j_1+2-2*f(j_1,0), 1-2*f(j_1,2,3))
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+2*s*j_1, j, 7*(j+m+1)+2+j_1, 7*(j+m+1)+3, 7*j+1, 7*(j+1)+j_1, 1)
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+3+3*j_1, 7*(j+m+1)+3, 7*j+1, 7*j+1+j_1, 1)
            }
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+6+j_1, 7*(j+m+1)+4, 7*j+2, 7*j+2+j_1, 1)
            }
            addTenToPos(j+5*s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+2, 7*j+6, 1)
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+3*j_1*s, j, 7*(j+m+1)+j_1, 7*(j+m+1)+1, 7*j+3, 7*j+3+3*j_1, 1)
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1)+5, 7*(j+m+1)+5, 7*j+3, 7*(j+1), -1)
            addTenToPos(j-s, j, 7*(j+m+1), 7*(j+m+1)+5, 7*j+3, 7*j+3, 1)
            addTenToPos(j+3*s, j, 7*(j+m+1)+4, 7*(j+m+1)+5, 7*j+3, 7*j+6, 1)
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1), j, 7*(j+m)+6+j_1, 7*(j+m+1)+1, 7*j+4, 7*j+4+j_1, 1)
            }
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+2, 7*(j+m+1)+2, 7*j+5, 7*(j+1), 1)
            addTenToPos(j-s, j, 7*(j+m+1), 7*(j+m+1)+2, 7*j+5, 7*j+5, 1)
            addTenToPos(j, j, 7*(j+m+1)+1, 7*(j+m+1)+2, 7*j+5, 7*j+6, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j-2*s, j, 7*(j+m+1), 7*(j+m+1)+4, 7*j+5, 7*j+5, 1)
            addTenToPos(j, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+5, 7*j+6, 1)
        }
        for j in 9*s ..< 10*s {
            for j_1 in 0 ..< 3 {
                addTenToPos((j+1)%s+s*(j_1+f(j_1,1,2)), j, 7*(j+m+1)+2+j_1+2*f(j_1,2), 7*(j+m+1)+6, 7*j+6, 7*(j+1)+j_1, 1)
            }
            addTenToPos(j-2*s, j, 7*(j+m+1)+1, 7*(j+m+1)+6, 7*j+6, 7*j+6, 1)
            addTenToPos(j-s, j, 7*(j+m+1)+4, 7*(j+m+1)+6, 7*j+6, 7*j+6, -1)
        }
    }

    private func createDiffWithNumber4() {
        let s = PathAlg.s
        let m = 2
        makeZeroMatrix(10*s, h: 10*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m-1)+6+j_1, 7*(j+m)+4, 7*j, 7*j, 1)
            }
            addTenToPos(j+3*s, j, 7*(j+m)+4, 7*(j+m)+4, 7*j, 7*j+2, -1)
            addTenToPos(j+8*s, j, 7*(j+m)+4, 7*(j+m)+4, 7*j, 7*j+5, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 7*(j+m-1)+6, 7*(j+m)+3, 7*j, 7*j, 1)
            addTenToPos(j+s, j, 7*(j+m)+3, 7*(j+m)+3, 7*j, 7*j+1, -1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+(5+j_1)*s, j, 7*(j+m)+1+j_1, 7*(j+m)+3, 7*j, 7*j+4+j_1, minusDeg(j_1+1))
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(2*j_1-f(j_1,0)), j, 7*(j+m)+f(j_1,1,2), 7*(j+m)+1, 7*j, 7*j+2+j_1-2*f(j_1,0), minusDeg(j_1))
            }
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j+1, 7*(j+1), -1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1+f(j_1,2)), j, 7*(j+m)+3+j_1, 7*(j+m)+6, 7*j+1, 7*j+1+j_1, minusDeg(j_1))
            }
        }
        for j in 4*s ..< 5*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1), 7*(j+m+1), 7*j+2, 7*(j+1), -1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(2*j_1-1), j, 7*(j+m)+4+j_1, 7*(j+m+1), 7*j+2, 7*j+2+j_1, minusDeg(j_1))
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j+3, 7*(j+1), 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1+3*f(j_1,2)), j, 7*(j+m)+4+j_1-3*f(j_1,0), 7*(j+m)+6, 7*j+3, 7*j+3+3*f(j_1,2), 2*f(j_1,0)-1)
            }
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*j_1, j, 7*(j+m)+6+j_1, 7*(j+m+1), 7*j+4, 7*(j+1), 1)
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+1+j_1, 7*(j+m+1), 7*j+4, 7*j+4+j_1, 1-2*f(j_1,1))
            }
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j, j, 7*(j+m)+2, 7*(j+m)+6, 7*j+5, 7*j+5, 1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+4+2*j_1, 7*(j+m)+6, 7*j+5, 7*j+5+j_1, -1)
            }
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ..< 4 {
                addTenToPos((j+1)%s+s*(j_1+2*f(j_1,2)+4*f(j_1,3)), j, 7*(j+m)+6+j_1, 7*(j+m+1)+2, 7*j+6, 7*(j+1)+3*f(j_1,2)+5*f(j_1,3), 2*f(j_1,2)-1)
            }
            addTenToPos(j+s, j, 7*(j+m)+6, 7*(j+m+1)+2, 7*j+6, 7*j+6, 1)
        }
        for j in 9*s ..< 10*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((3+2*j_1)*s+(j+1)%s, j, 7*(j+m+1)+4+j_1, 7*(j+m+1)+5, 7*j+6, 7*(j+1)+2+j_1, minusDeg(j_1+1))
            }
            addTenToPos(j, j, 7*(j+m)+6, 7*(j+m+1)+5, 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber5() {
        let s = PathAlg.s
        let m = 2
        makeZeroMatrix(12*s, h: 10*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+j_1*s, j, 7*(j+m)+4-j_1-f(j_1,2), 7*(j+m)+6, 7*j, 7*j, 2*f(j_1,0)-1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+(3+2*j_1)*s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j, 7*j+1+2*j_1, 2*f(j_1,2)-1)
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 7*(j+m)+3, 7*(j+m+1), 7*j, 7*j, 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+(2+j_1+f(j_1,2))*s, j, 7*(j+m)+6+f(j_1,1,2), 7*(j+m+1), 7*j, 7*j+1+j_1+f(j_1,2), 1)
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+1, 7*(j+1), 1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+6+j_1, 7*(j+m+1)+4, 7*j+1, 7*j+1+j_1, 1)
            }
        }
        for j in 3*s ..< 4*s {
            addTenToPos(2*s+(j+1)%s, j, 7*(j+m+1)+1, 7*(j+m+1)+1, 7*j+2, 7*(j+1), 1)
            addTenToPos(j+s, j, 7*(j+m+1), 7*(j+m+1)+1, 7*j+2, 7*j+2, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+5, 7*j+2, 7*(j+1), 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+3*f(j_1,2)), j, 7*(j+m+1+f(j_1,2))-j_1, 7*(j+m+1)+5, 7*j+2, 7*j+2+j_1+2*f(j_1,2), 2*f(j_1,0)-1)
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos(2*s+(j+1)%s, j, 7*(j+m+1)+1, 7*(j+m+1)+2, 7*j+3, 7*(j+1), 1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+3*s*j_1, j, 7*(j+m)+6+3*j_1, 7*(j+m+1)+2, 7*j+3, 7*j+3+3*j_1, 1)
            }
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*j_1, j, 7*(j+m+1)-j_1+4*f(j_1,2), 7*(j+m+1)+2, 7*j+4, 7*j+4+j_1, 1)
            }
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+4, 7*(j+1), -1)
            addTenToPos(j-s, j, 7*(j+m+1), 7*(j+m+1)+4, 7*j+4, 7*j+4, 1)
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(s*(j_1+1)+(j+1)%s, j, 7*(j+m+1)+3-2*j_1, 7*(j+m+1)+3, 7*j+5, 7*(j+1), 1)
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+(j_1-1)*s, j, 7*(j+m)+6+3*j_1, 7*(j+m+1)+3, 7*j+5, 7*j+5+j_1, 1)
            }
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j-2*s, j, 7*(j+m)+6, 7*(j+m+1)+5, 7*j+5, 7*j+5, 1)
            addTenToPos(j, j, 7*(j+m+1)+5, 7*(j+m+1)+5, 7*j+5, 7*j+6, 1)
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(s*(j_1+1)+(j+1)%s, j, 7*(j+m+1+f(j_1,2))+3-2*j_1, 7*(j+m+1)+6, 7*j+6, 7*(j+1)+f(j_1,2), 1)
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(j_1-2), j, 7*(j+m+1)+2+3*j_1, 7*(j+m+1)+6, 7*j+6, 7*j+6, minusDeg(j_1))
            }
        }
        for j in 11*s ..< 12*s {
            addTenToPos(4*s+(j+1)%s, j, 7*(j+m+2), 7*(j+m+2), 7*j+6, 7*(j+1)+2, 1)
            addTenToPos(j-2*s, j, 7*(j+m+1)+5, 7*(j+m+2), 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber6() {
        let s = PathAlg.s
        let m = 3
        makeZeroMatrix(12*s, h: 12*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 7*(j+m-1)+6, 7*(j+m)+2, 7*j, 7*j, 1)
            addTenToPos(j+s, j, 7*(j+m), 7*(j+m)+2, 7*j, 7*j, 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+4-f(j_1,0)), j, 7*(j+m)+2-f(j_1,0), 7*(j+m)+2, 7*j, 7*j+2+j_1, minusDeg(j_1+1))
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 7*(j+m-1)+6, 7*(j+m)+5, 7*j, 7*j, 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(1+2*j_1+3*f(j_1,2)), j, 7*(j+m)+5-f(j_1,0), 7*(j+m)+5, 7*j, 7*j+1+j_1+2*f(j_1,2), 2*f(j_1,0)-1)
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1+4*f(j_1,2)), j, 7*(j+m)+4*(1-f(j_1,0)), 7*(j+m)+4, 7*j, 7*j+j_1+2*f(j_1,2), 2*f(j_1,0)-1)
            }
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*j_1, j, 7*(j+m)+6+j_1, 7*(j+m+1), 7*j+1, 7*(j+1), -1)
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(j_1-1), j, 7*(j+m)+4-3*j_1, 7*(j+m+1), 7*j+1, 7*j+1+j_1, minusDeg(j_1))
            }
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j+2, 7*(j+1), 1)
            addTenToPos(j-s, j, 7*(j+m)+1, 7*(j+m)+6, 7*j+2, 7*j+2, 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+4*f(j_1,2)), j, 7*(j+m)+5-3*f(j_1,1)+f(j_1,2), 7*(j+m)+6, 7*j+2, 7*j+2+j_1+2*f(j_1,2), 2*f(j_1,2)-1)
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1), 7*(j+m+1), 7*j+3, 7*(j+1), 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+4-4*f(j_1,0)), j, 7*(j+m)+5+j_1-3*f(j_1,0), 7*(j+m+1), 7*j+3, 7*j+6-3*f(j_1,0), 2*f(j_1,0)-1)
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j+4, 7*(j+1), -1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+2+2*j_1-3*f(j_1,2), 7*(j+m)+6, 7*j+4, 7*j+4+f(j_1,2), 2*f(j_1,0)-1)
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+4+j_1-f(j_1,0), 7*(j+m)+6, 7*j+5, 7*j+5+f(j_1,2), 2*f(j_1,0)-1)
            }
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(2*j_1+1), j, 7*(j+m)+5+2*j_1, 7*(j+m+1), 7*j+5, 7*j+5+j_1, minusDeg(j_1))
            }
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+6, 7*(j+1)+1, -1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+6+j_1, 7*(j+m+1)+4, 7*j+6, 7*j+6, 1)
            }
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ..< 3 {
                addTenToPos((j+1)%s+s*(5*j_1-2*f(j_1,2)), j, 7*(j+m)+6+3*j_1-2*f(j_1,2), 7*(j+m+1)+3, 7*j+6, 7*(j+1)+3*j_1-f(j_1,2), 1-2*f(j_1,2))
            }
            addTenToPos(j, j, 7*(j+m)+6, 7*(j+m+1)+3, 7*j+6, 7*j+6, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(3*s+(j+1)%s, j, 7*(j+m+1)+1, 7*(j+m+1)+1, 7*j+6, 7*(j+1)+2, -1)
            addTenToPos(j, j, 7*(j+m+1), 7*(j+m+1)+1, 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber7() {
        let s = PathAlg.s
        let m = 3
        makeZeroMatrix(13*s, h: 12*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 6 {
                addTenToPos(j+s*(j_1+f(j_1,3)+2*f(j_1,4,5)), j, 7*(j+m)+2+j_1+2*f(j_1,1)+f(j_1,3)-f(j_1,5), 7*(j+m)+6, 7*j, 7*j+2*f(j_1,3)+4*f(j_1,4)+5*f(j_1,5), 1-2*f(j_1,1,2))
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ..< 5 {
                addTenToPos(j+s*(1+j_1-f(j_1,0)+2*f(j_1,4)), j, 7*(j+m+1)-2*f(j_1,0)-f(j_1,2), 7*(j+m+1), 7*j, 7*j+j_1+f(j_1,4), 1-2*f(j_1,1,3))
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(1+j_1+5*f(j_1,3)), j, 7*(j+m+1)-f(j_1,1)+f(j_1,3), 7*(j+m+1)+1, 7*j+1, 7*j+1+j_1+2*f(j_1,3), 1)
            }
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(s*(j_1+1)+(j+1)%s, j, 7*(j+m+1)+5-j_1, 7*(j+m+1)+5, 7*j+1, 7*(j+1), 1)
            }
            addTenToPos(j, j, 7*(j+m+1), 7*(j+m+1)+5, 7*j+1, 7*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+2, 7*(j+m+1)+2, 7*j+2, 7*(j+1), -1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+5*f(j_1,2)), j, 7*(j+m)+6+j_1, 7*(j+m+1)+2, 7*j+2, 7*j+2+j_1+2*f(j_1,2), 1)
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+2, 7*(j+m+1)+3, 7*j+3, 7*(j+1), -1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(4+j_1-4*f(j_1,0)), j, 7*(j+m+1)+3*j_1-5*f(j_1,2), 7*(j+m+1)+3, 7*j+3, 7*j+6-3*f(j_1,0), 1)
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos(2*s+(j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+3, 7*(j+1), -1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(4*j_1-1), j, 7*(j+m+1)+4*j_1, 7*(j+m+1)+4, 7*j+3, 7*j+3+3*j_1, 1)
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1+2*f(j_1,2)), j, 7*(j+m)+6+4*f(j_1,2), 7*(j+m+1)+3, 7*j+4, 7*j+4+j_1, 1)
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1)+5, 7*(j+m+1)+5, 7*j+4, 7*(j+1), 1)
            addTenToPos(j-2*s, j, 7*(j+m)+6, 7*(j+m+1)+5, 7*j+4, 7*j+4, 1)
        }
        for j in 9*s ..< 10*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-2), j, 7*(j+m)+6+j_1+3*f(j_1,2), 7*(j+m+1)+4, 7*j+5, 7*j+5+f(j_1,2), 1)
            }
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(3*j_1-2), j, 7*(j+m+1)+j_1, 7*(j+m+1)+1, 7*j+5, 7*j+5+j_1, 1)
            }
        }
        for j in 11*s ..< 12*s {
            for j_1 in 0 ..< 3 {
                addTenToPos((j+1)%s+2*s*(j_1+f(j_1,2)), j, 7*(j+m+1)+2+2*j_1, 7*(j+m+1)+6, 7*j+6, 7*(j+1)+4*f(j_1,2), minusDeg(j_1))
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-2), j, 7*(j+m+1)+4-j_1-f(j_1,2), 7*(j+m+1)+6, 7*j+6, 7*j+6, 2*f(j_1,0)-1)
            }
        }
        for j in 12*s ..< 13*s {
            for j_1 in 0 ..< 4 {
                addTenToPos((j+1)%s+s*(1+j_1-f(j_1,0)+2*f(j_1,3)), j, 7*(j+m+1)+2+2*j_1+f(j_1,2)-2*f(j_1,3), 7*(j+m+2), 7*j+6, 7*(j+1)+f(j_1,2)+4*f(j_1,3), 2*f(j_1,1,2)-1)
            }
            addTenToPos(j-2*s, j, 7*(j+m+1)+3, 7*(j+m+2), 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber8() {
        let s = PathAlg.s
        let m = 4
        makeZeroMatrix(12*s, h: 13*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m-1)+6+j_1, 7*(j+m)+5, 7*j, 7*j, 1)
            }
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(3+3*j_1-f(j_1,2)-3*f(j_1,3)), j, 7*(j+m)+4+f(j_1,0)+f(j_1,2), 7*(j+m)+5, 7*j, 7*j+2+j_1-f(j_1,0), 1-2*f(j_1,2,3))
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 7*(j+m-1)+6, 7*(j+m)+3, 7*j, 7*j, 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(3+j_1+f(j_1,2)), j, 7*(j+m)+3-f(j_1,0), 7*(j+m)+3, 7*j, 7*j+2+j_1, minusDeg(j_1+1))
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1+7*f(j_1,2)), j, 7*(j+m)+1-f(j_1,0), 7*(j+m)+1, 7*j, 7*j+j_1+3*f(j_1,2), 1-2*f(j_1,2))
            }
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j+1, 7*(j+1), -1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1), j, 7*(j+m)+1+4*f(j_1,1)+f(j_1,2), 7*(j+m)+6, 7*j+1, 7*j+1+f(j_1,2), 2*f(j_1,0)-1)
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*j_1, j, 7*(j+m)+6+j_1, 7*(j+m+1), 7*j+2, 7*(j+1), 1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+6*f(j_1,2)), j, 7*(j+m)+2+j_1+3*f(j_1,2), 7*(j+m+1), 7*j+2, 7*j+2+j_1+2*f(j_1,2), minusDeg(j_1))
            }
        }
        for j in 5*s ..< 6*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+4*f(j_1,2)), j, 7*(j+m)+3+j_1+f(j_1,2), 7*(j+m)+6, 7*j+3, 7*j+3+3*f(j_1,2), minusDeg(j_1))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j+4, 7*(j+1), -1)
            for j_1 in 0 ..< 5 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+2+j_1+f(j_1,0)+2*f(j_1,1)-4*f(j_1,3), 7*(j+m)+6, 7*j+4, 7*j+4+f(j_1,2,3)+2*f(j_1,4), 1-2*f(j_1,1,2))
            }
        }
        for j in 7*s ..< 8*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1), 7*(j+m+1), 7*j+4, 7*(j+1), -1)
            addTenToPos(j+s, j, 7*(j+m)+5, 7*(j+m+1), 7*j+4, 7*j+4, 1)
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+4+j_1-4*f(j_1,1), 7*(j+m+1), 7*j+5, 7*j+5+f(j_1,2,3), 2*f(j_1,0)-1)
            }
        }
        for j in 9*s ..< 10*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+2*s*(j_1+1), j, 7*(j+m+1)+1+j_1, 7*(j+m+1)+2, 7*j+6, 7*(j+1)+1+j_1, minusDeg(j_1+1))
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(2+j_1), j, 7*(j+m)+6+j_1, 7*(j+m+1)+2, 7*j+6, 7*j+6, 1)
            }
        }
        for j in 10*s ..< 11*s {
            addTenToPos(8*s+(j+1)%s, j, 7*(j+m+1)+5, 7*(j+m+1)+5, 7*j+6, 7*(j+1)+4, -1)
            addTenToPos(j+s, j, 7*(j+m)+6, 7*(j+m+1)+5, 7*j+6, 7*j+6, 1)
        }
        for j in 11*s ..< 12*s {
            for j_1 in 0 ..< 4 {
                addTenToPos((j+1)%s+s*(j_1+4*f(j_1,2)+6*f(j_1,3)), j, 7*(j+m)+6+j_1+3*f(j_1,2)+2*f(j_1,3), 7*(j+m+1)+4, 7*j+6, 7*(j+1)+3*f(j_1,2)+5*f(j_1,3), 1-2*f(j_1,3))
            }
            addTenToPos(j+s, j, 7*(j+m+1), 7*(j+m+1)+4, 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber9() {
        let s = PathAlg.s
        let m = 4
        makeZeroMatrix(12*s, h: 12*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+5-2*j_1, 7*(j+m)+6, 7*j, 7*j, 2*f(j_1,0)-1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(4+j_1-f(j_1,0)), j, 7*(j+m)+6, 7*(j+m)+6, 7*j, 7*j+2+j_1-f(j_1,0), 1-2*f(j_1,2))
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ..< 5 {
                addTenToPos(j+s*(3+j_1-3*f(j_1,0)-f(j_1,1)), j, 7*(j+m+1)-4*f(j_1,0)-f(j_1,2), 7*(j+m+1), 7*j, 7*j+2*j_1-2*f(j_1,3)-3*f(j_1,4), 1)
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(2*s+(j+1)%s, j, 7*(j+m+1)+1, 7*(j+m+1)+2, 7*j+1, 7*(j+1), -1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+6+f(j_1,1), 7*(j+m+1)+2, 7*j+1, 7*j+1+j_1, 1)
            }
            addTenToPos(j+7*s, j, 7*(j+m+1)+2, 7*(j+m+1)+2, 7*j+1, 7*j+6, -1)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*(j_1+1), j, 7*(j+m+1)+3-2*j_1, 7*(j+m+1)+3, 7*j+2, 7*(j+1), -1)
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m+1)-j_1, 7*(j+m+1)+3, 7*j+2, 7*j+2+j_1, 1)
            }
            addTenToPos(j+6*s, j, 7*(j+m+1)+2, 7*(j+m+1)+3, 7*j+2, 7*j+6, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j, j, 7*(j+m+1), 7*(j+m+1)+4, 7*j+2, 7*j+2, 1)
            addTenToPos(j+7*s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+2, 7*j+6, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j, j, 7*(j+m)+6, 7*(j+m+1)+5, 7*j+3, 7*j+3, 1)
            addTenToPos(j+5*s, j, 7*(j+m+1)+5, 7*(j+m+1)+5, 7*j+3, 7*j+6, -1)
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(j_1+2*f(j_1,3)), j, 7*(j+m+1)-f(j_1,0)+4*f(j_1,3), 7*(j+m+1)+4, 7*j+4, 7*j+3+j_1+f(j_1,0), 1)
            }
        }
        for j in 7*s ..< 8*s {
            addTenToPos(2*s+(j+1)%s, j, 7*(j+m+1)+1, 7*(j+m+1)+1, 7*j+4, 7*(j+1), 1)
            addTenToPos(j, j, 7*(j+m+1), 7*(j+m+1)+1, 7*j+4, 7*j+4, 1)
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m+1)+2*j_1, 7*(j+m+1)+2, 7*j+5, 7*j+5+j_1, 1)
            }
        }
        for j in 9*s ..< 10*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+5, 7*(j+m+1)+5, 7*j+5, 7*(j+1), -1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-f(j_1,0)), j, 7*(j+m+1)+6-j_1-6*f(j_1,0), 7*(j+m+1)+5, 7*j+5, 7*j+6-f(j_1,0), 1)
            }
        }
        for j in 10*s ..< 11*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+3*s*j_1, j, 7*(j+m+1)+5+j_1, 7*(j+m+1)+6, 7*j+6, 7*(j+1)+j_1, 1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1), j, 7*(j+m+1)+6-j_1-4*f(j_1,0), 7*(j+m+1)+6, 7*j+6, 7*j+6, 2*f(j_1,0)-1)
            }
        }
        for j in 11*s ..< 12*s {
            addTenToPos(7*s+(j+1)%s, j, 7*(j+m+2), 7*(j+m+2), 7*j+6, 7*(j+1)+4, 1)
            addTenToPos(j-s, j, 7*(j+m+1)+5, 7*(j+m+2), 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber10() {
        let s = PathAlg.s
        let m = 5
        makeZeroMatrix(10*s, h: 12*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m-1)+6+j_1, 7*(j+m)+2, 7*j, 7*j, 1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+6-4*f(j_1,0)), j, 7*(j+m)+2-f(j_1,1), 7*(j+m)+2, 7*j, 7*j+3+j_1-2*f(j_1,0), -1)
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(2*j_1+1-f(j_1,0)), j, 7*(j+m)+4-4*f(j_1,0), 7*(j+m)+4, 7*j, 7*j+2*j_1, 2*f(j_1,0)-1)
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1), 7*(j+m+1), 7*j+1, 7*(j+1), -1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+2+j_1, 7*(j+m+1), 7*j+1, 7*j+1+j_1, minusDeg(j_1))
            }
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j+2, 7*(j+1), -1)
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(j_1+4*f(j_1,3)), j, 7*(j+m)+3+j_1, 7*(j+m)+6, 7*j+2, 7*j+2+f(j_1,2)+4*f(j_1,3), 1-2*f(j_1,1,2))
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(1+6*j_1), j, 7*(j+m)+5+2*j_1, 7*(j+m+1), 7*j+3, 7*j+3+3*j_1, 1)
            }
        }
        for j in 5*s ..< 6*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*j_1, j, 7*(j+m)+6+j_1, 7*(j+m+1), 7*j+4, 7*(j+1), -1)
            }
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(2*j_1+f(j_1,0)), j, 7*(j+m)+2*j_1+1+3*f(j_1,0)-2*f(j_1,1), 7*(j+m+1), 7*j+4, 7*j+3+j_1+f(j_1,0), 1-2*f(j_1,1,2))
            }
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+2), j, 7*(j+m)+4+j_1-2*f(j_1,0), 7*(j+m)+6, 7*j+5, 7*j+5+f(j_1,2), 2*f(j_1,0)-1)
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ..< 5 {
                addTenToPos((j+1)%s+s*(j_1+2*f(j_1,2,3)+5*f(j_1,4)), j, 7*(j+m)+6+j_1+3*f(j_1,2,3)+2*f(j_1,4), 7*(j+m+1)+5, 7*j+6, 7*(j+1)+j_1-f(j_1,1)+f(j_1,4), 1-2*f(j_1,0,1))
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(3+j_1), j, 7*(j+m)+6+j_1, 7*(j+m+1)+5, 7*j+6, 7*j+6, 1)
            }
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*(j_1+2), j, 7*(j+m+1)+2+j_1, 7*(j+m+1)+3, 7*j+6, 7*(j+1)+1+j_1, minusDeg(j_1+1))
            }
            addTenToPos(j+2*s, j, 7*(j+m)+6, 7*(j+m+1)+3, 7*j+6, 7*j+6, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(7*s+(j+1)%s, j, 7*(j+m+1)+1, 7*(j+m+1)+1, 7*j+6, 7*(j+1)+4, -1)
            addTenToPos(j+2*s, j, 7*(j+m+1), 7*(j+m+1)+1, 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber11() {
        let s = PathAlg.s
        let m = 5
        makeZeroMatrix(10*s, h: 10*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 7 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+3+j_1-f(j_1,0)+2*f(j_1,2)-f(j_1,5)-3*f(j_1,6), 7*(j+m+1), 7*j, 7*j+j_1-1+f(j_1,0), 1-2*f(j_1,1)-2*f(j_1,5))
            }
        }
        for j in s ..< 2*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+2, 7*(j+m+1)+3, 7*j+1, 7*(j+1), 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+1+4*f(j_1,2)), j, 7*(j+m+1)-j_1+5*f(j_1,2), 7*(j+m+1)+3, 7*j+1, 7*j+1+j_1+3*f(j_1,2), 1-2*f(j_1,2))
            }
        }
        for j in 2*s ..< 3*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+1, 7*(j+1), 1)
            addTenToPos(j, j, 7*(j+m+1), 7*(j+m+1)+4, 7*j+1, 7*j+1, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+5, 7*j+2, 7*(j+1), -1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+2*f(j_1,2)), j, 7*(j+m)+6+j_1+4*f(j_1,2), 7*(j+m+1)+5, 7*j+2, 7*j+2+j_1+2*f(j_1,2), 1-2*f(j_1,2))
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+5*s*j_1, j, 7*(j+m+1)+j_1, 7*(j+m+1)+1, 7*j+3, 7*j+3+3*j_1, minusDeg(j_1))
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+2, 7*(j+m+1)+2, 7*j+4, 7*(j+1), 1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+4*s*j_1, j, 7*(j+m+1)+j_1, 7*(j+m+1)+2, 7*j+4, 7*j+4+2*j_1, minusDeg(j_1))
            }
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1), j, 7*(j+m+1)-j_1+7*f(j_1,2), 7*(j+m+1)+5, 7*j+4, 7*j+4+j_1, 2*f(j_1,0)-1)
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(2*j_1-1), j, 7*(j+m)+6+4*j_1, 7*(j+m+1)+3, 7*j+5, 7*j+5+j_1, 1)
            }
        }
        for j in 8*s ..< 9*s {
            for j_1 in 0 ..< 3 {
                addTenToPos((j+1)%s+3*s*j_1, j, 7*(j+m+1)+6-4*f(j_1,0), 7*(j+m+1)+6, 7*j+6, 7*(j+1)+2*j_1+f(j_1,2), 1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1-1), j, 7*(j+m+1)+5-2*j_1, 7*(j+m+1)+6, 7*j+6, 7*j+6, 2*f(j_1,0)-1)
            }
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 7*(j+m+2), 7*(j+m+2), 7*j+6, 7*(j+1)+1, 1)
            addTenToPos(j-s, j, 7*(j+m+1)+3, 7*(j+m+2), 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber12() {
        let s = PathAlg.s
        let m = 6
        makeZeroMatrix(9*s, h: 10*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 5 {
                addTenToPos(j+s*(2*j_1-1+f(j_1,0)+f(j_1,2)), j, 7*(j+m)+j_1-1+f(j_1,0)+3*f(j_1,1), 7*(j+m)+3, 7*j, 7*j+j_1+1-f(j_1,0,1), 2*f(j_1,0)+2*f(j_1,3)-1)
            }
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 7*(j+m), 7*(j+m)+5, 7*j, 7*j, 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+1+2*f(j_1,2)), j, 7*(j+m)+5-f(j_1,0), 7*(j+m)+5, 7*j, 7*j+2*j_1+f(j_1,0), 2*f(j_1,2)-1)
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 5 {
                addTenToPos(j+s*(j_1-1+3*f(j_1,4)), j, 7*(j+m)+3+j_1-5*f(j_1,3)-f(j_1,4), 7*(j+m)+6, 7*j+1, 7*j+j_1+f(j_1,0)+2*f(j_1,4), 2*f(j_1,0)+2*f(j_1,3)-1)
            }
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1), 7*(j+m+1), 7*j+2, 7*(j+1), -1)
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(j_1+3*f(j_1,2,3)), j, 7*(j+m)+4+j_1+f(j_1,0)-4*f(j_1,1), 7*(j+m+1), 7*j+2, 7*j+6-4*f(j_1,0)-3*f(j_1,1), 1-2*f(j_1,1))
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+4*s*j_1, j, 7*(j+m+1)+j_1, 7*(j+m+1)+1, 7*j+3, 7*(j+1)+3*j_1, minusDeg(j_1))
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(3+j_1-3*f(j_1,0)), j, 7*(j+m)+5+j_1-4*f(j_1,0), 7*(j+m+1)+1, 7*j+3, 7*j+6-3*f(j_1,0), 2*f(j_1,0)-1)
            }
        }
        for j in 5*s ..< 6*s {
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+2+3*f(j_1,1)+f(j_1,2)+4*f(j_1,3), 7*(j+m)+6, 7*j+4, 7*j+3+j_1+f(j_1,0), 2*f(j_1,0)-1)
            }
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(2*j_1+1), j, 7*(j+m)+3+4*j_1, 7*(j+m+1), 7*j+5, 7*j+5+j_1, minusDeg(j_1))
            }
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ..< 3 {
                addTenToPos((j+1)%s+s*(3+j_1-3*f(j_1,0)), j, 7*(j+m+1)+j_1, 7*(j+m+1)+2, 7*j+6, 7*(j+1)+2+j_1-2*f(j_1,0), 2*f(j_1,1)-1)
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+6+j_1, 7*(j+m+1)+2, 7*j+6, 7*j+6, 1)
            }
        }
        for j in 8*s ..< 9*s {
            addTenToPos(2*s+(j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+6, 7*(j+1)+1, -1)
            addTenToPos(j+s, j, 7*(j+m+1), 7*(j+m+1)+4, 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber13() {
        let s = PathAlg.s
        let m = 6
        makeZeroMatrix(7*s, h: 9*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 4 {
                addTenToPos(j+s*(j_1+2*f(j_1,3)), j, 7*(j+m)+6-3*f(j_1,0)-f(j_1,1), 7*(j+m)+6, 7*j, 7*j+j_1-1+f(j_1,0)+2*f(j_1,3), minusDeg(j_1))
            }
        }
        for j in s ..< 2*s {
            addTenToPos(s+(j+1)%s, j, 7*(j+m+1)+5, 7*(j+m+1)+5, 7*j+1, 7*(j+1), 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+1+4*f(j_1,2)), j, 7*(j+m)+6+j_1+3*f(j_1,2), 7*(j+m+1)+5, 7*j+1, 7*j+1+j_1+3*f(j_1,2), 1-2*f(j_1,2))
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m+1)+j_1, 7*(j+m+1)+1, 7*j+2, 7*j+2+j_1, 1)
            }
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(3*j_1+1), j, 7*(j+m+1)+1+j_1, 7*(j+m+1)+2, 7*j+3, 7*j+3+3*j_1, 1)
            }
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+3, 7*(j+m+1)+3, 7*j+4, 7*(j+1), 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m)+6+j_1+f(j_1,2), 7*(j+m+1)+3, 7*j+4, 7*j+4+j_1, 1)
            }
        }
        for j in 5*s ..< 6*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(2*j_1+1), j, 7*(j+m+1)+4*j_1, 7*(j+m+1)+4, 7*j+5, 7*j+5+j_1, 1)
            }
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 4 {
                addTenToPos((j+1)%s+s*(j_1+1-f(j_1,0)+2*f(j_1,3)), j, 7*(j+m+2)-4*f(j_1,0)-f(j_1,1), 7*(j+m+2), 7*j+6, 7*(j+1)+j_1+2*f(j_1,3), 1)
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*(j_1+1), j, 7*(j+m+1)+2+2*j_1, 7*(j+m+2), 7*j+6, 7*j+6, minusDeg(j_1))
            }
        }
    }

    private func createDiffWithNumber14() {
        let s = PathAlg.s
        let m = 7
        makeZeroMatrix(8*s, h: 7*s)

        for j in 0 ..< s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m)+6, 7*j, 7*(j+1), -1)
            for j_1 in 0 ..< 6 {
                addTenToPos(j+s*j_1, j, 7*(j+m-1)+6+j_1+5*f(j_1,1), 7*(j+m)+6, 7*j, 7*j+j_1, minusDeg(j_1))
            }
        }
        for j in s ..< 2*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m+1), 7*j+1, 7*(j+1), 1)
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+j_1+5*f(j_1,0), 7*(j+m+1), 7*j+1, 7*j+1+j_1, minusDeg(j_1))
            }
            addTenToPos(j+5*s, j, 7*(j+m+1), 7*(j+m+1), 7*j+1, 7*j+6, -1)
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+2*s*j_1, j, 7*(j+m)+6+2*j_1, 7*(j+m+1)+1, 7*j+2, 7*(j+1)+2*j_1, -1)
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+1+j_1, 7*(j+m+1)+1, 7*j+2, 7*j+2+j_1, minusDeg(j_1))
            }
            addTenToPos(j+4*s, j, 7*(j+m+1), 7*(j+m+1)+1, 7*j+2, 7*j+6, 1)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*(2+j_1), j, 7*(j+m+1)+1+j_1, 7*(j+m+1)+2, 7*j+3, 7*(j+1)+2+j_1, minusDeg(j_1))
            }
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m+1)+2, 7*j+3, 7*(j+1), 1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+3*s*j_1, j, 7*(j+m)+2+5*j_1, 7*(j+m+1)+2, 7*j+3, 7*j+3+3*j_1, minusDeg(j_1))
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+3+j_1+2*f(j_1,2), 7*(j+m+1), 7*j+4, 7*j+4+j_1, 2*f(j_1,0)-1)
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos(5*s+(j+1)%s, j, 7*(j+m+1)+4, 7*(j+m+1)+4, 7*j+5, 7*(j+1)+5, -1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+4+3*j_1, 7*(j+m+1)+4, 7*j+5, 7*j+5+j_1, 1)
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 7*(j+m)+6, 7*(j+m+1)+3, 7*j+6, 7*(j+1), -1)
            for j_1 in 0 ..< 3 {
                addTenToPos((j+1)%s+s*(2+j_1), j, 7*(j+m+1)+1+j_1, 7*(j+m+1)+3, 7*j+6, 7*(j+1)+2+j_1, minusDeg(j_1+1))
            }
            addTenToPos(j, j, 7*(j+m+1), 7*(j+m+1)+3, 7*j+6, 7*j+6, 1)
        }
        for j in 7*s ..< 8*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*(1+4*j_1), j, 7*(j+m+1)+5-j_1, 7*(j+m+1)+5, 7*j+6, 7*(j+1)+1+4*j_1, -1)
            }
            addTenToPos(j-s, j, 7*(j+m+1), 7*(j+m+1)+5, 7*j+6, 7*j+6, 1)
        }
    }

    private func createDiffWithNumber15() {
        let s = PathAlg.s
        let m = 7
        makeZeroMatrix(7*s, h: 8*s)

        for j in 0 ..< s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+6+j_1, 7*(j+m+1), 7*j, 7*j+j_1, 1)
            }
            addTenToPos(j+4*s, j, 7*(j+m+1), 7*(j+m+1), 7*j, 7*j+4, -1)
        }
        for j in s ..< 2*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m+1)+j_1, 7*(j+m+1)+1, 7*j+1, 7*j+1+j_1, 1)
            }
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m+1)+1+j_1, 7*(j+m+1)+2, 7*j+2, 7*j+2+j_1, 1)
            }
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+3*s*j_1, j, 7*(j+m+1)+2+j_1, 7*(j+m+1)+3, 7*j+3, 7*j+3+3*j_1, 1)
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m+1)+4*j_1, 7*(j+m+1)+4, 7*j+4, 7*j+4+j_1, 1)
            }
        }
        for j in 5*s ..< 6*s {
            for j_1 in 0 ..< 2 {
                addTenToPos(j+2*s*j_1, j, 7*(j+m+1)+4+j_1, 7*(j+m+1)+5, 7*j+5, 7*j+5+j_1, minusDeg(j_1))
            }
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1)+6, 7*(j+m+1)+6, 7*j+6, 7*(j+1), 1)
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m+1)+3+2*j_1, 7*(j+m+1)+6, 7*j+6, 7*j+6, minusDeg(j_1))
            }
        }
    }

    private func createDiffWithNumber16() {
        let s = PathAlg.s
        let m = 8
        makeZeroMatrix(7*s, h: 7*s)

        for j in 0 ..< s {
            addTenToPos((j+1)%s, j, 7*(j+m+1), 7*(j+m+1), 7*j, 7*(j+1), -1)
            for j_1 in 0 ..< 7 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+j_1, 7*(j+m+1), 7*j, 7*j+j_1, minusDeg(j_1))
            }
        }
        for j in s ..< 2*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*j_1, j, 7*(j+m+1)+j_1, 7*(j+m+1)+1, 7*j+1, 7*(j+1)+j_1, minusDeg(j_1))
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+1+j_1, 7*(j+m+1)+1, 7*j+1, 7*j+1+j_1, minusDeg(j_1))
            }
            addTenToPos(j+5*s, j, 7*(j+m)+6, 7*(j+m+1)+1, 7*j+1, 7*j+6, -1)
        }
        for j in 2*s ..< 3*s {
            for j_1 in 0 ..< 3 {
                addTenToPos((j+1)%s+s*j_1, j, 7*(j+m+1)+j_1, 7*(j+m+1)+2, 7*j+2, 7*(j+1)+j_1, minusDeg(j_1+1))
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+2+j_1, 7*(j+m+1)+2, 7*j+2, 7*j+2+j_1, minusDeg(j_1))
            }
            addTenToPos(j+4*s, j, 7*(j+m)+6, 7*(j+m+1)+2, 7*j+2, 7*j+6, 1)
        }
        for j in 3*s ..< 4*s {
            for j_1 in 0 ..< 4 {
                addTenToPos((j+1)%s+s*j_1, j, 7*(j+m+1)+j_1, 7*(j+m+1)+3, 7*j+3, 7*(j+1)+j_1, minusDeg(j_1))
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+3*s*j_1, j, 7*(j+m)+3+3*j_1, 7*(j+m+1)+3, 7*j+3, 7*j+3+3*j_1, minusDeg(j_1))
            }
        }
        for j in 4*s ..< 5*s {
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+4*s*j_1, j, 7*(j+m+1)+4*j_1, 7*(j+m+1)+4, 7*j+4, 7*(j+1)+4*j_1, -1)
            }
            for j_1 in 0 ..< 3 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+4+j_1, 7*(j+m+1)+4, 7*j+4, 7*j+4+j_1, minusDeg(j_1))
            }
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 7*(j+m+1), 7*(j+m+1)+5, 7*j+5, 7*(j+1), 1)
            for j_1 in 0 ..< 2 {
                addTenToPos((j+1)%s+s*(4+j_1), j, 7*(j+m+1)+4+j_1, 7*(j+m+1)+5, 7*j+5, 7*(j+1)+4+j_1, minusDeg(j_1))
            }
            for j_1 in 0 ..< 2 {
                addTenToPos(j+s*j_1, j, 7*(j+m)+5+j_1, 7*(j+m+1)+5, 7*j+5, 7*j+5+j_1, minusDeg(j_1))
            }
        }
        for j in 6*s ..< 7*s {
            for j_1 in 0 ..< 7 {
                addTenToPos((j+1)%s+s*j_1, j, 7*(j+m+1)+j_1, 7*(j+m+1)+6, 7*j+6, 7*(j+1)+j_1, minusDeg(j_1+1))
            }
            addTenToPos(j, j, 7*(j+m)+6, 7*(j+m+1)+6, 7*j+6, 7*j+6, 1)
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
        if wL.isZero || wR.isZero { fatalError("[\(i), \(j)]: zero way \(wL.str) \(wR.str)") }
        rows[i][j].addComb(Comb(tenzor: Tenzor(left: wL, right: wR), koef: Double(koef)))
    }
}
