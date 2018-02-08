//
//  Created by M on 02.04.17.
//
//

struct Step_10_createhh {
    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "N=%d, S=%d, Char=%d (types %d)",  PathAlg.n, PathAlg.s, PathAlg.charK, 22)
        for type in 1...22 {
            if (type == RunCase.kCurrentType && process(type: type)) {
                return true
            }
        }
        return false
    }

    private static func process(type: Int) -> Bool {
        for deg in 1...30 * PathAlg.twistPeriod + 2 {
            guard Dim.deg(deg, hasType: type) else { continue }
            
            let ell = deg / PathAlg.twistPeriod
            let hh = HHElem(deg: deg, type: type)
            OutputFile.writeLog(.bold, "type=\(type): HH (ell=\(ell))")
            if (!CheckHH.checkHHElem(hh, degree: deg)) {
                PrintUtils.printMatrix("Bad HH", hh)
                return true
            }
        }
        return false
    }
}
