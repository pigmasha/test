//
//  Created by M on 24.04.16.
//

import Foundation

class Matrix {
    private var combs: [[Comb]]

    init() {
        combs = [[Comb]]()
    }

    convenience init(zeroMatrix width: Int, h height: Int) {
        self.init()
        makeZeroMatrix(width, h: height)
    }

    convenience init(mult m1: Matrix, and m2: Matrix) {
        self.init()
        if m1.width != m2.height { return }
        makeZeroMatrix(m2.width, h: m1.height)
        for i in 0 ..< m1.height {
            for j in 0 ..< m2.width {
                for k in 0 ..< m1.width {
                    let c = Comb(comb: m1.rows[i][k])
                    c.compRight(comb: m2.rows[k][j])
                    combs[i][j].add(comb: c)
                }
            }
        }
    }

    convenience init(mult m1: Matrix, and m2: Matrix, column: Int) {
        self.init()
        if m1.width != m2.height { return }
        makeZeroMatrix(1, h: m1.height)
        for i in 0 ..< m1.height {
            for k in 0 ..< m1.width {
                let c = Comb(comb: m1.rows[i][k])
                c.compRight(comb: m2.rows[k][column])
                combs[i][0].add(comb: c)
            }
        }
    }

    convenience init(m: Matrix, column: Int) {
        self.init()
        makeZeroMatrix(1, h: m.height)
        for i in 0 ..< m.height {
            combs[i][0].add(comb: m.rows[i][column])
        }
    }

    var rows: [[Comb]] {
        return combs
    }

    func makeZeroMatrix(_ width: Int, h height: Int) {
        combs.removeAll()

        for _ in 0..<height {
            var line: [Comb] = []
            for _ in 0..<width {
                line.append(Comb())
            }
            combs.append(line)
        }
    }
    
    var isZero: Bool {
        for line in combs {
            if line.contains(where: { !$0.isZero }) { return false }
        }
        return true
    }

    var isNil: Bool {
        return combs.isEmpty
    }

    var width: Int {
        return combs.last?.count ?? 0
    }

    var height: Int {
        return combs.count
    }

    var nonZeroCount: Int {
        var result = 0
        for line in combs {
            for c in line {
                if !c.isZero { result += 1 }
            }
        }
        return result
    }

    func numberOfDifferents(with other: Matrix) -> Int {
        if width != other.width || height != other.height { return -1 }
        var n = 0
        for i in 0 ..< height {
            for j in 0 ..< width {
                if rows[i][j].isZero && other.rows[i][j].isZero { continue }
                if !rows[i][j].isEq(other.rows[i][j]) { n += 1 }
            }
        }
        return n
    }

    func diffColumns(with other: Matrix) -> [Int] {
        if width != other.width || height != other.height { return [] }
        var diff: [Int] = []
        for j in 0 ..< width {
            for i in 0 ..< height {
                if rows[i][j].isZero && other.rows[i][j].isZero { continue }
                if !rows[i][j].isEq(other.rows[i][j]) { diff.append(j); break }
            }
        }
        return diff
    }

    func add(_ other: Matrix, koef: Int) {
        if width != other.width || height != other.height { fatalError() }
        for i in 0 ..< height {
            for j in 0 ..< width {
                rows[i][j].add(comb: other.rows[i][j], koef: koef)
            }
        }
    }
}
