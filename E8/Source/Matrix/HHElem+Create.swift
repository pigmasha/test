
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

        for j in 0 ..< s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j+5, right:8*j, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+3, right:8*j, koef:-1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j, leftTo:8*j+1, right:8*j, koef:-1)
        }
        for j in 3*s ..< 4*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+1, leftTo:8*j+4, right:8*j+1, koef:1)
        }
        for j in 4*s ..< 5*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+2, leftTo:8*j+7, right:8*j+2, koef:1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+3, leftTo:8*(j+1), right:8*j+3, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+4, leftTo:8*j+7, right:8*j+4, koef:1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+5, leftTo:8*(j+1), right:8*j+5, koef:1)
        }
        for j in 8*s ..< 9*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+6, leftTo:8*j+7, right:8*j+6, koef:1)
        }
        for j in 9*s ..< 10*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+2, right:8*j+7, koef:-1)
        }
        for j in 10*s ..< 11*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+6, right:8*j+7, koef:-1)
        }
    }
    /*private func createHH5() {
        let s = PathAlg.s
        makeZeroMatrix(11*s, h: 8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j+5, right:8*j, koef:1)
        }
        for j in s ..< 2*s {
            HHElem.addElemToHH(self, i:j-s, j:j, leftFrom:8*j, leftTo:8*j+3, right:8*j, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j, leftTo:8*j+1, right:8*j, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+3, leftTo:8*(j+1), right:8*j+3, koef:1)
        }
        for j in 6*s ..< 7*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+4, leftTo:8*j+7, right:8*j+4, koef:-1)
        }
        for j in 7*s ..< 8*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j+5, leftTo:8*(j+1), right:8*j+5, koef:1)
        }
    }*/
    private func createHH6() {
        let s = PathAlg.s
        makeZeroMatrix(13*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:7, right:0, koef:1)
    }
    private func createHH7() {
        let s = PathAlg.s
        makeZeroMatrix(14*s, h: 8*s)

        for j in 0 ..< s {
            HHElem.addElemToHH(self, i:j, j:j, leftFrom:8*j, leftTo:8*j+2, right:8*j, koef:1)
        }
        for j in 2*s ..< 3*s {
            HHElem.addElemToHH(self, i:j-2*s, j:j, leftFrom:8*j, leftTo:8*j+6, right:8*j, koef:-1)
        }
        for j in 5*s ..< 6*s {
            HHElem.addElemToHH(self, i:j-3*s, j:j, leftFrom:8*j+2, leftTo:8*(j+1), right:8*j+2, koef:-1)
        }
        for j in 13*s ..< 14*s {
            HHElem.addElemToHH(self, i:j-6*s, j:j, leftFrom:8*j+7, leftTo:8*(j+1)+1, right:8*j+7, koef:-1)
        }
    }
    private func createHH8() {
        let s = PathAlg.s
        makeZeroMatrix(16*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:7, right:0, koef:1)
    }
    private func createHH9() {
    }
    private func createHH10() {
    }
    private func createHH11() {
    }
    private func createHH12() {
        let s = PathAlg.s
        makeZeroMatrix(18*s, h: 8*s)

        HHElem.addElemToHH(self, i:0, j:0, leftFrom:0, leftTo:2, right:0, koef:-1)
        HHElem.addElemToHH(self, i:0, j:s, leftFrom:0, leftTo:6, right:0, koef:1)
        HHElem.addElemToHH(self, i:2*s, j:6*s, leftFrom:2, leftTo:8, right:2, koef:1)
    }
    private func createHH13() {
    }
    private func createHH14() {
    }
    private func createHH15() {
    }
    private func createHH16() {
    }
    private func createHH17() {
    }
    private func createHH18() {
    }
    private func createHH19() {
    }
    private func createHH20() {
    }
    private func createHH21() {
    }
    private func createHH23() {
    }
    private func createHH24() {
    }
    private func createHH22() {
    }
    private func createHH25() {
    }
    private func createHH26() {
    }
    private func createHH27() {
    }
    private func createHH28() {
    }
    private func createHH29() {
    }
    private func createHH30() {
    }
    private func createHH31() {
    }
    private func createHH32() {
    }
    private func createHH33() {
    }
    private func createHH34() {
    }
    private func createHH35() {
    }
    private func createHH36() {
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
