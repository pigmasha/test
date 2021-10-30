//
//  Created by M on 02.10.2021.
//

import Foundation

struct Step_1_calc_s {
    static let printHomos = false

    static func runCase() -> Bool {
        for d in 0 ..< 30 {
            let d1 = PDiff(deg: d)
            let d2 = PDiff(deg: d + 1)
            let m = PMatrix(mult: d1, and: d2)
            if !m.isZero { return true }
            /*let ker = PKer.ker(d1)
            let im = PKer.im(d2)
            let myKer = PMyKer.ker(d)
            OutputFile.writeLog(.normal, "\(d): " + ker.htmlStr + "<br>" + im.htmlStr)
            if ker.htmlStr != myKer.htmlStr {
                OutputFile.writeLog(.error, "   Ker: \(ker.htmlStr)")
                OutputFile.writeLog(.error, "My Ker: \(myKer.htmlStr)")
            }*/
            if printHomos {
                OutputFile.writeLog(.normal, "d<sub>\(d)</sub>: Q<sub>\(d+1)</sub> &rarr; Q<sub>\(d)</sub>")
                PrintUtils.printPMatrix("", d1)
            }
        }
        return false
    }
}
