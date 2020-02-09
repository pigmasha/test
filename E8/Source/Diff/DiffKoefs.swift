//
//  DiffKoefs.swift
//  E8
//
//  Created by M on 11/01/2020.
//

#if DIFF_KOEFS

final class DiffKoefs: Matrix {
    let deg: Int

    init(deg: Int) {
        self.deg = deg
        super.init()

        createDiff()
    }
    
    func createDiff() {
        let m = deg / 2
        deg % 2 == 0 ? createEvenDiff(m) : createOddDiff(m)
    }

    private func createEvenDiff(_ m: Int) {
        switch (m) {
        case 0: createDiffKoefsWithNumber0()
        case 1: createDiffKoefsWithNumber2()
        case 2: createDiffKoefsWithNumber4()
        case 3: createDiffKoefsWithNumber6()
        case 4: createDiffKoefsWithNumber8()
        case 5: createDiffKoefsWithNumber10()
        case 6: createDiffKoefsWithNumber12()
        case 7: createDiffKoefsWithNumber14()
        case 8: createDiffKoefsWithNumber16()
        case 9: createDiffKoefsWithNumber18()
        case 10: createDiffKoefsWithNumber20()
        case 11: createDiffKoefsWithNumber22()
        case 12: createDiffKoefsWithNumber24()
        case 13: createDiffKoefsWithNumber26()
        case 14: createDiffKoefsWithNumber28()
        default: fatalError()
        }
    }

    private func createOddDiff(_ m: Int) {
        switch (m) {
        case 0: createDiffKoefsWithNumber1()
        case 1: createDiffKoefsWithNumber3()
        case 2: createDiffKoefsWithNumber5()
        case 3: createDiffKoefsWithNumber7()
        case 4: createDiffKoefsWithNumber9()
        case 5: createDiffKoefsWithNumber11()
        case 6: createDiffKoefsWithNumber13()
        case 7: createDiffKoefsWithNumber15()
        case 8: createDiffKoefsWithNumber17()
        case 9: createDiffKoefsWithNumber19()
        case 10: createDiffKoefsWithNumber21()
        case 11: createDiffKoefsWithNumber23()
        case 12: createDiffKoefsWithNumber25()
        case 13: createDiffKoefsWithNumber27()
        default: fatalError()
        }
    }

