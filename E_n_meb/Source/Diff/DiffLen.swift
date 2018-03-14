//
//  Created by M on 25.02.18.
//

import Foundation

final class DiffLen {
    let deg: Int
    private(set) var items: [[IntPair]]

    init(deg: Int) {
        self.deg = deg
        items = []

        let r = deg % PathAlg.twistPeriod

        switch r {
        case 0: create0()
        case 1: create1()
        case 2: create2()
        case 3: create3()
        case 4: create4()
        case 5: create5()
        case 6: create6()
        case 7: create7()
        case 8: create8()
        case 9: create9()
        default: create10()
        }
    }

    private func createZero(_ width: Int, h height: Int) {
        for _ in 0 ..< height {
            var line: [IntPair] = []
            for _ in 0 ..< width { line += [ IntPair.pairWithN0(0, n1: 0) ] }
            items += [line]
        }
    }

    private func addLenToPos(_ i: Int, _ j: Int, _ l0: Int, _ l1: Int) {
        let n = items[i][j]
        n.n0 = l0
        n.n1 = l1
    }

    private func create0() {
        let s = PathAlg.s
        createZero(7*s, h: 6*s)

        for j in 0 ..< 2*s {
            addLenToPos(j%s, j, 1, 0)
            addLenToPos(j+s, j, 0, 1)
        }

        for j in 2*s ..< 4*s {
            addLenToPos(j-s, j, 1, 0)
            addLenToPos(j+s, j, 0, 1)
        }

        for j in 4*s ..< 6*s {
            addLenToPos(j-s, j, 1, 0)
            addLenToPos(j%s+5*s, j, 0, 1)
        }

        for j in 6*s ..< 7*s {
            addLenToPos((j+1)%s, j, 0, 1)
            addLenToPos(j-s, j, 1, 0)
        }
    }

    private func create2() {
        let s = PathAlg.s
        createZero(8*s, h: 6*s)

        for j in 0 ..< 2*s {
            addLenToPos(j%s, j, 3, 0)
            addLenToPos(j+s, j, 0, 1)
            addLenToPos((j+s)%(2*s)+3*s, j, 1, 2)
        }

        for j in 2*s ..< 4*s {
            addLenToPos((j+1)%s, j, 0, 3)
            addLenToPos(j-s, j, 1, 0)
            addLenToPos(j+s, j, 2, 1)
        }

        for j in 4*s ..< 6*s {
            if (j<5*s-1 || j==6*s-1) { addLenToPos((j+1)%s, j, 1, 2) }
            addLenToPos(j-s, j, 3, 0)
            addLenToPos(j%s+5*s, j, 0, 1)
        }

        for j in 6*s ..< 8*s {
            if (j<7*s-1 || j==8*s-1) { addLenToPos((j+1)%s, j, 2, 1) }
            addLenToPos((j+s+1)%(2*s)+3*s, j, 0, 3)
            addLenToPos(j%s+5*s, j, 1, 0)
        }
    }

    private func create4() {
        let s = PathAlg.s
        createZero(8*s, h: 9*s)

        for j in 0 ..< 2*s {
            if (j<s) { addLenToPos(j, j, 2, 0) }
            addLenToPos(j%s+s, j, 1, 0)
            addLenToPos((j+s)%(2*s)+2*s, j, 0, 1)
            addLenToPos(j+(5-f0(j,s))*s, j, 0, 2)
        }

        for j in 2*s ..< 4*s {
            if(j<3*s-1||j==4*s-1) { addLenToPos((j+1)%s, j, 1, 3) }
            addLenToPos((j+1)%s+s, j, 0, 3)
            addLenToPos(j, j, 3, 0)
            addLenToPos(j+(4-f0(j,3*s))*s, j, 2, 1)
        }

        for j in 4*s ..< 6*s {
            if(j<5*s-1||j==6*s-1) { addLenToPos((j+1)%s, j, 0, 2) }
            addLenToPos(j+(1-f0(j,5*s))*s, j, 2, 0)
            addLenToPos(j+(2-f0(j,5*s))*s, j, 1, 0)
            addLenToPos(j%s+8*s, j, 0, 1)
        }

        for j in 6*s ..< 8*s {
            if(j<7*s-1||j==8*s-1) { addLenToPos((j+1)%s, j, 3, 1) }
            addLenToPos((j+s+1)%(2*s)+2*s, j, 1, 2)
            if(j<7*s-1||j==8*s-1) { addLenToPos((j+1)%s+7*s, j, 0, 3) }
            if(j>=7*s-1&&j<8*s-1) { addLenToPos((j+1)%s+5*s, j, 0, 3) }
            addLenToPos(j%s+8*s, j, 3, 0)
        }
    }

