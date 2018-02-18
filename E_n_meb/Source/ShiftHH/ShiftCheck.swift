//
//  Created by M on 12.11.17.
//
//

struct ShiftCheck {
    static func checkHH(_ hh: HHElem, hhShift: HHElem, degree: Int, shift: Int) -> Bool {
        guard shift > 0 else {
            let result = hh.isEq(hhShift, debug: true)
            if result {
                OutputFile.writeLog(.normal, "checked shift \(shift) :)")
            }
            return result
        }
        let dUp = Diff(deg: degree + shift - 1)
        let dDown = Diff(deg: shift - 1)
        let multRes = Matrix(mult: hh, and: dUp)
        let multResShift = Matrix(mult: dDown, and: hhShift)

        let result: Bool
        if multRes.isNil || multResShift.isNil || !multRes.isEq(multResShift, debug: true) {
            let columns = multRes.differentColumns(multResShift)
            OutputFile.writeLog(.error, "checkHHMatrix error!")
            //PrintUtils.printMatrix("multRes", multRes, redColumns: columns)
            //PrintUtils.printMatrix("multResShift", multResShift)
            //PrintUtils.printMatrix("dDown", dDown)
            PrintUtils.printMatrix("hhShift", hhShift, redColumns: columns)
            //PrintUtils.printMatrix("hh", hh)
            //PrintUtils.printMatrix("* dUp", dUp, redColumns: columns)
            //PrintUtils.printMatrix("* dUp (no twist)", Diff(deg: (degree + shift - 1) % 11), redColumns: columns)
            OutputFile.writeLog(.error, "Differents: \(multRes.numberOfDifferents(multResShift))")
            result = false
        } else {
            OutputFile.writeLog(.normal, "checked shift \(shift) :)")
            result = true
        }
        return result
    }
}