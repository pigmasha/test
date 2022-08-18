//
//  SearchForMult+Variants.swift
//  Created by M on 05.06.2022.
//

import Foundation

extension SearchForMult {
    static func searchVariants(for matrix: Matrix, column: Int, multWith: Matrix, mult: Matrix, searchAll: Bool) {
        let allWays = Way.allWays
        var allCombs: [Comb] = []
        for w1 in allWays {
            for w2 in allWays {
                allCombs.append(Comb(left: w1, right: w2, label: ""))
            }
        }
        var allCombsRows: [[Comb]] = []
        for _ in 0 ..< matrix.height {
            allCombsRows.append(Array(allCombs))
        }
        guard let min1 = minTenzor(for: matrix, column: column, multWith: multWith, mult: mult, allCombs: allCombsRows) else { return }
        if min1.0 < 0 { return }
        var allVariants: [[(Int, Comb)]] = []
        allVariants.append(min1.2)

        let removeLastVariant: () -> Void = {
            while true {
                let (row, c1) = allVariants[allVariants.count - 1][0]
                allCombsRows[row].append(c1)
                matrix.rows[row][column].add(comb: c1)
                allVariants[allVariants.count - 1].remove(at: 0)
                if !allVariants[allVariants.count - 1].isEmpty { break }
                _ = allVariants.popLast()
                if allVariants.isEmpty { break }
            }
        }

        let card: (Int) -> Int = { column in
            var c = 0
            for row in matrix.rows {
                c += row[column].contents.count
            }
            return c
        }
        var minCard = -1

        while true {
            guard let lastV = allVariants.last else { break }
            let (row, c) = lastV[0]
            matrix.rows[row][column].add(comb: c)
            allCombsRows[row].remove(at: allCombsRows[row].firstIndex(where: { $0.isEq(c) })!)
            if minCard > -1 && allVariants.count > minCard { removeLastVariant(); continue }
            //guard allVariants.count < 8 else { removeLastVariant(); continue }
            guard let min2 = minTenzor(for: matrix, column: column, multWith: multWith, mult: mult, allCombs: allCombsRows) else {
                removeLastVariant()
                continue
            }
            if min2.0 < 0 { // ok!
                if searchAll {
                    let c = card(column)
                    if minCard < 0 || minCard >= c {
                        var nE = 0
                        var n1 = 0
                        for row in matrix.rows {
                            for (_, t) in row[column].contents {
                                if t.leftComponent.len == 0 || t.rightComponent.len == 0 { nE += 1 }
                                if t.leftComponent.len == 1 || t.rightComponent.len == 1 { n1 += 1 }
                            }
                        }
                        PrintUtils.printMatrixColumn("Column \(column), card=\(c) (e=\(nE), x,y=\(n1))", matrix, column)
                        minCard = c
                    }
                    removeLastVariant()
                    continue
                } else {
                    return
                }
            }
            allVariants.append(min2.2)
            //OutputFile.writeLog(.normal, "Min tenzor: \(min2.1.str), v=\(min2.2.count); step=\(allVariants.count)")
        }
    }

    private static func minTenzor(for matrix: Matrix, column: Int, multWith: Matrix, mult: Matrix, allCombs: [[Comb]]) -> (Int, Tenzor, [(Int, Comb)])? {
        let multC = Matrix(m: mult, column: column)
        multC.add(Matrix(mult: multWith, and: matrix, column: column), koef: -1)
        var minTenzor: (row: Int, t: Tenzor, v: [(Int, Comb)]) = (-1, Tenzor(left: Way.e, right: Way.e), [])
        if multC.isZero { return minTenzor }

        let matrix2 = Matrix(zeroMatrix: 1, h: matrix.height)
        for i in 0 ..< multC.height {
            let c = multC.rows[i][0]
            if c.isZero { continue }
            for (_, t) in c.contents {
                var variants: [(Int, Comb)] = []
                for row in 0 ..< matrix2.height {
                    for c1 in allCombs[row] {
                        matrix2.rows[row][0].add(comb: c1)
                        let m1 = Matrix(mult: multWith, and: matrix2)
                        if m1.rows[i][0].contents.contains(where: { _, t1 in t1.isEq(t) }) {
                            variants.append((row, c1))
                        }
                        matrix2.rows[row][0].clear()
                    }
                }
                if variants.isEmpty { return nil }
                if minTenzor.row < 0 || minTenzor.v.count > variants.count {
                    minTenzor = (i, t, variants)
                }
            }
        }
        return minTenzor
    }
}
