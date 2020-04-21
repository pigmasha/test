
extension HHElem {
    func createHH() {
        switch type {
        case 1: createHH1()
        case 2: createHH2()
        case 3: createHH3()
        case 4: createHH4()
        case 5: createHH5()
        case 6: createHH6()
        case 7: createHH7()
        case 8: createHH8()
        case 9: createHH9()
        case 10: createHH10()
        case 11: createHH11()
        case 12: createHH12()
        case 13: createHH13()
        case 14: createHH14()
        case 15: createHH15()
        case 16: createHH16()
        case 17: createHH17()
        case 18: createHH18()
        case 19: createHH19()
        case 20: createHH20()
        case 21: createHH21()
        case 22: createHH22()
        case 23: createHH23()
        case 24: createHH24()
        case 25: createHH25()
        case 26: createHH26()
        case 27: createHH27()
        case 28: createHH28()
        case 29: createHH29()
        case 30: createHH30()
        case 31: createHH31()
        case 32: createHH32()
        case 33: createHH33()
        case 34: createHH34()
        case 35: createHH35()
        case 36: createHH36()
        default: fatalError("Bad type=\(type)")
        }
    }

    private func createHH1() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        for j in 0..<8*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j+j_2, leftTo:8*j+j_2, right:8*j+j_2, koef:1)
        }
    }
    private func createHH2() {
        let s = PathAlg.s
        makeZeroMatrix(9*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:1, right:0, koef:1)
        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:5, right:0, koef:1)
    }
    private func createHH3() {
        let s = PathAlg.s
        makeZeroMatrix(10*s, h: 8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j+2, right:8*j, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+6, right:8*j, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j+4, leftTo:8*(j+1), right:8*j+4, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+1, right:8*j+7, koef:1)
        }
    }
    private func createHH4() {
        let s = PathAlg.s
        makeZeroMatrix(11*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:7, right:0, koef:1)
    }
    private func createHH5() {
        let s = PathAlg.s
        makeZeroMatrix(11*s, h: 8*s)

        for j in 0 ..< 3*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:myModS(j), j:j, leftFrom:8*j, leftTo:8*j+5-2*j_2, right:8*j, koef:1-2*f(j_2,2))
        }
        for j in 5*s ..< 8*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+j_2-2, leftTo:8*(j+1)-f(j_2,6), right:8*j+j_2-2, koef:minusDeg(j_2+1))
        }
    }
    private func createHH6() {
        let s = PathAlg.s
        makeZeroMatrix(13*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:7, right:0, koef:1)
    }
    private func createHH7() {
        let s = PathAlg.s
        makeZeroMatrix(14*s, h: 8*s)

        for j in s ..< 2*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+4, right:8*j, koef:1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j, leftTo:8*j+5, right:8*j, koef:1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+6, leftTo:8*j+7, right:8*j+6, koef:1)
        }
        for j in 11*s ..< 12*s {
            HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+5, right:8*j+7, koef:1)
        }
    }
    private func createHH8() {
        let s = PathAlg.s
        makeZeroMatrix(16*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:7, right:0, koef:-1)
    }
    private func createHH9() {
        let s = PathAlg.s
        makeZeroMatrix(16*s, h: 8*s)

        for j in 0 ..< 3*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:myModS(j), j:j, leftFrom:8*j, leftTo:8*j+3*j_2+5*f(j_2,0), right:8*j, koef:minusDeg(j_2+1))
        }
        for j in 5*s ..< 8*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+j_2-3, leftTo:8*j+7+f(j_2,6), right:8*j+j_2-3, koef:1+f(j_2,6))
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+5, leftTo:8*(j+1), right:8*j+5, koef:1)
        }
        for j in 12*s ..< 14*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:7*s+myModS(j), j:j, leftFrom:8*j+7, leftTo:8*(j+1)+2*(j_2-11), right:8*j+7, koef:1+2*f(j_2,13))
        }
    }
    private func createHH10() {
        let s = PathAlg.s
        makeZeroMatrix(19*s, h: 8*s)

        for j in s ..< 3*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:myModS(j), j:j, leftFrom:8*j, leftTo:8*j, right:8*j, koef:minusDeg(j_2+1))
        }
        for j in 4*s ..< 7*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+j_2-3, leftTo:8*j+j_2-3, right:8*j+j_2-3, koef:-1+2*f(j_2,4))
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+4, leftTo:8*j+4, right:8*j+4, koef:-1)
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(self, i:j-5*s, j:j, leftFrom:8*j+5, leftTo:8*j+5, right:8*j+5, koef:1)
        }
        for j in 14*s ..< 15*s {
            HHElem.addElemToHH(self, i:j-8*s, j:j, leftFrom:8*j+6, leftTo:8*j+6, right:8*j+6, koef:1)
        }
        for j in 16*s ..< 19*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:7*s+myModS(j), j:j, leftFrom:8*j+7, leftTo:8*j+7+f(j_2,18), right:8*j+7, koef:minusDeg(j_2))
        }
    }
    private func createHH11() {
        let s = PathAlg.s
        makeZeroMatrix(19*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:8, right:0, koef:1, noZeroLenL:true)
        HHElem.addElemToHH(self, i:0, j:2*s, leftFrom:0, leftTo:8, right:0, koef:1, noZeroLenL:true)
    }
    private func createHH12() {
        let s = PathAlg.s
        makeZeroMatrix(18*s, h: 8*s)

        var j = myModS(-5)
        HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j+2, right:8*j, koef:1)
        j = myModS(-4)
        HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j+2, right:8*j, koef:-1)
        j = myModS(-3)
        HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j+2, right:8*j, koef:1)
        j = myModS(-2)
        HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j+2, right:8*j, koef:-1)
        j = s + myModS(-6)
        HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+6, right:8*j, koef:-1)
        j = s + myModS(-2)
        HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+6, right:8*j, koef:1)
        j = 6*s + myModS(-5)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+2, leftTo:8*(j+1), right:8*j+2, koef:-1)
        j = 6*s + myModS(-4)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+2, leftTo:8*(j+1), right:8*j+2, koef:1)
        j = 6*s + myModS(-3)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+2, leftTo:8*(j+1), right:8*j+2, koef:-1)
        j = 7*s + myModS(-6)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+3, leftTo:8*j+7, right:8*j+3, koef:-1)
        j = 7*s + myModS(-5)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+3, leftTo:8*j+7, right:8*j+3, koef:1)
        j = 7*s + myModS(-4)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+3, leftTo:8*j+7, right:8*j+3, koef:-1)
        j = 7*s + myModS(-3)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+3, leftTo:8*j+7, right:8*j+3, koef:1)
        j = 8*s + myModS(-2)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+4, leftTo:8*j+7, right:8*j+4, koef:-1)
        j = 10*s + myModS(-6)
        HHElem.addElemToHH(self, i:j-5*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, right:8*j+5, koef:1)
        j = 10*s + myModS(-5)
        HHElem.addElemToHH(self, i:j-5*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, right:8*j+5, koef:-1)
        j = 10*s + myModS(-4)
        HHElem.addElemToHH(self, i:j-5*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, right:8*j+5, koef:1)
        j = 10*s + myModS(-3)
        HHElem.addElemToHH(self, i:j-5*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, right:8*j+5, koef:-1)
        j = 10*s + myModS(-2)
        HHElem.addElemToHH(self, i:j-5*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, right:8*j+5, koef:-1)
    }
    private func createHH13() {
        let s = PathAlg.s
        makeZeroMatrix(19*s, h: 8*s)

        for j in s ..< 2*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j, right:8*j, koef:1)
        }
        for j in 3*s ..< 5*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+j_2-2, leftTo:8*j+j_2-1, right:8*j+j_2-2, koef:-1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+3, leftTo:8*j+4, right:8*j+3, koef:-1)
        }
        for j in 11*s ..< 12*s {
            HHElem.addElemToHH(self, i:j-6*s, j:j, leftFrom:8*j+5, leftTo:8*j+6, right:8*j+5, koef:1)
        }
        for j in 12*s ..< 14*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-7*s, j:j, leftFrom:8*j+j_2-7, leftTo:8*j+j_2-7, right:8*j+j_2-7, koef:minusDeg(j_2+1))
        }
        for j in 16*s ..< 17*s {
            HHElem.addElemToHH(self, i:j-9*s, j:j, leftFrom:8*j+7, leftTo:8*j+7, right:8*j+7, koef:1)
        }
        for j in 18*s ..< 19*s {
            HHElem.addElemToHH(self, i:j-11*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1), right:8*j+7, koef:1)
        }
    }
    private func createHH14() {
        let s = PathAlg.s
        makeZeroMatrix(18*s, h: 8*s)

        var j = s + myModS(-3)
        HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+3, right:8*j, koef:1)
        j = 4*s + myModS(-3)
        HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+1, leftTo:8*j+8, right:8*j+1, koef:-1)
        j = 9*s + myModS(-3)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, right:8*j+5, koef:1)
        j = 14*s + myModS(-4)
        HHElem.addElemToHH(self, i:j-7*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+6, right:8*j+7, koef:1)
    }
    private func createHH15() {
        let s = PathAlg.s
        makeZeroMatrix(18*s, h: 8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j+3, rightFrom:8*j, rightTo:8*j, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(self, i:j-5*s, j:j, leftFrom:8*j+3, leftTo:8*(j+1), rightFrom:8*j+3, rightTo:8*j+3, koef:-1)
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(self, i:j-5*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, rightFrom:8*j+5, rightTo:8*j+5, koef:-1)
        }
        for j in 14*s ..< 15*s {
            HHElem.addElemToHH(self, i:j-7*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+2, rightFrom:8*j+7, rightTo:8*j+7, koef:1)
        }
    }
    private func createHH16() {
        let s = PathAlg.s
        makeZeroMatrix(19*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:8, right:0, koef:1, noZeroLenL: true)
    }
    private func createHH17() {
        let s = PathAlg.s
        makeZeroMatrix(18*s, h: 8*s)

        for j in s ..< 2*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+4, right:8*j, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j, leftTo:8*j+5, right:8*j, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+3, leftTo:8*j+7, right:8*j+3, koef:-1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+5, leftTo:8*(j+1), right:8*j+5, koef:-1)
        }
        for j in 13*s ..< 14*s {
            HHElem.addElemToHH(self, i:j-6*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+3, right:8*j+7, koef:1)
        }
    }
    private func createHH18() {
        let s = PathAlg.s
        makeZeroMatrix(19*s, h: 8*s)

        for j in s ..< 2*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j, right:8*j, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j, leftTo:8*j, right:8*j, koef:2)
        }
        for j in 4*s ..< 6*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+j_2-3, leftTo:8*j+j_2-3, right:8*j+j_2-3, koef:2*minusDeg(j_2+1))
        }
        for j in 7*s ..< 9*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+j_2-4, leftTo:8*j+j_2-4, right:8*j+j_2-4, koef:2)
        }
        for j in 11*s ..< 12*s {
            HHElem.addElemToHH(self, i:j-6*s, j:j, leftFrom:8*j+5, leftTo:8*j+6, right:8*j+5, koef:2)
        }
        for j in 12*s ..< 14*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-7*s, j:j, leftFrom:8*j+j_2-7, leftTo:8*j+j_2-7, right:8*j+j_2-7, koef:minusDeg(j_2+1))
        }
        for j in 16*s ..< 17*s {
            HHElem.addElemToHH(self, i:j-9*s, j:j, leftFrom:8*j+7, leftTo:8*j+7, right:8*j+7, koef:1)
        }
        for j in 18*s ..< 19*s {
            HHElem.addElemToHH(self, i:j-11*s, j:j, leftFrom:8*j+7, leftTo:8*j+7, right:8*j+7, koef:2)
        }
    }
    private func createHH19() {
        let s = PathAlg.s
        makeZeroMatrix(19*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:8, right:0, koef:1, noZeroLenL: true)
    }
    private func createHH20() {
        let s = PathAlg.s
        makeZeroMatrix(16*s, h: 8*s)

        var j = s + myModS(-3)
        HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+6, right:8*j, koef:-1)
        j = s + myModS(-2)
        HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+6, right:8*j, koef:-1)
        j = 4*s + myModS(-4)
        HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+1, leftTo:8*(j+1), right:8*j+1, koef:-1)
        j = 5*s + myModS(-3)
        HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+2, leftTo:8*j+7, right:8*j+2, koef:1)
        j = 5*s + myModS(-2)
        HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+2, leftTo:8*j+7, right:8*j+2, koef:1)
        j = 9*s + myModS(-4)
        HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+5, leftTo:8*(j+1), right:8*j+5, koef:1)
    }
    private func createHH21() {
        let s = PathAlg.s
        makeZeroMatrix(16*s, h: 8*s)

        for j in s ..< 3*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j+j_2-1, leftTo:8*j+2*(j_2-1), right:8*j+j_2-1, koef:minusDeg(j_2+1))
        }
        for j in 4*s ..< 6*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+j_2-2, leftTo:8*j+j_2-1, right:8*j+j_2-2, koef:-1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+5, leftTo:8*j+6, right:8*j+5, koef:-1)
        }
        for j in 13*s ..< 15*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:7*s+myModS(j), j:j, leftFrom:8*j+7, leftTo:8*j+j_2-6, right:8*j+7, koef:minusDeg(j_2+1))
        }
    }
    private func createHH22() {
        let s = PathAlg.s
        makeZeroMatrix(14*s, h: 8*s)

        var j = 5*s + myModS(-7)
        HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+3, leftTo:8*j+7, right:8*j+3, koef:-1)
        j = 5*s + myModS(-6)
        HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+3, leftTo:8*j+7, right:8*j+3, koef:1)
        j = 5*s + myModS(-5)
        HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+3, leftTo:8*j+7, right:8*j+3, koef:-1)
        j = 7*s + myModS(-7)
        HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, right:8*j+5, koef:-1)
        j = 7*s + myModS(-6)
        HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, right:8*j+5, koef:1)
        j = 7*s + myModS(-5)
        HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+5, leftTo:8*j+7, right:8*j+5, koef:-1)
    }
    private func createHH23() {
        let s = PathAlg.s
        makeZeroMatrix(13*s, h: 8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j, right:8*j, koef:1)
        }
        for j in 2*s ..< 4*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j+j_2-1, leftTo:8*j+j_2+1, right:8*j+j_2-1, koef:-1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+5, leftTo:8*j+5, right:8*j+5, koef:-1)
        }
        for j in 10*s ..< 12*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j-4*s, j:j, leftFrom:8*j+j_2-4, leftTo:8*j+j_2-4, right:8*j+j_2-4, koef:1)
        }
        for j in 12*s ..< 13*s {
            HHElem.addElemToHH(self, i:j-5*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1), right:8*j+7, koef:1)
        }
    }
    private func createHH24() {
        let s = PathAlg.s
        makeZeroMatrix(11*s, h: 8*s)

        var j = 7*s + myModS(-2)
        HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j+6, leftTo:8*j+7, rightFrom:8*j+6, rightTo:8*j+6, koef:1)
        j = 7*s + myModS(-3)
        HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j+6, leftTo:8*j+7, rightFrom:8*j+6, rightTo:8*j+6, koef:1)
        j = 9*s + myModS(-4)
        HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+4, rightFrom:8*j+7, rightTo:8*j+7, koef:1)
        j = 9*s + myModS(-3)
        HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+4, rightFrom:8*j+7, rightTo:8*j+7, koef:1)
    }
    private func createHH25() {
        let s = PathAlg.s
        makeZeroMatrix(11*s, h: 8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j, right:8*j, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j+1, leftTo:8*j+4, right:8*j+1, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+5, leftTo:8*j+6, right:8*j+5, koef:-1)
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+7, leftTo:8*j+7, right:8*j+7, koef:-1)
        }
    }
    private func createHH26() {
        let s = PathAlg.s
        makeZeroMatrix(10*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:4, right:0, koef:1)
        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:6, right:0, koef:1)
    }
    private func createHH27() {
        let s = PathAlg.s
        makeZeroMatrix(9*s, h: 8*s)

        for j in 0 ..< 5*s {
            let j_2 = j / s
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j+j_2, leftTo:8*j+7+j_2, right:8*j+j_2, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+4, right:8*j+7, koef:-1)
        }
    }
    private func createHH28() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:8, right:0, koef:-1, noZeroLenL: true)
    }
    private func createHH29() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:8, right:0, koef:1, noZeroLenL: true)
    }
    private func createHH30() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        HHElem.addElemToHH(self, i:1, j:1, leftFrom:1, leftTo:9, right:1, koef:1, noZeroLenL: true)
    }
    private func createHH31() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        HHElem.addElemToHH(self, i:2, j:2, leftFrom:2, leftTo:10, right:2, koef:1, noZeroLenL: true)
    }
    private func createHH32() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        HHElem.addElemToHH(self, i:3, j:3, leftFrom:3, leftTo:11, right:3, koef:1, noZeroLenL: true)
    }
    private func createHH33() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        HHElem.addElemToHH(self, i:4, j:4, leftFrom:4, leftTo:12, right:4, koef:1, noZeroLenL: true)
    }
    private func createHH34() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        HHElem.addElemToHH(self, i:5, j:5, leftFrom:5, leftTo:13, right:5, koef:1, noZeroLenL: true)
    }
    private func createHH35() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        HHElem.addElemToHH(self, i:6, j:6, leftFrom:6, leftTo:14, right:6, koef:1, noZeroLenL: true)
    }
    private func createHH36() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 8*s)

        HHElem.addElemToHH(self, i:7, j:7, leftFrom:7, leftTo:15, right:7, koef:1, noZeroLenL: true)
    }

    private func koefs(len: Int) -> [Int] {
        var kk: [Int] = []
        if PathAlg.alg.dummy1 == 0 {
            for _ in 0 ..< len { kk += [1] }
        } else {
            var dd = PathAlg.alg.dummy1
            for _ in 0 ..< len {
                kk += [(dd % 3 == 2) ? -1 : (dd % 3)]
                dd /= 3
            }
        }
        return kk
    }
}
