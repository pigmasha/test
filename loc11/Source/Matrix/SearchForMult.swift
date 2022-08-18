//
//  SearchForMult.swift
//  Created by M on 01.06.2022.
//

import Foundation

struct SearchForMult {
    enum Mode {
        case diff, fillDiag, fill
    }
    static func search(for matrix: Matrix, multWith: Matrix, mult: Matrix?, mode: Mode, searchAll: Bool = false) -> String? {
        let allCombs = alllCombs
        var columns: [Matrix] = []
        var lastColumn = -1
        let columnCheck: (Int) -> Bool = { column in
            let m = Matrix(mult: multWith, and: matrix, column: column)
            let isOk: Bool
            if let mult = mult {
                isOk = m.numberOfDifferents(with: Matrix(m: mult, column: column)) == 0
            } else {
                isOk = m.isZero
            }
            if isOk {
                if searchAll {
                    if lastColumn != column {
                        columns = []
                        lastColumn = column
                    }
                    let m = Matrix(m: matrix, column: column)
                    if !columns.contains(where: { $0.numberOfDifferents(with: m) == 0 }) {
                        PrintUtils.printMatrixColumn("Col \(column)", matrix, column)
                        columns.append(m)
                    }
                    return false
                } else {
                    return true
                }
            }
            return false
        }
        /*let card: (Int) -> Int = { column in
            let m = Matrix(mult: multWith, and: matrix, column: column)
            if let mult = mult {
                m.add(Matrix(m: mult, column: column), koef: 1)
            }
            var c = 0
            for row in m.rows {
                for item in row { c += item.contents.count }
            }
            return c
        }*/
        var allC: [Comb] = []
        let ways = Way.allWays
        for w1 in ways {
            for w2 in ways {
                if mode == .diff && w2.len == 0 { continue }
                allC.append(Comb(left: w1, right: w2, label: ""))
            }
        }
        allC.append(contentsOf: allCombs)
        for column in 0 ..< matrix.width {
            if columnCheck(column) { /*OutputFile.writeLog(.normal, "Column \(column) ok!");*/ continue }
            //if (matrix.width - column) % 2 == 1 && column > 0 { continue }
            //if fill1(matrix: matrix, column: column, rows: nil, allCombs: allCombs, columnCheck: columnCheck) { continue }
            //if fill01(matrix: matrix, column: column, allCombs: allC, card: card) { continue }
            //fill(for: matrix, column: column, multWith: multWith, mult: mult!)
            searchVariants(for: matrix, column: column, multWith: multWith, mult: mult!, searchAll: true)
        }
        return nil
    }

    private static var alllCombs: [Comb] {
        return [
        Comb.ex, Comb.ey,
        Comb(left: Way.e, right: Way.zx, label: ""), Comb(left: Way.e, right: Way.zy, label: ""),
        Comb(left: Way.y, right: Way.wx, label: ""), Comb(left: Way.x, right: Way.wx, label: ""),
        Comb(left: Way.x, right: Way.wy, label: ""), Comb(left: Way.y, right: Way.wy, label: ""),
        Comb(left: Way.wy, right: Way.zx, label: ""), Comb(left: Way.wx, right: Way.zx, label: ""),
        Comb(left: Way.wx, right: Way.zy, label: ""), Comb(left: Way.wy, right: Way.zy, label: ""),
        eXWave, eYWave, lx, ly, rx, ry, delta(way: Way.x), delta(way: Way.y), deltaXWave, deltaYWave,
        //xWaveEPlusEX, yWaveEPlusEY, // opt
        //xEPlusEXWave, yEPlusEYWave, // opt
        ezxPlusRx, ezyPlusRy, exPlusYwY, eyPlusXwX
        //exPlusLyPlusZyE, eyPlusLxPlusZxE // opt
        ]
        /*let c = items.count
        for i in 0 ..< c {
            if items[i].contents.count == 1 {
                let t = items[i].contents[0].1
                items.append(Comb(left: t.rightComponent, right: t.leftComponent, label: ""))
            }
        }
        let c1 = items.count
        for i in 0 ..< c1 {
            let cc = items[i].phi
            if !items.contains(where: { $0.isEq(cc) }) { items.append(cc) }
        }
        //OutputFile.writeLog(.normal, "All: " + items.map { let c = Comb(); c.add(comb: $0); return c.str }.joined(separator: "; "))
        return items*/
    }

    static func delta(way: Way) -> Comb {
        let c = Comb(left: way, right: Way.e, label: "Δ" + way.str)
        c.add(left: Way.e, right: way, koef: 1)
        return c
    }

    static var deltaXWave: Comb {
        let c = Comb(label: "Δx̃")
        c.add(comb: delta(way: Way.x))
        c.add(comb: delta(way: Way.zy))
        return c
    }

    static var deltaYWave: Comb {
        let c = Comb(label: "Δỹ")
        c.add(comb: delta(way: Way.y))
        c.add(comb: delta(way: Way.zx))
        return c
    }

