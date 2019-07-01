//
//  Created by M on 02.04.17.
//

struct Step_7_createhh {
    static func runCase() -> Bool {
        // s == 1 .. 10
        OutputFile.writeLog(.time, "S=\(PathAlg.s), Char=\(PathAlg.charK) (types \(Dim.typeMax))")
        for deg in 0...10 * PathAlg.s * PathAlg.twistPeriod + 2 {
            if process(deg: deg) {
                return true
            }
        }
        return false
    }

    private static func process(deg: Int) -> Bool {
        var hhElements: [HHElem] = []
        for type in 1...Dim.typeMax {
            if PathAlg.alg.currentType > 0 && type != PathAlg.alg.currentType { continue }
            guard Dim.deg(deg, hasType: type) else { continue }
            let ell = deg / PathAlg.twistPeriod
            let hh = HHElem(deg: deg, type: type)
            if (!CheckHH.checkHHElem(hh, degree: deg, logError: true)) {
                OutputFile.writeLog(.error, "type=\(type), ell=\(ell)")
                PrintUtils.printMatrix("Bad HH", hh)
                return true
            } else {
                OutputFile.writeLog(.normal, "type=\(type): HH (ell=\(ell)): checked :)")
            }
            hhElements += [hh]
        }
        if hhElements.count < 2 { return false }
        for i in 0 ..< hhElements.count - 1 {
            for j in i + 1 ..< hhElements.count {
                guard let checkResult = CheckHH.checkHHElemNotSame(hhElements[i], hhElements[j], degree: deg) else {
                    OutputFile.writeLog(.error, "Check same error, deg=\(deg)")
                    PrintUtils.printMatrix("HH1", hhElements[i])
                    PrintUtils.printMatrix("HH2", hhElements[j])
                    return true
                }
                if checkResult == false {
                    OutputFile.writeLog(.error, "Same elements, deg=\(deg)")
                    PrintUtils.printMatrix("HH1", hhElements[i])
                    PrintUtils.printMatrix("HH2", hhElements[j])
                    return true
                }
            }
        }
        return false
    }
}
