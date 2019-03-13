//
//  Created by M on 03.06.2018.
//

import Foundation

final class BimodQ {
    let pij: [IntPair]
    let sizes: [NumInt]

    init(deg: Int) {
        let s = PathAlg.s
        let d = deg % PathAlg.twistPeriod
        let m = Int(d / 2)
        let q = d % 2 == 0 ? BimodQ.evenQ(m) : BimodQ.oddQ(m)
        let r = Int(deg / PathAlg.twistPeriod)
        var ij = [IntPair]()
        for pij in q.pij {
            for r0 in 0 ..< s {
                let pair = IntPair(n0: 4*r0+pij.n0, n1: 4*r0+pij.n1)
                for _ in 0 ..< r { pair.n0 = PathAlg.sigma(pair.n0) }
                ij += [pair]
            }
        }
        self.sizes = q.sizes
        self.pij = ij
    }

    private static func evenQ(_ m: Int) -> (pij: [IntPair], sizes: [NumInt]) {
        var p_ij = [IntPair]()
        var sizes = [NumInt]()

        let s = PathAlg.s
        var sz = 1 + f(m, 2) + f(m, 3) + f(m, 4) + f(m, 5)
        for i in 0 ..< sz {
            p_ij += [IntPair(n0: 4*m-1+h(m,2)+i, n1: 0)]
        }
        sizes += [NumInt(intValue: sz)]

        for j in 0 ... 1 {
            sz = 1 + f(m, 3)
            for i in 0 ..< sz {
                p_ij += [IntPair(n0: 4*(m+j*s+(f(m,2)+f(m,5))*s)+2-h(m,3)+i*(4*s+1), n1: 4*j*s+1)]
            }
            sizes += [NumInt(intValue: sz)]
        }

        for j in 0 ... 1 {
            sz = 1 + f(m, 2)
            for i in 0 ..< sz {
                p_ij += [IntPair(n0: 4*(m+j*s+(f(m,1)+f(m,4)+f(m,5))*s)+1+h(m,2)+i*(4*s+1), n1: 4*j*s+2)]
            }
            sizes += [NumInt(intValue: sz)]
        }

        sz = 1 + f(m, 3)
        for i in 0 ..< sz {
            p_ij += [IntPair(n0: 4*(m+1)-h(m,3)+i, n1: 3)]
        }
        sizes += [NumInt(intValue: sz)]

        return (pij: p_ij, sizes: sizes)
    }

    private static func oddQ(_ m: Int) -> (pij: [IntPair], sizes: [NumInt]) {
        var p_ij = [IntPair]()
        var sizes = [NumInt]()

        let s = PathAlg.s
        for i in 0 ... 1 - f(m, 4) {
            p_ij += [IntPair(n0: 4*m+1+h(m,0)+2*f(m,4)+4*s*i, n1: 0)]
        }
        sizes += [NumInt(intValue: 2 - f(m, 4))]

        for j in 0 ... 1 {
            p_ij += [IntPair(n0: 4*(m+1+j*s)-h(m,0)-2*f(m,0), n1: 4*j*s+1)]
        }
        for j in 0 ... 1 {
            p_ij += [IntPair(n0: 4*(m+1+j*s+f(m,4)*s)-h(m,5)+2*f(m,4), n1: 4*j*s+2)]
        }
        sizes += [NumInt(intValue: 1), NumInt(intValue: 1), NumInt(intValue: 1), NumInt(intValue: 1)]

        for i in 0 ... 1 - f(m, 0) {
            p_ij += [IntPair(n0: 4*(m+1)+1+h(m,5)-2*f(m,0)+4*s*i, n1: 3)]
        }
        sizes += [NumInt(intValue: 2 - f(m, 0))]

        return (pij: p_ij, sizes: sizes)
    }

    var html: String {
        let s = PathAlg.s
        var str = "<big>(</big>"
        var sPos = 0
        var sIn = 0

        for i in 0 ..< pij.count {
            let p = pij[i]
            str += "P<sub>\(p.n0),\(p.n1)</sub>"
            sIn += 1
            if sIn == sizes[sPos].intValue * s {
                sIn = 0
                sPos += 1
                str += "<big>)</big>"
                if i < pij.count - 1 { str += "&bull;<big>(</big>" }
            } else {
                if i < pij.count - 1 { str += "&bull; " }
            }
        }
        return str + "<br>\n"
    }
}
