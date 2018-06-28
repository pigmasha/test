
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
        default: break
        }
    }

    private func createHH1() {
        let s = PathAlg.s, m = 0, ell = Int(deg / PathAlg.twistPeriod)
        makeZeroMatrix(6*s, h: 6*s)

        for j in 0..<s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*j, leftTo:4*j, right:4*j, koef:PathAlg.k1J(ell, j:j, m:m))
        }
        for j in s..<3*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*(j+s)+1, leftTo:4*(j+s)+1, right:4*(j+s)+1, koef:1)
        }
        for j in 3*s..<5*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*(j+s)+2, leftTo:4*(j+s)+2, right:4*(j+s)+2, koef:1)
        }
        for j in 5*s..<6*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*j+3, leftTo:4*j+3, right:4*j+3, koef:PathAlg.k1J(ell, j:j, m:m))
        }
    }
    private func createHH2() {
        let s = PathAlg.s
        makeZeroMatrix(6*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:4, right:0, koef:1)
    }
    private func createHH3() {
        let s = PathAlg.s
        makeZeroMatrix(7*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:1, right:0, koef:1)
        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:4*s+1, right:0, koef:1)
    }
    private func createHH4() {
        let s = PathAlg.s, m = 0, ell = Int(deg / PathAlg.twistPeriod)
        makeZeroMatrix(7*s, h: 6*s)

        for j in 0..<s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*j, leftTo:4*(j+s)+1, right:4*j, koef:1)
        }
        for j in 5*s-1..<6*s-1 {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+2, leftTo:4*j+3, right:4*j+2, koef:-PathAlg.k1J(ell, j:j, m:m))
        }
    }
    private func createHH5() {
        let s = PathAlg.s
        makeZeroMatrix(6*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:3, right:0, koef:1)
    }
    private func createHH6() {
        let s = PathAlg.s, m = 1, ell = Int(deg / PathAlg.twistPeriod)
        makeZeroMatrix(8*s, h: 6*s)

        for j in 0..<s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*j, leftTo:4*j+2, right:4*j, koef:1)
        }
        for j in 3*s..<4*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+1, leftTo:4*j+3, right:4*j+1, koef:-PathAlg.k1J(ell, j:j, m:m))
        }
        for j in 4*s..<6*s {
            if j < 5*s-1 || j == 6*s-1 {
                HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+2, leftTo:4*(j+1), right:4*j+2,
                                   koef:-PathAlg.k1JPlus1(ell, j:j, m:m))
            }
        }
        for j in 6*s..<8*s {
            if j < 7*s-1 || j == 8*s-1 {
                HHElem.addElemToHH(self, i:5*s+(j%s), j:j, leftFrom:4*j+3, leftTo:4*(j+1)+1, right:4*j+3, koef:1)
            }
        }
    }
    private func createHH7() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 6*s)
        
        for j in 0..<2*s {
            HHElem.addElemToHH(self, i:j%s, j:j, leftFrom:4*j, leftTo:4*(j+s)+2, right:4*j, koef:1)
        }
        for j in 2*s..<4*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+1, leftTo:4*j+3, right:4*j+1, koef:1)
        }
        for j in 4*s..<6*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+2, leftTo:4*(j+1), right:4*j+2, koef:1)
        }
    }
    private func createHH8() {
        let s = PathAlg.s, m = 2, ell = Int(deg / PathAlg.twistPeriod)
        makeZeroMatrix(9*s, h: 6*s)

        for j in s..<2*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j, leftTo:4*j, right:4*j, koef:PathAlg.k1J(ell, j:j, m:m))
        }
        for j in 2*s..<4*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+1, leftTo:4*j+1, right:4*j+1, koef:1)
        }
        for j in 5*s..<6*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:4*(j+s)+2, leftTo:4*(j+s)+2, right:4*(j+s)+2, koef:1)
        }
        for j in 7*s..<8*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:4*j+2, leftTo:4*j+2, right:4*j+2, koef:1)
        }
        for j in 8*s..<9*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:4*j+3, leftTo:4*j+3, right:4*j+3, koef:-PathAlg.k1J(ell, j:j, m:m))
        }
    }
    private func createHH9() {
        let s = PathAlg.s
        makeZeroMatrix(9*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:4, right:0, koef:1)
    }
    private func createHH10() {
        let s = PathAlg.s
        makeZeroMatrix(9*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:3, right:0, koef:1)
    }
    private func createHH11() {
        let s = PathAlg.s, m = 2, ell = Int(deg / PathAlg.twistPeriod)
        makeZeroMatrix(8*s, h: 6*s)

        for j in 0..<2*s {
            HHElem.addElemToHH(self, i:j%s, j:j, leftFrom:4*j, leftTo:4*j+1, right:4*j, koef:1)
        }
        for j in 2*s..<4*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+1, leftTo:4*(j+1), right:4*j+1, koef:PathAlg.k1JPlus1(ell, j:j, m:m))
        }
        for j in 4*s..<6*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+2, leftTo:4*j+3, right:4*j+2, koef:-PathAlg.k1J(ell, j:j, m:m))
        }
        for j in 6*s..<8*s {
            HHElem.addElemToHH(self, i:5*s+j%s, j:j, leftFrom:4*j+3, leftTo:4*(j+1)+2, right:4*j+3, koef:f1(j, 7*s))
        }
    }
    private func createHH12() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:4*s+1, right:0, koef:1)
        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:1, right:0, koef:1)
    }
    private func createHH13() {
        let s = PathAlg.s
        makeZeroMatrix(9*s, h: 6*s)

        for j in s..<2*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*(j+s)+1, leftTo:4*(j+s)+1, right:4*(j+s)+1, koef:1)
        }
        for j in 3*s..<4*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+1, leftTo:4*j+1, right:4*j+1, koef:1)
        }
        for j in 5*s..<7*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:4*(j+s)+2, leftTo:4*(j+s)+2, right:4*(j+s)+2, koef:1)
        }
        for j in 8*s..<9*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:4*j+3, leftTo:4*(j+1), right:4*j+3, koef:1)
        }
    }
    private func createHH14() {
        let s = PathAlg.s, m = 3, ell = Int(deg / PathAlg.twistPeriod)
        makeZeroMatrix(9*s, h: 6*s)

        for j in 0..<s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*j, leftTo:4*j, right:4*j, koef:PathAlg.k1J(ell, j:j, m:m))
        }
        for j in 2*s..<3*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+1, leftTo:4*j+2, right:4*j+1, koef:1)
        }
        for j in 4*s..<5*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:4*(j+s)+1, leftTo:4*(j+s)+2, right:4*(j+s)+1, koef:1)
        }
        for j in 7*s..<8*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:4*j+3, leftTo:4*j+3, right:4*j+3, koef:PathAlg.k1J(ell, j:j, m:m))
        }
    }
    private func createHH15() {
        let s = PathAlg.s
        makeZeroMatrix(9*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:4, right:0, koef:1)
    }
    private func createHH16() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:2, right:0, koef:1)
        HHElem.addElemToHH(self, i:s, j:2*s, leftFrom:1, leftTo:3, right:1, koef:1)
    }
    private func createHH17() {
        let s = PathAlg.s
        makeZeroMatrix(8*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:4*s+2, right:0, koef:1)
        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:2, right:0, koef:1)
    }
    private func createHH18() {
        let s = PathAlg.s, m = 4, ell = Int(deg / PathAlg.twistPeriod)
        makeZeroMatrix(6*s, h: 6*s)

        for j in s..<3*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*(j+s)+1, leftTo:4*(j+s)+2, right:4*(j+s)+1, koef:1)
        }
        for j in 5*s..<6*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*j+3, leftTo:4*(j+1), right:4*j+3, koef:-PathAlg.k1JPlus1(ell, j:j, m:m))
        }
    }
    private func createHH19() {
        let s = PathAlg.s
        makeZeroMatrix(7*s, h: 6*s)
        HHElem.addElemToHH(self, i:s, j:s, leftFrom:1, leftTo:4, right:1, koef:1)
        HHElem.addElemToHH(self, i:2*s, j:2*s, leftFrom:4*s+1, leftTo:4, right:4*s+1, koef:1)
    }
    private func createHH20() {
        let s = PathAlg.s, m = 4, ell = Int(deg / PathAlg.twistPeriod)
        makeZeroMatrix(7*s, h: 6*s)

        for j in 0..<s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*j, leftTo:4*j+3, right:4*j, koef:PathAlg.k1J(ell, j:j, m:m))
        }
        for j in s..<2*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*(j+s)+1, leftTo:4*(j+1), right:4*(j+s)+1, koef:-PathAlg.k1JPlus1(ell, j:j, m:m))
        }
        for j in 3*s..<4*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*(j+s)+2, leftTo:4*(j+s+1)+1, right:4*(j+s)+2, koef:1)
        }
        for j in 6*s..<7*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:4*j+3, leftTo:4*(j+1)+2, right:4*j+3, koef:1)
        }
    }
    private func createHH21() {
        let s = PathAlg.s, m = 5, ell = Int(deg / PathAlg.twistPeriod)
        makeZeroMatrix(6*s, h: 6*s)

        for j in 0..<s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*j, leftTo:4*j, right:4*j, koef:PathAlg.k1J(ell, j:j, m:m))
        }

        for j in 5*s..<6*s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:4*j+3, leftTo:4*j+3, right:4*j+3, koef:-PathAlg.k1J(ell, j:j, m:m))
        }
    }
    private func createHH22() {
        let s = PathAlg.s
        makeZeroMatrix(6*s, h: 6*s)
        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:4, right:0, koef:1)
    }
}
