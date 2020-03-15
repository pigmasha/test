//
//  E8
//  Created by M on 13/03/2020.
//

import Foundation

struct Step_4_dimhom {
    static func runCase() -> Bool {
        let s = PathAlg.s
        OutputFile.writeLog(.bold, "s=\(s)")

        let degMax = 50 * s * PathAlg.twistPeriod
        for deg in 0 ..< degMax {
            let q = BimodQ(deg: deg)
            var lengthes: [[Int]] = []
            var prevSum = 0
            var parts: [Int: Int] = [:]
            for nSq in 0 ..< q.sizes.count {
                let sz = q.sizes[nSq]
                var ll: [Int] = []
                for j in 0 ..< sz * s {
                    let p = q.pij[prevSum + j]
                    let w = Way(from: p.1, to: p.0)
                    if w.isZero { continue }
                    ll.append(w.len)
                    parts[p.1 % 8] = (parts[p.1 % 8] ?? 0) + 1
                    if w.len == 0 {
                        let w2 = Way(from: p.1, to: p.0, noZeroLen: true)
                        if !w2.isZero {
                            ll.append(w2.len)
                            parts[p.1 % 8] = (parts[p.1 % 8] ?? 0) + 1
                        }
                    }
                }
                prevSum += sz * s
                lengthes.append(ll)
            }
            if lengthes.count != PathAlg.n {
                OutputFile.writeLog(.error, "Bad lengthes count = \(lengthes.count)")
                return true
            }

            var deg2 = 0
            for item in lengthes { deg2 += item.count }

            let myDeg = Dim.dimHom(deg)
            if deg2 != myDeg {
                OutputFile.writeLog(.error, "Bad dimHom=\(myDeg) (must be \(deg2 / s)s), deg=\(deg) (\(deg % PathAlg.twistPeriod))")
                return true
            }
        }
        return false
    }
}

