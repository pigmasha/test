//
//  PMatrix.swift
//  Created by M on 17.10.2021.
//

import Foundation

class PMatrix {
    private(set) var rows: [[Element]]

    init(w: Int, h: Int) {
        rows = []

        for _ in 0 ..< h {
            var row: [Element] = []
            for _ in 0 ..< w { row.append(Element()) }
            rows.append(row)
        }
    }

    convenience init(mult m1: PMatrix, and m2: PMatrix) {
        if m1.width != m2.height { fatalError() }
        self.init(w: m2.width, h: m1.height)
        for i in 0 ..< m1.height {
            for j in 0 ..< m2.width {
                for k in 0 ..< m1.width {
                    let e = Element(element: m2.rows[k][j])
                    e.compRight(element: m1.rows[i][k])
                    rows[i][j].add(element: e)
                }
            }
        }
    }

    var isZero: Bool {
        for line in rows {
            if line.contains(where: { !$0.isZero }) { return false }
        }
        return true
    }

    var width: Int {
        return rows.last?.count ?? 0
    }

    var height: Int {
        return rows.count
    }
}
