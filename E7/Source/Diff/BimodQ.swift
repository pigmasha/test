//
//  Created by M on 03.06.2018.
//

import Foundation

final class BimodQ {
    let pij: [(Int, Int)]
    let sizes: [Int]

    init(deg: Int) {
        let n = PathAlg.n
        let s = PathAlg.s
        let d = deg % PathAlg.twistPeriod
        let m = Int(d / 2)
        let q = d % 2 == 0 ? BimodQ.evenQ(m) : BimodQ.oddQ(m)
        let twistDeg = Int(deg / PathAlg.twistPeriod)
        var ij: [(Int, Int)] = []
        for pij in q.pij {
            for r in 0 ..< s {
                var n0 = n*r+pij.0
                for _ in 0 ..< twistDeg { n0 = PathAlg.sigma(n0) }
                ij += [(myMod(n0, mod: n*s), pij.1+n*r)]
            }
        }
        self.sizes = q.sizes
        self.pij = ij
    }

    private static func evenQ(_ m: Int) -> (pij: [(Int, Int)], sizes: [Int]) {
        var p_ij = [(Int, Int)]()
        var sizes = [Int]()

        var sz = 1+f(m,2,5)
        for i in 0 ..< sz {
            p_ij += [(7*m-f(i,0)*(1-f(m,0)-f(m,6)-f(m,8)), 0)]
        }
        sizes += [sz]

        for j in 0 ... 2 {
            sz = 1+f(m+j,4)+f(m+j,6)
            for i in 0 ..< sz {
                p_ij += [(7*m+m+1+j-4*f(i,0)*f(m+j,4,5)-f(m+j,6)*(f(i,0)+3)-3*f(m+j,7)-8*f(m+j,8,10), 1+j)]
            }
            sizes += [sz]
        }

        for j in 0 ... 1 {
            sz = 1+f(m+j,3,6)
            for i in 0 ..< sz {
                p_ij += [(7*m+m+4+j-5*f(m+j,2)-f(m+j,3,4)*(2*f(i,0)+3)-f(m+j,5)*(3*f(i,1)+5)-f(m+j,6)*(3*f(i,0)+5)-8*f(m+j,7,9), 4+j)]
            }
            sizes += [sz]
        }

        sz = 1+f(m,3,6)
        for i in 0 ..< sz {
            p_ij += [(7*m+6+f(i,0)*(f(m,1)+f(m,7))+f(i,1), 6)]
        }
        sizes += [sz]

        return (pij: p_ij, sizes: sizes)
    }

    private static func oddQ(_ m: Int) -> (pij: [(Int, Int)], sizes: [Int]) {
        var p_ij = [(Int, Int)]()
        var sizes = [Int]()

        var sz = 2+f(m,2,4)-f(m,7)
        for i in 0 ..< sz {
            p_ij += [(7*m+m+1+3*f(i,1)*f(m,0,1)+f(m,2)*(f(i,0)-2*f(i,2))+f(m,3)*(f(i,1)-2*f(i,0))-2*f(m,4)*(f(i,1)+2*f(i,2))-2*f(m,5,6)*(1+f(i,0))-2*f(m,7), 0)]
        }
        sizes += [sz]

        for j in 0 ... 2 {
            p_ij += [(7*m+m+j+2+2*f(m+j,2,3)-2*f(m+j,6,9), 1+j)]
            sizes += [1]
        }

        for j in 0 ... 1 {
            sz = 1+f(m+j,4)
            for i in 0 ..< sz {
                p_ij += [(7*m+m+j+5-2*f(m+j,3)-f(m+j,4)*(2+f(i,0))-3*f(m+j,5)-5*(f(m+j,6)+f(m+j,7))-2*f(m+j,8), 4+j)]
            }
            sizes += [sz]
        }

        sz = 2+f(m,3,5)-f(m,0)
        for i in 0 ..< sz {
            p_ij += [(7*(m+1)+m+3*f(m,1,2)*f(i,1)+f(m,3)*(f(i,0)-2*f(i,2))+f(m,4)*(f(i,1)-2*f(i,0))-2*f(m,5)*(f(i,1)+2*f(i,2))-2*f(m,6,7)*(2*f(i,0)+f(i,1)), 6)]
        }
        sizes += [sz]

        return (pij: p_ij, sizes: sizes)
    }

    var ppp: [(Int, Int)] {
        return pij
    }

    var html: String {
        let s = PathAlg.s
        var str = "<big>(</big>"
        var sPos = 0
        var sIn = 0

        for i in 0 ..< pij.count {
            let p = pij[i]
            str += "P<sub>\(p.0),\(p.1)</sub>"
            sIn += 1
            if sIn == sizes[sPos] * s {
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
