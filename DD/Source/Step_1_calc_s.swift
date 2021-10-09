//
//  Created by M on 02.10.2021.
//

import Foundation

struct Step_1_calc_s {
    static let printHomos = true

    static func runCase() -> Bool {
        OutputFile.writeLog(.bold, "k=\(PathAlg.k), c=\(PathAlg.c), d=\(PathAlg.d), char=\(PathAlg.charK)")
        var homos: [PHomo] = []
        let lastHomo = PHomo(matrix: [[Element(way: Way(type: .x, len: 1), koef: 1),
                                       Element(way: Way(type: .y, len: 1), koef: 1)]])
        homos.append(lastHomo)
        let ker = PKer.ker(lastHomo, onlyGen: true)
        let myKer = PMyKer.ker(0)
        if ker.htmlStr != myKer.htmlStr {
            OutputFile.writeLog(.error, "   Ker: \(ker.htmlStr)")
            OutputFile.writeLog(.error, "My Ker: \(myKer.htmlStr)")
        }

        if printHomos {
            for i in 0 ..< homos.count {
                OutputFile.writeLog(.normal, "d<sub>\(i)</sub>: Q<sub>\(i+1)</sub> &rarr; Q<sub>\(i)</sub>")
                homos[i].matrix.forEach {
                    OutputFile.writeLog(.normal, $0.map { $0.str }.joined(separator: " "))
                }
            }
        }
        return false
    }
}
