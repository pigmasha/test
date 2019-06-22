//
//  Created by M on 12.11.17.
//

struct ShiftCheck {
    static func checkHH(_ hh: HHElem, hhShift: HHElem, degree: Int, shift: Int, detailLog: Bool) -> Bool {
        guard shift > 0 else {
            let result = hh.isEq(hhShift, debug: true)
            if result {
                OutputFile.writeLog(.normal, "checked shift \(shift) :)")
            } else {
                let columns = hh.differentColumns(hhShift)
                 PrintUtils.printMatrix("hhShift", hhShift, redColumns: columns)
            }
            return result
        }
        let dUp = Diff(deg: degree + shift - 1)
        let dDown = Diff(deg: shift - 1)
        let multRes = Matrix(mult: hh, and: dUp)
        let multResShift = Matrix(mult: dDown, and: hhShift)

        let failed = multRes.isNil || multResShift.isNil || !multRes.isEq(multResShift, debug: true)

        guard failed else {
            OutputFile.writeLog(.normal, "checked shift \(shift) :)")
            return true
        }

        let columns = multRes.differentColumns(multResShift)
        //let rows = multRes.differentRows(multResShift)
        OutputFile.writeLog(.error, "checkHHMatrix error!")
        guard detailLog else {
            PrintUtils.printMatrix("hhShift", hhShift, redColumns: columns)
            return false
        }

        //PrintUtils.printMatrix("dDown \(shift - 1) (\((shift - 1) % PathAlg.twistPeriod))", dDown, redRows: rows)
        //PrintUtils.printMatrix("dDown (no twist)", Diff(deg: (shift - 1) % 11), redRows: rows)
        PrintUtils.printMatrix("hhShift", hhShift, redColumns: columns)
        PrintUtils.printMatrix("multRes", multRes, redColumns: columns)
        PrintUtils.printMatrix("multResShift", multResShift, redColumns: columns)
        //hhShift.twist(shift, backward: true); PrintUtils.printMatrix("hhShift (no twist)", hhShift, redColumns: columns)
        //PrintUtils.printMatrix("hh", hh)
        //hh.twist(shift - 1, backward: true); PrintUtils.printMatrix("hh (no twist)", hh, redRows: rows)
        //PrintUtils.printMatrix("* dUp \(degree + shift - 1) (\((degree + shift - 1) % PathAlg.twistPeriod))",
        //    dUp, redColumns: columns)
        //PrintUtils.printMatrix("* dUp (no twist)", Diff(deg: (degree + shift - 1) % 11), redColumns: columns)
        OutputFile.writeLog(.error, "Differents: \(multRes.numberOfDifferents(multResShift))")
        return false
    }
}