    private func create6() {
        let s = PathAlg.s
        createZero(8*s, h: 9*s)

        for j in 0 ..< 2*s {
            let j_2 = j / s
            addLenToPos(j%s, j, 2, 0)
            addLenToPos(j+(j_2+1)*s, j, 1, 1)
            addLenToPos(j+(4-3*j_2)*s, j, 0, 1)
            addLenToPos(j+5*s, j, 0, 2)
        }

        for j in 2*s ..< 4*s {
            let j_2 = j / s
            addLenToPos(j+s*(j_2-3), j, 2, 0)
            addLenToPos(j+s*(j_2-2), j, 1, 0)
            addLenToPos(j+3*s, j, 1, 1)
            addLenToPos(j%s+7*s, j, 0, 2)
        }

        for j in 4*s ..< 6*s {
            if (j>=5*s) { addLenToPos((j+1)%s, j, 0, 2) }
            addLenToPos(j+s, j, 2, 0)
            if (j>=5*s) { addLenToPos(j+2*s, j, 1, 1) }
            addLenToPos(j%s+8*s, j, 0, 1)
        }

        for j in 6*s ..< 8*s {
            if (j<7*s) { addLenToPos((j+1)%s, j, 1, 1) }
            if (j<7*s-1||j==8*s-1) { addLenToPos((j+1)%(2*s)+s, j, 0, 2) }
            if (j>=7*s-1&&j<8*s-1) { addLenToPos((j+1)%(2*s)+2*s, j, 0, 2) }
            if (j<7*s) { addLenToPos(j+s, j, 2, 0) }
            addLenToPos(j%s+8*s, j, 1, 0)
        }
    }

    private func create8() {
        let s = PathAlg.s
        createZero(7*s, h: 6*s)

        for j in 0 ..< s {
            addLenToPos(j, j, 4, 0)
            addLenToPos((j+1)%s, j, 0, 4)
            addLenToPos(j+s, j, 1, 1)
            addLenToPos(j+2*s, j, 1, 1)
            addLenToPos(j+3*s, j, 2, 2)
            addLenToPos(j+4*s, j, 2, 2)
        }

        for j in s ..< 3*s {
            if(j<2*s-1||j==3*s-1) { addLenToPos((j+1)%s, j, 1, 3) }
            addLenToPos(j, j, 2, 0)
            addLenToPos(j+2*s, j, 3, 1)
            addLenToPos(j%s+5*s, j, 0, 2)
        }

        for j in 3*s ..< 5*s {
            if(j<4*s-1||j==5*s-1) { addLenToPos((j+1)%s, j, 2, 2) }
            addLenToPos(j, j, 4, 0)
            addLenToPos((j+s+1)%(2*s)+3*s, j, 0, 4)
            addLenToPos(j%s+5*s, j, 1, 1)
        }

        for j in 5*s ..< 7*s {
            if(j>=6*s-1&&j<7*s-1) { addLenToPos((j+1)%s, j, 3, 1) }
            addLenToPos((j+s+1)%(2*s)+s, j, 0, 2)
            addLenToPos((j+1)%(2*s)+3*s, j, 1, 3)
            addLenToPos(j%s+5*s, j, 2, 0)
        }
    }

