//
//  Created by M on 24.04.16.
//
//

import Foundation

class Matrix : NSObject {
    private var combs: [[Comb]]

    override init() {
        combs = [[Comb]]()
        super.init()
    }

    convenience init(zeroMatrix width: Int, h height: Int) {
        self.init()
        makeZeroMatrix(width, h: height)
    }

    convenience init(mult matr1: Matrix, and matr2: Matrix) {
        self.init()
        mult(matr1, and: matr2)
    }

    convenience init(matrix matr: Matrix) {
        self.init()

        for line2 in matr.rows {
            var line = [Comb]()
            for c in line2 {
                line.append(Comb(comb: c))
            }
            combs.append(line)
        }
    }
    
    convenience init(transpose matr: Matrix) {
        self.init()

        if matr.height > 0 {
            let width = matr.height
            let height = matr.width

            for i in 0..<height {
                var line = [Comb]()
                for j in 0..<width {
                    line.append(Comb(comb: matr.rows[j][i]))
                }
                combs.append(line)
            }
        }
    }

    func submatrixFromCol(_ fromCol: Int, toCol: Int) -> Matrix {
        let m = Matrix()

        for line2 in combs {
            var line = [Comb]()
            for j in fromCol..<toCol {
                line.append(Comb(comb: line2[j]))
            }
            m.combs.append(line)
        }
        return m
    }

    var rows: [[Comb]] {
        return combs
    }

    func makeZeroMatrix(_ width: Int, h height: Int) {
        combs.removeAll()

        for _ in 0..<height {
            var line = [Comb]()
            for _ in 0..<width {
                line.append(Comb())
            }
            combs.append(line)
        }
    }

    func isEq(_ matr2: Matrix, debug: Bool) -> Bool {
        let combs2 = matr2.rows
        if combs.count != combs2.count {
            if debug { OutputFile.writeLog(.normal, "different counts \(combs.count) != \(combs2.count)") }
            return false
        }
        for i in 0..<combs.count {
            let line1 = combs[i]
            let line2 = combs2[i]
            if line1.count != line2.count {
                if debug { OutputFile.writeLog(.normal, "different \(i)-th counts \(line1.count) != \(line2.count)") }
                return false
            }

            for j in 0..<line1.count {
                if line1[j].compareK(line2[j]) != 1 {
                    if debug { OutputFile.writeLog(.normal, "different \(i),\(j)-th \(line1[j].htmlStr) != \(line2[j].htmlStr)") }
                    return false
                }
            }
        }
        return true
    }

    
    func isColEq(_ matrCol: [[Comb]], col: Int) -> Bool {
        if combs.count != matrCol.count { return false }

        for i in 0..<combs.count {
            let line1 = combs[i]
            if col > line1.count { return false }
            if line1[col].compareK(matrCol[i][0]) != 1 { return false }
        }
        return true
    }

    var isZero: Bool {
        for line in combs {
            for c in line {
                if !c.isZero { return false }
            }
        }
        return true
    }

    var isNil: Bool {
        return combs.count == 0
    }

    var width: Int {
        return combs.last?.count ?? 0
    }

    var height: Int {
        return combs.count
    }

    var maxNonZeroPos: (Int, Int) {
        var result = (0, 0)
        for i in 0..<combs.count {
            let line = combs[i]
            for j in 0..<line.count {
                if !line[j].isZero && i > result.0 { result.0 = i }
                if !line[j].isZero && j > result.1 { result.1 = j }
            }
        }
        return result
    }

    var maxRow: Int {
        var result = 0
        for line in combs {
            for i in 0..<line.count {
                if !line[i].isZero && i > result { result = i }
            }
        }
        return result
    }

    func numberOfDifferents(_ matr2: Matrix) -> Int {
        return numberOfDifferents(matr2, debug: false)
    }

    func numberOfDifferents(_ matr2: Matrix, debug: Bool) -> Int {
        let combs2 = matr2.rows
        if combs.count != combs2.count { return -1 }

        var result = 0

        for i in 0..<combs.count {
            let line1 = combs[i]
            let line2 = combs2[i]
            if line1.count != line2.count { return -1 }

            for j in 0..<line1.count {
                if line1[j].compareK(line2[j]) != 1 {
                    result += 1
                    if debug {
                        OutputFile.writeLog(.simple, "(\(i), \(j)) ")
                    }
                }
            }
        }
        return result
    }

    // self = matr - self
    func subtractMatrix(_ matr: Matrix) {
        let combs2 = matr.rows
        if combs.count != combs2.count { return }

        for i in 0..<combs.count {
            let line1 = combs[i]
            let line2 = combs2[i]
            if line1.count != line2.count { return }

            for j in 0..<line1.count {
                let c = line1[j]
                c.compKoef(-1)
                c.addComb(line2[j])
            }
        }
    }
    func addMatrix(_ matr: Matrix!) {
        let combs2 = matr.rows
        if combs.count != combs2.count { return }

        for i in 0..<combs.count {
            let line1 = combs[i]
            let line2 = combs2[i]
            if line1.count != line2.count { return }

            for j in 0..<line1.count {
                line1[j].addComb(line2[j])
            }
        }
    }

    func addMatrixX(_ matr: Matrix!, x: Int) {
        let combs2 = matr.rows

        for i in 0..<combs2.count {
            let line1 = combs[i]
            let line2 = combs2[i]

            for j in 0..<line2.count {
                let c = line2[j]
                if (!c.isZero) {
                    line1[j + x].addComb(c)
                }
            }
        }
    }

    private func mult(_ matr1: Matrix, and matr2: Matrix) {
        combs.removeAll()
        let combs1 = matr1.rows
        let combs2 = matr2.rows

        if combs1.count == 0 || combs2.count == 0 { return }
        if combs1[0].count != combs2.count { return }

        let nn = combs2.count
        let ww = combs2[0].count

        for i in 0..<combs1.count {
            var line = [Comb]()
            for j in 0..<ww {
                let c = Comb()
                for k in 0..<nn {
                    let cc = Comb(comb: combs1[i][k])
                    cc.compRight(combs2[k][j])
                    c.addComb(cc)
                }
                line.append(c)
            }
            combs.append(line)
        }
    }

    func twist(_ degree: Int) {
        let ell = Int(degree / PathAlg.twistPeriod)

        for _ in 0..<ell {
            for row in combs {
                for c in row { c.twist() }
            }
        }
    }

    func compKoef(_ koef: Int) {
        if (koef != 1) {
            let k = Double(koef)
            for row in combs {
                for c in row { c.compKoef(k) }
            }
        }
    }
}
