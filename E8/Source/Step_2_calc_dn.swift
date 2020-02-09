//
//  Created by M on 02.07.17.
//

struct Step_2_calc_dn {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=\(PathAlg.n), S=\(PathAlg.s), Char=\(PathAlg.charK)")
        /*if CalcDiffAll.calcDiffAllVariants() == false {
            return true
        }*/
        if checkTwist() { return true }
        let degTo = PathAlg.alg.dummy1 == 0 ? 2 * PathAlg.twistPeriod + 3 : PathAlg.alg.dummy1
        for deg in 0 ..< degTo {
            let prevDiff = deg == 0 ? nil : Diff(deg: deg - 1)
            let diff = Diff(deg: deg)
            let res = CalcDiff.calcDiffWithNumber(diff, deg: deg, prevDiff: prevDiff)
            if res != 0 {
                OutputFile.writeLog(.error, "deg=\(deg): error \(res)!")
                return true
            }

            if let prevDiff = prevDiff {
                let multRes = Matrix(mult: prevDiff, and: diff)
                if multRes.isNil {
                    OutputFile.writeLog(.error, "deg=\(deg): mult is nil!")
                    return true
                }
                if !multRes.isZero {
                    OutputFile.writeLog(.error, "deg=\(deg): mult no zero!")
                    return true
                }
            }
        }
        return false
    }

    private static func checkTwist() -> Bool {
        for v1 in 0 ..< PathAlg.vertexMod {
            for v2 in 0 ..< PathAlg.vertexMod {
                let w = Way(from: v1, to: v2)
                if w.isZero || w.len != 1 { continue }
                let c = Comb(tenzor: Tenzor(left: w, right: Way(from: v1, to: v1)), koef: 1)
                c.twist()
                let w1 = c.terminateTenzor(isLast: true)!.leftComponent
                let w2 = Way(from: w1.startsWith.number, to: w1.endsWith.number)
                if w2.isZero || w2.len != 1 {
                    OutputFile.writeLog(.error, "checkTwist: bad way len \(w2.str)")
                    return true
                }
                if w1.arrays[0].type != w2.arrays[0].type {
                    OutputFile.writeLog(.error, "checkTwist: bad way type \(w2.str) & \(w1.str)")
                    return true
                }
                let i1 = w1.arrays[0].i
                let i2 = w2.arrays[0].i
                let s = PathAlg.s
                switch w1.arrays[0].type {
                case .alpha:
                    if myMod(i1 - i2, mod: 5*s) != 0 {
                        OutputFile.writeLog(.error, "checkTwist: bad way index \(w2.str) & \(w1.str)")
                        return true
                    }
                case .beta:
                    if myMod(i1 - i2, mod: 3*s) != 0 {
                        OutputFile.writeLog(.error, "checkTwist: bad way index \(w2.str) & \(w1.str)")
                        return true
                    }
                case .gamma:
                    if myMod(i1 - i2, mod: s) != 0 {
                        OutputFile.writeLog(.error, "checkTwist: bad way index \(w2.str) & \(w1.str)")
                        return true
                    }
                }

            }
        }
        return false
    }
}
