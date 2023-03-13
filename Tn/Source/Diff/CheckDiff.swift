//
//  Created by M on 26.02.2023.
//

import Foundation

struct CheckDiff {
    static func checkElem(_ matrix: Matrix, degFrom: Int, degTo: Int) -> Bool {
        let qFrom = BimodQ(deg: degFrom)
        let qTo = BimodQ(deg: degTo)
        guard matrix.height == qTo.pij.count else {
            OutputFile.writeLog(.error, "checkElem: wrong number of rows")
            return false
        }
        guard matrix.width == qFrom.pij.count else {
            OutputFile.writeLog(.error, "checkElem: wrong number of columns")
            return false
        }
        for i in 0 ..< matrix.height {
            for j in 0 ..< matrix.width {
                let c = matrix.rows[i][j]
                guard !c.isZero else { continue }
                let t = c.contents[0].1
                guard t.leftComponent.endVertex == qFrom.pij[j].0 else {
                    OutputFile.writeLog(.error, "checkElem: bad way at pos \(i), \(j) "
                        + "(left ends in \(t.leftComponent.endVertex), must be \(qFrom.pij[j].0))")
                    return false
                }
                guard t.leftComponent.startVertex == qTo.pij[i].0 else {
                    OutputFile.writeLog(.error, "checkElem: bad way at pos \(i), \(j) "
                        + "(left starts in \(t.leftComponent.startVertex), must be \(qTo.pij[i].0))")
                    return false
                }
                guard t.rightComponent.endVertex == qTo.pij[i].1 else {
                    OutputFile.writeLog(.error, "checkElem: bad way at pos \(i), \(j) "
                        + "(right ends in \(t.rightComponent.startVertex), must be \(qTo.pij[i].1))")
                    return false
                }
                guard t.rightComponent.startVertex == qFrom.pij[j].1 else {
                    OutputFile.writeLog(.error, "checkElem: bad way at pos \(i), \(j) "
                        + "(right starts in \(t.rightComponent.endVertex), must be \(qFrom.pij[j].1))")
                    return false
                }
            }
        }
        return true
    }
}