    private func create10() {
        let s = PathAlg.s
        createZero(6*s, h: 6*s)

        for j in 0 ..< s {
            addLenToPos((j+1)%s, j, 0, 4)
            for j_1 in 0 ... 2 {
                addLenToPos(j+(2*j_1+1)*s, j, 3 - j_1, 1 + j_1)
            }
            for j_1 in 0 ... 2 {
                addLenToPos(j+2*j_1*s, j, 4 - j_1, j_1)
            }
        }

        for j in s ..< 3*s {
            addLenToPos((j+1)%s, j, 1, 3)
            addLenToPos(j, j, 4, 0)
            addLenToPos((j+s+1)%(2*s)+s, j, 0, 4)
            addLenToPos(j+2*s, j, 3, 1)
            addLenToPos(j%s+5*s, j, 2, 2)
        }

        for j in 3*s ..< 5*s {
            addLenToPos((j+1)%s, j, 2, 2)
            addLenToPos((j+s+1)%(2*s)+s, j, 1, 3)
            addLenToPos(j, j, 4, 0)
            addLenToPos((j+s+1)%(2*s)+3*s, j, 0, 4)
            addLenToPos(j%s+5*s, j, 3, 1)
        }

        for j in 5*s ..< 6*s {
            addLenToPos((j+1)%s, j, 3, 1)
            addLenToPos(j-4*s+1, j, 2, 2)
            addLenToPos((j+1)%(2*s)+s, j, 2, 2)
            addLenToPos(j-2*s+1, j, 1, 3)
            addLenToPos((j+1)%(2*s)+3*s, j, 1, 3)
            addLenToPos(j, j, 4, 0)
            addLenToPos((j+1)%s+5*s, j, 0, 4)
        }
    }

    private func create1() {
        let s = PathAlg.s
        createZero(6*s, h: 7*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addLenToPos(j+2*j_1*s, j, 2 - j_1, j_1)
            }
            for j_1 in 0 ... 2 {
                addLenToPos(j+(2*j_1+1)*s, j, 2 - j_1, j_1)
            }
        }

        for j in s ..< 3*s {
            addLenToPos((j<2*s) ? j-s+1 : (j+s+1)%(2*s), j, 1, 3)
            addLenToPos(j+s, j, 4, 0)
            addLenToPos((j<2*s) ? j+s+1 : (j+s+1)%(2*s)+2*s, j, 0, 4)
            addLenToPos(j+3*s, j, 3, 1)
            addLenToPos(j%s+6*s, j, 2, 2)
        }

        for j in 3*s ..< 5*s {
            addLenToPos((j<4*s) ? (j+1)%(2*s):j-4*s+1, j, 0, 2)
            addLenToPos(j+s, j, 2, 0)
            addLenToPos(j%s+6*s, j, 1, 1)
        }

