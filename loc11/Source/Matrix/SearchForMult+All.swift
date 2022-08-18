//
//  SearchForMult+All.swift
//  Created by M on 05.06.2022.
//

import Foundation

extension SearchForMult {
    static func fill01(matrix: Matrix, column: Int, allCombs: [Comb], card: (Int) -> Int) -> Bool {
        while true {
            var minCard = card(column)
            if minCard == 0 { return true }
            var minInfo: (Int, Comb)?
            for row in 0 ... matrix.height - 1 { for c in allCombs {
                matrix.rows[row][column].add(comb: c)
                let c1 = card(column)
                if c1 < minCard {
                    minCard = c1
                    minInfo = (row, c)
                }
                matrix.rows[row][column].add(comb: c)
            } }
            if let minInfo = minInfo {
                matrix.rows[minInfo.0][column].add(comb: minInfo.1)
                if minInfo.0 == 0 { return true }
            } else {
                if fill02(matrix: matrix, column: column, allCombs: allCombs, card: card) { continue }
                //if fill03(matrix: matrix, column: column, allCombs: allCombs, card: card) { continue }
                break
            }
        }
        return false
    }

    private static func fill02(matrix: Matrix, column: Int, allCombs: [Comb], card: (Int) -> Int) -> Bool {
        var minCard = card(column)
        var minInfo: (Int, Comb, Int, Comb)?
        for row1 in 0 ... matrix.height - 1 { for c1 in allCombs {
            matrix.rows[row1][column].add(comb: c1)
            for row2 in 0 ... matrix.height - 1 { for c2 in allCombs {
                matrix.rows[row2][column].add(comb: c2)
                let card1 = card(column)
                if card1 < minCard {
                    minCard = card1
                    minInfo = (row1, c1, row2, c2)
                }
                matrix.rows[row2][column].add(comb: c2)
            } }
            matrix.rows[row1][column].add(comb: c1)
        } }
        if let minInfo = minInfo {
            matrix.rows[minInfo.0][column].add(comb: minInfo.1)
            matrix.rows[minInfo.2][column].add(comb: minInfo.3)
            return true
        }
        return false
    }

    private static func fill03(matrix: Matrix, column: Int, allCombs: [Comb], card: (Int) -> Int) -> Bool {
        var minCard = card(column)
        var minInfo: (Int, Comb, Int, Comb, Int, Comb)?
        for row1 in 0 ... matrix.height - 1 { for c1 in allCombs {
            matrix.rows[row1][column].add(comb: c1)
            for row2 in 0 ... matrix.height - 1 { for c2 in allCombs {
                matrix.rows[row2][column].add(comb: c2)
                for row3 in 0 ... matrix.height - 1 { for c3 in allCombs {
                    matrix.rows[row3][column].add(comb: c3)
                    let card1 = card(column)
                    if card1 < minCard {
                        minCard = card1
                        minInfo = (row1, c1, row2, c2, row3, c3)
                    }
                    matrix.rows[row3][column].add(comb: c3)
                } }
                matrix.rows[row2][column].add(comb: c2)
            } }
            matrix.rows[row1][column].add(comb: c1)
        } }
        if let minInfo = minInfo {
            matrix.rows[minInfo.0][column].add(comb: minInfo.1)
            matrix.rows[minInfo.2][column].add(comb: minInfo.3)
            matrix.rows[minInfo.4][column].add(comb: minInfo.5)
            return true
        }
        return false
    }

    static func fill1(matrix: Matrix, column: Int, rows: (Int, Int)?, allCombs: [Comb], columnCheck: (Int) -> Bool) -> Bool {
        let rr = rows ?? (0, matrix.height - 1)
        for row in rr.0 ... rr.1 { for c in allCombs {
            matrix.rows[row][column].add(comb: c)
            if columnCheck(column) { return true }
            matrix.rows[row][column].add(comb: c)
        } }
        return fill2(matrix: matrix, column: column, rows: rr, allCombs: allCombs, columnCheck: columnCheck)
    }

