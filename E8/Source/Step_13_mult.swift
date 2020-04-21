//
//  Created by M on 22.07.2018.
//

import Foundation

struct Step_13_mult {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "S=\(PathAlg.s), Char=\(PathAlg.charK)")

        var hasError = false
        let type = PathAlg.alg.currentType
        for type1 in 1 ... Dim.typeMax2 {
            if type > 0 && type1 != type { continue }
            for type2 in type1 ... Dim.typeMax2 {
                if process(type1: type1, type2: type2) {
                    hasError = true
                }
            }
        }
        return hasError
    }

    private static func process(type1: Int, type2: Int) -> Bool {
        OutputFile.writeLog(.bold, "Types \(type1) * \(type2)")
        let kk = PathAlg.s == 1 ? 25 : 5
        for deg1 in 0...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
            guard Dim.deg(deg1, hasType: type1) else {
                continue
            }
            for deg2 in 0...kk * PathAlg.s * PathAlg.twistPeriod + 2 {
                guard Dim.deg(deg2, hasType: type2) else {
                    continue
                }
                let mm = multRes(type1, type2, deg1, deg2)
                if let type = mm?.type, !Dim.deg(deg1 + deg2, hasType: type) {
                    OutputFile.writeLog(.bold, "k=\(type1) * \(type2) has no type \(type) (degs \(deg1) & \(deg2))")
                    return true
                }
                guard process(type1: type1, type2: type2, type: mm?.type ?? 0, deg1: deg1, deg2: deg2, koef: mm?.koef ?? 0) else {
                    continue
                }
                if let mm = mm {
                    let koefs = PathAlg.charK == 2 ? [0, 1] : [0, 1, -1, 3, -3]
                    koefs.forEach { kk in
                        if mm.koef != kk && !process(type1: type1, type2: type2, type: mm.type, deg1: deg1, deg2: deg2, koef: kk) {
                            OutputFile.writeLog(.bold, "k=\(kk) is ok")
                        }
                    }
                } else {
                    for t in 1 ... Dim.typeMax2 {
                        if Dim.deg(deg1 + deg2, hasType: t) {
                            OutputFile.writeLog(.bold, "k=\(type1) * \(type2) has type \(t)")
                            return true
                        }
                    }
                }
                return true
            }
        }
        return false
    }

    private static func process(type1: Int, type2: Int, type: Int, deg1: Int, deg2: Int, koef: Int) -> Bool {
        guard type == 0 || Dim.deg(deg1 + deg2, hasType: type) else {
            OutputFile.writeLog(.error, "\(deg1) + \(deg2) not type \(type)")
            return true
        }
        let multRes = Matrix(mult: HHElem(deg: deg2, type: type2),
                             and: ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))

        if koef != 0 {
            let hh = HHElem(deg: deg1 + deg2, type: type)
            hh.compKoef(-koef)
            multRes.addMatrix(hh)
        }

        let r = CheckHH.checkForIm(multRes, degree: deg1 + deg2, shouldBeInIm: true, logError: false)
        switch r {
        case .inIm:
            break
            //OutputFile.writeLog(.normal, "\(deg1) * \(deg2) OK")
        case .notInIm:
            //PrintUtils.printMatrix("hh", HHElem(deg: deg2, type: type2))
            //PrintUtils.printMatrix("shift", ShiftHHElem.shiftForType(type1).shift(degree: deg1, shift: deg2))
            //PrintUtils.printMatrix("multRes", multRes)
            OutputFile.writeLog(.error, "\(deg1) * \(deg2) not in im (koef=\(koef))")
        case .failed:
            OutputFile.writeLog(.error, "\(deg1) * \(deg2) failed")
        }
        return r != .inIm
    }

    private static func multRes(_ type1: Int, _ type2: Int, _ deg1: Int, _ deg2: Int) -> (type: Int, koef: Int)? {
        if type1 == 1 {
            if type2 >= 29 {
                return deg1 == 0 ? (type2, 1) : nil
            } else {
                return (type2, 1)
            }
        }
        return tableMultRes(type1, type2)
    }

    private static func tableMultRes(_ type1: Int, _ type2: Int) -> (type: Int, koef: Int)? {
        guard let path = Bundle.main.path(forResource: "m", ofType: "txt") else { return nil }
        guard let s = try? String(contentsOfFile: path, encoding: .utf8) else { return nil }
        let lines = s.components(separatedBy: "\n")
        for line in lines {
            let parts = line.components(separatedBy: "|")
            guard parts.count > 10 else { continue }
            guard let t1 = Int(parts[0].trimmingCharacters(in: .whitespaces)) else { continue }
            guard t1 == type1 else { continue }
            guard parts.count > type2 else { continue }
            let pp = parts[type2].trimmingCharacters(in: .whitespaces).components(separatedBy: ",")
            guard pp.count > 1 else { return nil }
            if pp.count == 3 {
                let pp2 = pp[2].components(separatedBy: "=")
                if pp2[0] == "ch" && PathAlg.charK != Int(pp2[1])! { return nil }
            }
            return (Int(pp[0])!, kk(pp[1]))
        }
        return nil
    }

    private static func kk(_ s: String) -> Int {
        if s == "s" { return PathAlg.s }
        if s == "-s" { return -PathAlg.s }
        if s == "2s" { return 2*PathAlg.s }
        if s == "-2s" { return -2*PathAlg.s }
        return Int(s)!
    }
}