    private func createDiffKoefsWithNumber0() {
        let s = PathAlg.s
        let m = 0
        makeZeroMatrix(9*s, h: 8*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+1, 8*j+1, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+2, 8*j+2, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j-s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+3, 8*j+3, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+4, 8*j+4, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber1() {
        let s = PathAlg.s
        let m = 0
        makeZeroMatrix(8*s, h: 9*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+1, 8*j+1, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+1, 8*j+1, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+2, 8*j+2, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+2, 8*j+2, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+2, 8*j+2, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+3, 8*j+3, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+4, 8*j+4, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber2() {
        let s = PathAlg.s
        let m = 1
        makeZeroMatrix(10*s, h: 8*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+2, 8*j+2, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+3, 8*j+3, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+4, 8*j+4, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+5, 8*j+5, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j-s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(j-2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber3() {
        let s = PathAlg.s
        let m = 1
        makeZeroMatrix(11*s, h: 10*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+2, 8*j+2, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+4, 8*j+4, -1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+4, 8*j+4, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+5, 8*j+5, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+6, 8*j+6, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j-2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffKoefsWithNumber4() {
        let s = PathAlg.s
        let m = 2
        makeZeroMatrix(11*s, h: 11*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+1, 8*j+1, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+2, 8*j+2, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, -1)
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+3, 8*j+3, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+4, 8*j+4, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+4, 8*j+4, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+5, 8*j+5, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+6, 8*j+6, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber5() {
        let s = PathAlg.s
        let m = 2
        makeZeroMatrix(13*s, h: 11*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+1, 8*j+1, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+3, 8*j+3, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+5, 8*j+5, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, -1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+6, 8*j+6, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+6, 8*j+6, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+6, 8*j+6, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber6() {
        let s = PathAlg.s
        let m = 3
        makeZeroMatrix(14*s, h: 13*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-2*s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j-2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+1, 8*j+1, 1)
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+1, 8*j+1, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, -1)
            addTenToPos(j-2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+2, 8*j+2, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
            addTenToPos(j-2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+3, 8*j+3, 1)
            addTenToPos(j-s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+3, 8*j+3, -1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+3, 8*j+3, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
            addTenToPos(j-s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
            addTenToPos(j-s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+5, 8*j+5, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, -1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber7() {
        let s = PathAlg.s
        let m = 3
        makeZeroMatrix(16*s, h: 14*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+2, 8*j+2, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+2, 8*j+2, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+4, 8*j+4, -1)
            addTenToPos(j+6*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+4, 8*j+4, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+4, 8*j+4, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+5, 8*j+5, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+6, 8*j+6, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+6, 8*j+6, 1)
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+6, 8*j+6, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j-3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+6, 8*j+6, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j-3*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(j-3*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber8() {
        let s = PathAlg.s
        let m = 4
        makeZeroMatrix(16*s, h: 16*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+1, 8*j+1, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+2, 8*j+2, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, -1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+3, 8*j+3, -1)
            addTenToPos(j+9*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+4, 8*j+4, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+4, 8*j+4, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+5, 8*j+5, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+6, 8*j+6, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+6, 8*j+6, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+6, 8*j+6, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, -1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(12*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber9() {
        let s = PathAlg.s
        let m = 4
        makeZeroMatrix(19*s, h: 16*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+1, 8*j+1, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+1, 8*j+1, -1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+2, 8*j+2, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+3, 8*j+3, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+4, 8*j+4, 1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+4, 8*j+4, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+4, 8*j+4, 1)
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+4, 8*j+4, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+5, 8*j+5, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+5, 8*j+5, 1)
            addTenToPos(j-3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+6, 8*j+6, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(j-4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+6, 8*j+6, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j-4*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j-4*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
        for j in 18*s ..< 19*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, -1)
            addTenToPos(j-4*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber10() {
        let s = PathAlg.s
        let m = 5
        makeZeroMatrix(18*s, h: 19*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+12*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+13*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+13*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j-3*s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j-2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+1, 8*j+1, 1)
            addTenToPos(j-s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+1, 8*j+1, -1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j-s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+2, 8*j+2, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j-s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+3, 8*j+3, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+3, 8*j+3, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+4, 8*j+4, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+4, 8*j+4, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+4, 8*j+4, 1)
            addTenToPos(j+9*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+5, 8*j+5, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+5, 8*j+5, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+5, 8*j+5, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+6, 8*j+6, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, -1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber11() {
        let s = PathAlg.s
        let m = 5
        makeZeroMatrix(19*s, h: 18*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+12*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+12*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+1, 8*j+1, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+2, 8*j+2, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+11*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+2, 8*j+2, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+9*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+3, 8*j+3, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+3, 8*j+3, -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
            addTenToPos(j+9*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+3, 8*j+3, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+4, 8*j+4, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+5, 8*j+5, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+5, 8*j+5, -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+6, 8*j+6, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+6, 8*j+6, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+6, 8*j+6, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, -1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
        }
        for j in 18*s ..< 19*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, -1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, -1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber12() {
        let s = PathAlg.s
        let m = 6
        makeZeroMatrix(18*s, h: 19*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
            addTenToPos(j+15*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+13*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+11*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-2*s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j-s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+1, 8*j+1, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j-s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+2, 8*j+2, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+3, 8*j+3, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+3, 8*j+3, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+3, 8*j+3, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
            addTenToPos(j+10*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+4, 8*j+4, 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+4, 8*j+4, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
            addTenToPos(j+9*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
            addTenToPos(j+10*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+6, 8*j+6, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+6, 8*j+6, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+6, 8*j+6, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(15*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber13() {
        let s = PathAlg.s
        let m = 6
        makeZeroMatrix(20*s, h: 18*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+11*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+1, 8*j+1, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+1, 8*j+1, -1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+2, 8*j+2, -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+10*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+2, 8*j+2, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+2, 8*j+2, -1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, -1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+10*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+4, 8*j+4, -1)
            addTenToPos(j-2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+4, 8*j+4, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+4, 8*j+4, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+5, 8*j+5, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+5, 8*j+5, 1)
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j-3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+5, 8*j+5, -1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+6, 8*j+6, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+6, 8*j+6, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(j-4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-4*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j-3*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
        for j in 18*s ..< 19*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, -1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-5*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j-3*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
        }
        for j in 19*s ..< 20*s {
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j-4*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffKoefsWithNumber14() {
        let s = PathAlg.s
        let m = 7
        makeZeroMatrix(18*s, h: 20*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+12*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+14*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+13*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j-3*s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+12*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
            addTenToPos(j-2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+1, 8*j+1, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+2, 8*j+2, -1)
            addTenToPos(j+13*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+2, 8*j+2, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, -1)
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+3, 8*j+3, -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+3, 8*j+3, -1)
            addTenToPos(j+10*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+4, 8*j+4, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+5, 8*j+5, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+5, 8*j+5, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+5, 8*j+5, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+5, 8*j+5, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+6, 8*j+6, -1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+6, 8*j+6, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(14*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(12*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber15() {
        let s = PathAlg.s
        let m = 7
        makeZeroMatrix(19*s, h: 18*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+11*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+1, 8*j+1, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+12*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+2, 8*j+2, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+3, 8*j+3, -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, -1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+3, 8*j+3, -1)
            addTenToPos(j+9*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+4, 8*j+4, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+5, 8*j+5, -1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+6, 8*j+6, -1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+6, 8*j+6, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+6, 8*j+6, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+6, 8*j+6, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
        }
        for j in 18*s ..< 19*s {
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, -1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber16() {
        let s = PathAlg.s
        let m = 8
        makeZeroMatrix(18*s, h: 19*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+7*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+12*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+12*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-2*s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+12*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+1, 8*j+1, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+1, 8*j+1, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
            addTenToPos(j-s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+1, 8*j+1, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+2, 8*j+2, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+2, 8*j+2, -1)
            addTenToPos(j+12*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+3, 8*j+3, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+3, 8*j+3, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+4, 8*j+4, 1)
            addTenToPos(j+9*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+5, 8*j+5, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+5, 8*j+5, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, -1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+6, 8*j+6, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(13*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos(12*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber17() {
        let s = PathAlg.s
        let m = 8
        makeZeroMatrix(19*s, h: 18*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, -1)
            addTenToPos(j+12*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+1, 8*j+1, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+11*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+2, 8*j+2, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+2, 8*j+2, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+2, 8*j+2, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+3, 8*j+3, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+4, 8*j+4, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+4, 8*j+4, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+5, 8*j+5, -1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j-3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(j-2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+6, 8*j+6, -1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+6, 8*j+6, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+6, 8*j+6, -1)
            addTenToPos(j-3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+6, 8*j+6, -1)
            addTenToPos(j+s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+6, 8*j+6, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(j-3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+6, 8*j+6, 1)
        }
        for j in 16*s ..< 17*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-3*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(j+s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
        for j in 17*s ..< 18*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(j-4*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
        }
        for j in 18*s ..< 19*s {
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-3*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffKoefsWithNumber18() {
        let s = PathAlg.s
        let m = 9
        makeZeroMatrix(16*s, h: 19*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+12*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+13*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j-2*s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j-s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+1, 8*j+1, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+2, 8*j+2, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+2, 8*j+2, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+2, 8*j+2, 1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+3, 8*j+3, -1)
            addTenToPos(j+11*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+4, 8*j+4, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+4, 8*j+4, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+5, 8*j+5, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(j+3*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+6, 8*j+6, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+6, 8*j+6, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+6, 8*j+6, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
            addTenToPos(14*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(11*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber19() {
        let s = PathAlg.s
        let m = 9
        makeZeroMatrix(16*s, h: 16*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+9*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+1, 8*j+1, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+10*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+1, 8*j+1, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+1, 8*j+1, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+2, 8*j+2, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+3, 8*j+3, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+3, 8*j+3, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, -1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+9*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+3, 8*j+3, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+4, 8*j+4, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+5, 8*j+5, -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+5, 8*j+5, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+5, 8*j+5, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+5, 8*j+5, 1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+6, 8*j+6, 1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, -1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
            addTenToPos(j+s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
        }
        for j in 14*s ..< 15*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
        }
        for j in 15*s ..< 16*s {
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber20() {
        let s = PathAlg.s
        let m = 10
        makeZeroMatrix(14*s, h: 16*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
            addTenToPos(j+10*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+11*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
            addTenToPos(j+10*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
            addTenToPos(j-s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+2, 8*j+2, -1)
            addTenToPos(j+10*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+3, 8*j+3, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+3, 8*j+3, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+4, 8*j+4, 1)
            addTenToPos(j+9*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+5, 8*j+5, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+5, 8*j+5, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+5, 8*j+5, -1)
            addTenToPos(j+5*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+5, 8*j+5, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+6, 8*j+6, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, -1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(8*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 13*s ..< 14*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(12*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber21() {
        let s = PathAlg.s
        let m = 10
        makeZeroMatrix(13*s, h: 14*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+1, 8*j+1, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+2, 8*j+2, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+9*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+2, 8*j+2, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+3, 8*j+3, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+5, 8*j+5, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+6, 8*j+6, -1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+6, 8*j+6, -1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
        }
        for j in 11*s ..< 12*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(j+s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
        for j in 12*s ..< 13*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, -1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, -1)
            addTenToPos(9*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, -1)
            addTenToPos(j-2*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffKoefsWithNumber22() {
        let s = PathAlg.s
        let m = 11
        makeZeroMatrix(11*s, h: 13*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+9*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, -1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+1, 8*j+1, -1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+2, 8*j+2, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+2, 8*j+2, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+2, 8*j+2, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+3, 8*j+3, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
            addTenToPos(j+8*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+4, 8*j+4, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+5, 8*j+5, -1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(10*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber23() {
        let s = PathAlg.s
        let m = 11
        makeZeroMatrix(11*s, h: 11*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+1, 8*j+1, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+2, 8*j+2, -1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+7*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+2, 8*j+2, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+5, 8*j+5, 1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+5, 8*j+5, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+5, 8*j+5, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(j-s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+6, 8*j+6, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+6, 8*j+6, 1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(j-s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
        }
        for j in 10*s ..< 11*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffKoefsWithNumber24() {
        let s = PathAlg.s
        let m = 12
        makeZeroMatrix(10*s, h: 11*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+8*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j%s, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j-s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+1, 8*j+1, -1)
            addTenToPos(j+8*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, -1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+2, 8*j+2, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+3, 8*j+3, -1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, 1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, -1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+5, 8*j+5, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, -1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
        }
        for j in 9*s ..< 10*s {
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber25() {
        let s = PathAlg.s
        let m = 12
        makeZeroMatrix(8*s, h: 10*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+8*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+1, 8*j+1, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+2, 8*j+2, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j+s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j+s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j+4*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+4, 8*j+4, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+5, 8*j+5, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m), 8*(j+m), 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffKoefsWithNumber26() {
        let s = PathAlg.s
        let m = 13
        makeZeroMatrix(9*s, h: 8*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j, 8*j, 1)
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+1, 8*j+1, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+1, 8*j+1, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, -1)
            addTenToPos(j+6*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, -1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+2, 8*j+2, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+2, 8*j+2, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+2, 8*j+2, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, -1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+3, 8*j+3, -1)
            addTenToPos(j+4*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, -1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, 1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+4, 8*j+4, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+4, 8*j+4, -1)
            addTenToPos(j+3*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, -1)
            addTenToPos(j+2*s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, -1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, -1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, -1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, -1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
        for j in 8*s ..< 9*s {
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(j-s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, 1)
        }
    }

    private func createDiffKoefsWithNumber27() {
        let s = PathAlg.s
        let m = 13
        makeZeroMatrix(8*s, h: 9*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
            addTenToPos(j+s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
        }
        for j in s ..< 2*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+1, 8*j+1, 1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos(j, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+2, 8*j+2, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+2, 8*j+2, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos(j, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+3, 8*j+3, 1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos(j, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+4, 8*j+4, 1)
            addTenToPos(j+3*s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+4, 8*j+4, -1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos(j, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos(j, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(j+2*s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+6, 8*j+6, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, 1)
            addTenToPos(j+s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, -1)
        }
    }

    private func createDiffKoefsWithNumber28() {
        let s = PathAlg.s
        let m = 14
        makeZeroMatrix(8*s, h: 8*s)

        for j in 0 ..< s {
            addTenToPos(j, j, 8*(j+m), 8*(j+m), 8*j, 8*j, 1)
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j, 8*j, -1)
            addTenToPos(j+s, j, 8*(j+m)+1, 8*(j+m)+1, 8*j, 8*j, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j, 8*j, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j, 8*j, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j, 8*j, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+5, 8*(j+m)+5, 8*j, 8*j, 1)
            addTenToPos(j+6*s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j, 8*j, -1)
            addTenToPos(j+7*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j, 8*j, 1)
        }
        for j in s ..< 2*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+1, 8*j+1, 1)
            addTenToPos(j, j, 8*(j+m)+1, 8*(j+m)+1, 8*j+1, 8*j+1, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+1, 8*j+1, -1)
            addTenToPos(j+s, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+1, 8*j+1, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+1, 8*j+1, 1)
            addTenToPos(j+3*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+1, 8*j+1, -1)
            addTenToPos(j+6*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+1, 8*j+1, -1)
        }
        for j in 2*s ..< 3*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+2, 8*j+2, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+2, 8*j+2, 1)
            addTenToPos(j, j, 8*(j+m)+2, 8*(j+m)+2, 8*j+2, 8*j+2, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+2, 8*j+2, -1)
            addTenToPos(j+s, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+2, 8*j+2, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+2, 8*j+2, 1)
            addTenToPos(j+5*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+2, 8*j+2, 1)
        }
        for j in 3*s ..< 4*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+3, 8*j+3, 1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+3, 8*j+3, -1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+3, 8*j+3, 1)
            addTenToPos(j, j, 8*(j+m)+3, 8*(j+m)+3, 8*j+3, 8*j+3, 1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+3, 8*j+3, -1)
            addTenToPos(j+s, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+3, 8*j+3, -1)
            addTenToPos(j+4*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+3, 8*j+3, -1)
        }
        for j in 4*s ..< 5*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+4, 8*j+4, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+4, 8*j+4, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+4, 8*j+4, -1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+4, 8*j+4, 1)
            addTenToPos(j, j, 8*(j+m)+4, 8*(j+m)+4, 8*j+4, 8*j+4, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+4, 8*j+4, -1)
            addTenToPos(j+3*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+4, 8*j+4, 1)
        }
        for j in 5*s ..< 6*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+5, 8*j+5, -1)
            addTenToPos(j, j, 8*(j+m)+5, 8*(j+m)+5, 8*j+5, 8*j+5, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+5, 8*j+5, -1)
            addTenToPos(j+s, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+5, 8*j+5, -1)
            addTenToPos(j+2*s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+5, 8*j+5, 1)
        }
        for j in 6*s ..< 7*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+6, 8*j+6, 1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+6, 8*j+6, 1)
            addTenToPos(j, j, 8*(j+m)+6, 8*(j+m)+6, 8*j+6, 8*j+6, 1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+6, 8*j+6, -1)
            addTenToPos(j+s, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+6, 8*j+6, -1)
        }
        for j in 7*s ..< 8*s {
            addTenToPos((j+1)%s, j, 8*(j+m-1), 8*(j+m-1), 8*j+7, 8*j+7, -1)
            addTenToPos(s+(j+1)%s, j, 8*(j+m-1)+1, 8*(j+m-1)+1, 8*j+7, 8*j+7, 1)
            addTenToPos(2*s+(j+1)%s, j, 8*(j+m-1)+2, 8*(j+m-1)+2, 8*j+7, 8*j+7, -1)
            addTenToPos(3*s+(j+1)%s, j, 8*(j+m-1)+3, 8*(j+m-1)+3, 8*j+7, 8*j+7, 1)
            addTenToPos(4*s+(j+1)%s, j, 8*(j+m-1)+4, 8*(j+m-1)+4, 8*j+7, 8*j+7, -1)
            addTenToPos(5*s+(j+1)%s, j, 8*(j+m-1)+5, 8*(j+m-1)+5, 8*j+7, 8*j+7, -1)
            addTenToPos(6*s+(j+1)%s, j, 8*(j+m-1)+6, 8*(j+m-1)+6, 8*j+7, 8*j+7, 1)
            addTenToPos(j, j, 8*(j+m)+7, 8*(j+m)+7, 8*j+7, 8*j+7, 1)
            addTenToPos(7*s+(j+1)%s, j, 8*(j+m-1)+7, 8*(j+m-1)+7, 8*j+7, 8*j+7, -1)
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

#endif