    private static func fill2(matrix: Matrix, column: Int, rows: (Int, Int), allCombs: [Comb], columnCheck: (Int) -> Bool) -> Bool {
        for row1 in rows.0 ... rows.1 { for c1 in allCombs {
            matrix.rows[row1][column].add(comb: c1)
            for row2 in row1 ... rows.1 { for c2 in allCombs {
                matrix.rows[row2][column].add(comb: c2)
                if columnCheck(column) { return true }
                matrix.rows[row2][column].add(comb: c2)
            } }
            matrix.rows[row1][column].add(comb: c1)
        } }
        return false//fill3(matrix: matrix, column: column, rows: rows, allCombs: allCombs, columnCheck: columnCheck)
    }

    private static func fill3(matrix: Matrix, column: Int, rows: (Int, Int), allCombs: [Comb], columnCheck: (Int) -> Bool) -> Bool {
        for row1 in rows.0 ... rows.1 { for c1 in allCombs {
            matrix.rows[row1][column].add(comb: c1)
            for row2 in row1 ... rows.1 { for c2 in allCombs {
                matrix.rows[row2][column].add(comb: c2)
                for row3 in row2 ... rows.1 { for c3 in allCombs {
                    matrix.rows[row3][column].add(comb: c3)
                    if columnCheck(column) { return true }
                    matrix.rows[row3][column].add(comb: c3)
                } }
                matrix.rows[row2][column].add(comb: c2)
            } }
            matrix.rows[row1][column].add(comb: c1)
        } }
        return false//fill4(matrix: matrix, column: column, rows: rows, allCombs: allCombs, columnCheck: columnCheck)
    }

    private static func fill4(matrix: Matrix, column: Int, rows: (Int, Int), allCombs: [Comb], columnCheck: (Int) -> Bool) -> Bool {
        for row1 in rows.0 ... rows.1 { for c1 in allCombs {
            matrix.rows[row1][column].add(comb: c1)
            for row2 in row1 ... rows.1 { for c2 in allCombs {
                matrix.rows[row2][column].add(comb: c2)
                for row3 in row2 ... rows.1 { for c3 in allCombs {
                    matrix.rows[row3][column].add(comb: c3)
                    for row4 in row3 ... rows.1 { for c4 in allCombs {
                        matrix.rows[row4][column].add(comb: c4)
                        if columnCheck(column) { return true }
                        matrix.rows[row4][column].add(comb: c4)
                    } }
                    matrix.rows[row3][column].add(comb: c3)
                } }
                matrix.rows[row2][column].add(comb: c2)
            } }
            matrix.rows[row1][column].add(comb: c1)
        } }
        return false//fill5(matrix: matrix, column: column, rows: rows, allCombs: allCombs, columnCheck: columnCheck)
    }

    private static func fill5(matrix: Matrix, column: Int, rows: (Int, Int), allCombs: [Comb], columnCheck: (Int) -> Bool) -> Bool {
        for row1 in rows.0 ... rows.1 { for c1 in allCombs {
            matrix.rows[row1][column].add(comb: c1)
            for row2 in row1 ... rows.1 { for c2 in allCombs {
                matrix.rows[row2][column].add(comb: c2)
                for row3 in row2 ... rows.1 { for c3 in allCombs {
                    matrix.rows[row3][column].add(comb: c3)
                    for row4 in row3 ... rows.1 { for c4 in allCombs {
                        matrix.rows[row4][column].add(comb: c4)
                        for row5 in row4 ... rows.1 { for c5 in allCombs {
                            matrix.rows[row5][column].add(comb: c5)
                            if columnCheck(column) { return true }
                            matrix.rows[row5][column].add(comb: c5)
                        } }
                        matrix.rows[row4][column].add(comb: c4)
                    } }
                    matrix.rows[row3][column].add(comb: c3)
                } }
                matrix.rows[row2][column].add(comb: c2)
            } }
            matrix.rows[row1][column].add(comb: c1)
        } }
        return false
    }
}
