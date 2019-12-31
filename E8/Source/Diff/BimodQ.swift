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

        var sz = f(m,2,11) + f(m,4,9)
        for i in 0 ... sz {
            p_ij += [(8*m-f(i,0)*(f(m,1,10)+f(m,13))-f(i,1)*(f(m,4)+f(m,11))-f(i,2)*(f(m,6)+f(m,8)), 0)]
        }
        sizes += [sz+1]

        for j in 0 ... 3 {
            sz = f(m+j,5)+f(m+j,7,10)+f(m+j,12)
            for i in 0 ... sz {
                p_ij += [(8*m+m+j+1
                    - f(i,0)*(5*f(m+j,6,9)+9*f(m+j,10,12)+8*f(m+j,13)+14*f(m+j,14,17))
                    - f(i,1)*(5*f(m+j,5)+3*f(m+j,7,8)+9*f(m+j,9)+5*f(m+j,10)+8*f(m+j,12)), 1+j)]
            }
            sizes += [sz+1]
        }

        for j in 0 ... 1 {
            sz = f(m+j,3,12)+f(m+j,5,10)
            for i in 0 ... sz {
                p_ij += [(8*m+m+j-1+6*f(m+j,0,1)
                    + f(i,0)*(f(m+j,5)-3*f(m+j,6)-5*f(m+j,8,9)-3*f(m+j,10)-8*f(m+j,11,15))
                    + f(i,1)*(3*f(m+j,3,4)+f(m+j,6)-3*f(m+j,7,8)-2*f(m+j,9)-5*f(m+j,10,12))
                    - f(i,2)*(3*f(m+j,5)+5*f(m+j,7)+2*f(m+j,8)+3*f(m+j,9)+8*f(m+j,10)), 5+j)]
            }
            sizes += [sz+1]
        }

        sz = f(m,3,12)+f(m,5,10)
        for i in 0 ... sz {
            p_ij += [(8*(m+1)-f(i,0)*(f(m,0)+f(m,2,11)+f(m,14))-f(i,1)*(f(m,5)+f(m,12))-f(i,2)*(f(m,7)+f(m,9)), 7)]
        }
        sizes += [sz+1]

        return (pij: p_ij, sizes: sizes)
    }

    private static func oddQ(_ m: Int) -> (pij: [(Int, Int)], sizes: [Int]) {
        var p_ij = [(Int, Int)]()
        var sizes = [Int]()

        var sz = f(m,0,12)+f(m,2,10)+f(m,3,9)+f(m,5)+f(m,7)
        for i in 0 ... sz {
            p_ij += [(8*m+f(i,0)*(2-f(m,0)+3*f(m,2)+3*f(m,4)+f(m,7)+f(m,9)+f(m,11)+2*f(m,12)+5*f(m,13)+6*f(m,14))
                + f(i,1)*(6-f(m,0)-3*f(m,2)-2*f(m,3)-3*f(m,4)-3*f(m,6)-2*f(m,8)-2*f(m,10)-f(m,11))
                + f(i,2)*(6-5*f(m,2)-2*f(m,5)-2*f(m,7)-5*f(m,9))
                + f(i,3)*(5-4*f(m,4,5)-4*f(m,7))+5*f(i,4), 0)]
        }
        sizes += [sz+1]

        for j in 0 ... 3 {
            sz = f(m+j,8)
            for i in 0 ... sz {
                p_ij += [(8*m+7-5*f(m+j,0)-4*f(m+j,1)-3*f(m+j,2)+f(m+j,4)+f(m+j,6)+f(m+j,9)
                    + f(m+j,11)+f(m+j,13)+2*f(m+j,14)+3*f(m+j,15)+4*f(m+j,16)+f(i,1)*f(m+j,8), 1+j)]
            }
            sizes += [sz+1]
        }

        for j in 0 ... 1 {
            sz = f(m+j,4,10)
            for i in 0 ... sz {
                p_ij += [(8*m+7-f(m+j,0)+f(m+j,2)+f(m+j,8)+f(m+j,11)+f(m+j,13)+6*f(m+j,14)+f(i,1)*(1-2*f(m+j,8)), 5+j)]
            }
            sizes += [sz+1]
        }

        sz = f(m,1,13)+f(m,3,11)+f(m,4,10)+f(m,6)+f(m,8)
        for i in 0 ... sz {
            p_ij += [(8*(m+1)+f(i,0)*(2-2*f(m,0)-f(m,1)+3*f(m,3)+3*f(m,5)+f(m,8)+f(m,10)+f(m,12)+2*f(m,13)+5*f(m,14))
                + f(i,1)*(6-f(m,1)-3*f(m,3)-2*f(m,4)-3*f(m,5)-3*f(m,7)-2*f(m,9)-2*f(m,11)-f(m,12))
                + f(i,2)*(6-5*f(m,3)-2*f(m,6)-2*f(m,8)-5*f(m,10))
                + f(i,3)*(5-4*f(m,5,6)-4*f(m,8))+5*f(i,4), 7)]
        }
        sizes += [sz+1]

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