        for j in 5*s ..< 6*s {
            addLenToPos((j+1)%s, j, 3, 1)
            addLenToPos((j+1)%s+2*s, j, 2, 2)
            addLenToPos((j+1)%s+4*s, j, 1, 3)
            addLenToPos(j+s, j, 4, 0)
            addLenToPos((j+1)%s+6*s, j, 0, 4)
        }
    }

    private func create3() {
        let s = PathAlg.s
        createZero(9*s, h: 8*s)

        for j in 0 ..< 2*s {
            let j_2 = j / s
            addLenToPos(j%s, j, (j_2 == 0) ? 1 : 2, 0)
            addLenToPos(j+s+3*j_2*s, j, (j_2 == 0) ? 1 : 0, (j_2 == 0) ? 0 : 2)
            addLenToPos(j+(2+j_2)*s, j, 0, (j_2 == 0) ? 1 : 2)
            addLenToPos((j+s)%(2*s)+2*s, j, (j_2 == 0) ? 0 : 1, 1)
        }

        for j in 2*s ..< 4*s {
            addLenToPos(j, j, 2, 0)
            addLenToPos(j+2*s, j, 1, 1)
            addLenToPos((j+s)%(2*s)+6*s, j, 0, 2)
        }

        for j in 4*s ..< 6*s {
            let j_2 = j / s
            if (j>=5*s) { addLenToPos((j+1)%(2*s), j, 0, 2) }
            addLenToPos(j%s+4*s, j, (j_2 == 4) ? 1 : 2, 0)
            addLenToPos(j+2*s, j, (j_2 == 4) ? 0 : 1, 1)
        }

        for j in 6*s ..< 8*s {
            let j_2 = j / s
            if (j>=7*s) { addLenToPos(j-7*s+1, j, 0, 2) }
            addLenToPos(j%s+5*s, j, (j_2 == 6) ? 1 : 2, 0)
            addLenToPos((j+s)%(2*s)+6*s, j, (j_2 == 6) ? 0 : 1, 1)
        }

        for j in 8*s ..< 9*s {
            addLenToPos((j+1)%s, j, 1, 1)
            addLenToPos((j+1)%s+2*s, j, 0, 2)
            addLenToPos(j-2*s, j, 2, 0)
            addLenToPos(j-s, j, 2, 0)
        }
    }

    private func create5() {
        let s = PathAlg.s
        createZero(9*s, h: 8*s)

        for j in 0 ..< s {
            for j_1 in 0 ... 2 {
                addLenToPos(j+2*j_1*s, j, (j_1 == 0) ? 3 :((j_1 == 1) ? 0 : 1), j_1)
            }
            for j_1 in 0 ... 2 {
                addLenToPos(j+(2*j_1+1)*s, j, (j_1 == 0) ? 3 :((j_1 == 1) ? 0 : 1), j_1)
            }
        }

        for j in s ..< 3*s {
            let j_2 = j / s
            addLenToPos((j+s+1)%(2*s), j, (j_2 == 1) ? 0 : 1, 3)
            addLenToPos(j%s+2*s, j, (j_2 == 1) ? 1 : 2, 0)
            if(j>=2*s) { addLenToPos(j+2*s, j, 3, 1) }
            if(j>=2*s) { addLenToPos(j+5*s, j, 0, 2) }
        }

        for j in 3*s ..< 5*s {
            let j_2 = j / s
            addLenToPos((j+1)%(2*s), j, (j_2 == 3) ? 0 : 1, 3)
            addLenToPos(j%s+3*s, j, (j_2 == 3) ? 1 : 2, 0)
            if(j>=4*s) { addLenToPos(j+s, j, 3, 1) }
            if(j>=4*s) { addLenToPos(j+2*s, j, 0, 2) }
        }

        for j in 5*s ..< 7*s {
            addLenToPos(j-s, j, 3, 0)
            addLenToPos(j+s, j, 0, 1)
        }

        for j in 7*s ..< 8*s {
            addLenToPos(j-7*s+1, j, 2, 1)
            addLenToPos((j+1)%(2*s), j, 2, 1)
            addLenToPos(j-3*s+1, j, 0, 3)
            addLenToPos((j+1)%(2*s)+4*s, j, 0, 3)
            addLenToPos(j-s, j, 1, 0)
            addLenToPos(j, j, 1, 0)
        }

        for j in 8*s ..< 9*s {
            addLenToPos((j+s+1)%(2*s)+2*s, j, 0, 2)
            addLenToPos(j-2*s, j, 2, 0)
        }
    }

    private func create7() {
        let s = PathAlg.s
        createZero(6*s, h: 8*s)

        for j in 0 ..< s {
            addLenToPos(j, j, 1, 0)
            addLenToPos(j+s, j, 1, 0)
            addLenToPos(j+2*s, j, 0, 1)
            addLenToPos(j+3*s, j, 0, 1)
        }

        for j in s ..< 3*s {
            addLenToPos((j+s+1)%(2*s), j, 0, 3)
            addLenToPos(j+s, j, 3, 0)
            addLenToPos(j+3*s, j, 2, 1)
            addLenToPos(j+5*s, j, 1, 2)
        }

        for j in 3*s ..< 5*s {
            addLenToPos(j+s, j, 1, 0)
            addLenToPos(j%(2*s)+6*s, j, 0, 1)
        }

        for j in 5*s ..< 6*s {
            addLenToPos((j+1)%s+s, j, 2, 1)
            addLenToPos((j+1)%s+2*s, j, 1, 2)
            addLenToPos((j+1)%s+4*s, j, 0, 3)
            addLenToPos((j+1)%s+5*s, j, 0, 3)
            addLenToPos(j+s, j, 3, 0)
            addLenToPos(j+2*s, j, 3, 0)
        }
    }

    private func create9() {
        let s = PathAlg.s
        createZero(6*s, h: 7*s)

        for j in 0 ..< s {
            addLenToPos(j, j, 1, 0)
            addLenToPos(j+s, j, 0, 1)
            addLenToPos(j+2*s, j, 0, 1)
        }

        for j in s ..< 3*s {
            addLenToPos(j, j, 1, 0)
            addLenToPos(j+2*s, j, 0, 1)
        }

        for j in 3*s ..< 5*s {
            addLenToPos(j, j, 1, 0)
            addLenToPos(j%(2*s)+5*s, j, 0, 1)
        }

        for j in 5*s ..< 6*s {
            addLenToPos((j+1)%s, j, 0, 1)
            addLenToPos(j, j, 1, 0)
            addLenToPos(j+s, j, 1, 0)
        }
    }
}