    static var eXWave: Comb {
        let c = Comb(label: "1*x̃")
        c.add(comb: Comb(left: Way.e, right: Way.x, label: ""))
        c.add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
        return c
    }

    static var eYWave: Comb {
        let c = Comb(label: "1*ỹ")
        c.add(comb: Comb(left: Way.e, right: Way.y, label: ""))
        c.add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
        return c
    }

    static var xWaveEPlusEX: Comb {
        let c = Comb(label: "x̃*1+1*x")
        c.add(comb: delta(way: Way.x))
        c.add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
        return c
    }

    static var yWaveEPlusEY: Comb {
        let c = Comb(label: "ỹ*1+1*y")
        c.add(comb: delta(way: Way.y))
        c.add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
        return c
    }

    static var xEPlusEXWave: Comb {
        let c = Comb(label: "x*1+1*x̃")
        c.add(comb: delta(way: Way.x))
        c.add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
        return c
    }

    private static var yEPlusEYWave: Comb {
        let c = Comb(label: "y*1+1*ỹ")
        c.add(comb: delta(way: Way.y))
        c.add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
        return c
    }

    static var ezxPlusRx: Comb {
        let c = Comb()
        c.add(comb: Comb(left: Way.e, right: Way.zx, label: ""))
        c.add(comb: rx)
        c.updateLabel()
        return c
    }

    static var ezyPlusRy: Comb {
        let c = Comb()
        c.add(comb: Comb(left: Way.e, right: Way.zy, label: ""))
        c.add(comb: ry)
        c.updateLabel()
        return c
    }

    static var exPlusYwY: Comb {
        let c = Comb()
        c.add(comb: Comb.ex)
        c.add(comb: Comb(left: Way.y, right: Way.wy, label: ""))
        c.updateLabel()
        return c
    }

    static var eyPlusXwX: Comb {
        let c = Comb()
        c.add(comb: Comb.ey)
        c.add(comb: Comb(left: Way.x, right: Way.wx, label: ""))
        c.updateLabel()
        return c
    }

    static var exPlusLyPlusZyE: Comb {
        let c = Comb()
        c.add(comb: Comb(left: Way.e, right: Way.x, label: ""))
        c.add(comb: ly)
        c.add(comb: Comb(left: Way.zy, right: Way.e, label: ""))
        c.updateLabel()
        return c
    }

    private static var eyPlusLxPlusZxE: Comb {
        let c = Comb()
        c.add(comb: Comb(left: Way.e, right: Way.y, label: ""))
        c.add(comb: lx)
        c.add(comb: Comb(left: Way.zx, right: Way.e, label: ""))
        c.updateLabel()
        return c
    }

    static var lx: Comb {
        let k = PathAlg.kk
        let c = Comb(label: PathAlg.isTex ? "L_x" : "Lx")
        for i in 0 ... k - 1 {
            c.add(left: Way(type: .x, len: 2 * (k - 1 - i) + 1), right: Way(type: .x, len: 2 * i), koef: 1)
        }
        return c
    }

    private static var lxMinusZx: Comb {
        let k = PathAlg.kk
        let c = Comb(label: "L" + Utils.subStr("x") + "-z" + Utils.subStr("x"))
        for i in 1 ... k - 1 {
            c.add(left: Way(type: .x, len: 2 * (k - 1 - i) + 1), right: Way(type: .x, len: 2 * i), koef: 1)
        }
        return c
    }

    static var rx: Comb {
        let k = PathAlg.kk
        let c = Comb(label: PathAlg.isTex ? "R_x" : "Rx")
        for i in 0 ... k - 1 {
            c.add(left: Way(type: .y, len: 2 * (k - 1 - i)), right: Way(type: .x, len: 2 * i + 1), koef: 1)
        }
        return c
    }

    static var ly: Comb {
        let k = PathAlg.kk
        let c = Comb(label: PathAlg.isTex ? "L_y" : "Ly")
        for i in 0 ... k - 1 {
            c.add(left: Way(type: .y, len: 2 * (k - 1 - i) + 1), right: Way(type: .y, len: 2 * i), koef: 1)
        }
        return c
    }

    private static var lyMinusZy: Comb {
        let k = PathAlg.kk
        let c = Comb(label: "L" + Utils.subStr("y") + "-z" + Utils.subStr("y"))
        for i in 1 ... k - 1 {
            c.add(left: Way(type: .y, len: 2 * (k - 1 - i) + 1), right: Way(type: .y, len: 2 * i), koef: 1)
        }
        return c
    }

    static var ry: Comb {
        let k = PathAlg.kk
        let c = Comb(label: PathAlg.isTex ? "R_y" : "Ry")
        for i in 0 ... k - 1 {
            c.add(left: Way(type: .x, len: 2 * (k - 1 - i)), right: Way(type: .y, len: 2 * i + 1), koef: 1)
        }
        return c
    }
}
