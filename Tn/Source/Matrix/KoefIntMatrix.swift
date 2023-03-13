//
//  Created by M on 22.02.18.
//

import Foundation

final class KoefIntMatrix {
    private(set) var items: [[NumInt]]
    private(set) var ways: [Way]

    init() {
        items = []
        ways = []
    }

    init(rows: [[Int]]) {
        items = rows.map { row in row.map { NumInt(n: $0) } }
        ways = []
    }

    convenience init(matrix: PMatrix) {
        var i = 0
        var koefRows: [[Int]] = []
        var ww: [Way] = []
        for row in matrix.rows {
            var m: [String: Int] = [:]
            for (j, e) in row.enumerated() {
                if e.isZero { continue }
                if let r = m[e.str] {
                    koefRows[r][j] += e.contents[0].0.n
                } else {
                    koefRows.append(Array(repeating: 0, count: row.count))
                    koefRows[i][j] += e.contents[0].0.n
                    m[e.str] = i
                    ww.append(e.contents[0].1)
                    i += 1
                }
            }
        }
        self.init(rows: koefRows)
        ways = ww
        if ways.count != rows.count { fatalError("ways.count != rows.count") }
    }

    convenience init(elements: [[Element]]) {
        guard !elements.isEmpty else {
            self.init(rows: [])
            return
        }
        var i = 0
        var koefRows: [[Int]] = []
        var ww: [Way] = []
        for k in 0 ..< elements[0].count {
            var m: [String: Int] = [:]
            for (j, item) in elements.enumerated() {
                let e = item[k]
                if e.isZero { continue }
                if e.contents.count != 1 { fatalError() }
                if let r = m[e.strKey] {
                    koefRows[r][j] += e.contents[0].0.n
                } else {
                    koefRows.append(Array(repeating: 0, count: elements.count))
                    koefRows[i][j] += e.contents[0].0.n
                    m[e.strKey] = i
                    ww.append(e.contents[0].1)
                    i += 1
                }
            }
        }
        self.init(rows: koefRows)
        ways = ww
        if ways.count != rows.count { fatalError("ways.count != rows.count") }
    }
    
    var rows: [[NumInt]] {
        return items
    }

    func addRow(_ row: [Int]) {
        items.insert(row.map { NumInt(n: $0) }, at: 0)
    }

    private func addLine(to addTo: Int, tok addToK: Int, line add: Int, k: Int) {
        if addToK == 0 || k == 0 { fatalError() }
        let rowTo = items[addTo]
        let rowAdd = items[add]
        for i in 0 ..< rowTo.count {
            let n = rowTo[i]
            n.n = addToK * n.n + k * rowAdd[i].n
        }
    }

    private func divLine(_ line: Int, tok k: Int) {
        let row = items[line]
        for n in row {
            n.n = n.n / k
        }
    }

    var rank: Int {
        if items.isEmpty { return 0 }
        var nLineOfColumnPos: [NumInt2] = []
        for _ in 0 ..< items[0].count { nLineOfColumnPos += [ NumInt2(n: -1) ] }
        let nCols = items[0].count
        for i in 0 ..< items.count {
            var findPos = false
            var j = 0
            while !findPos {
                let row = items[i]
                j = 0
                while j < nCols {
                    if row[j].n != 0 { break }
                    j += 1
                }
                guard j < nCols else { break } // line is zero
                let j2 = nLineOfColumnPos[j].n
                guard j2 != -1 else {
                    nLineOfColumnPos[j].n = i
                    findPos = true
                    continue
                }
                addLine(to: i, tok: -items[j2][j].n, line:j2, k:row[j].n)
                var nod = 0
                for k in 0 ..< nCols {
                    let n2 = row[k]
                    guard n2.n != 0 else { continue }
                    nod = nod != 0 ? Utils.gcd(n2.n, j: nod) : n2.n
                }
                if nod > 1 { divLine(i, tok: nod) }
            }
        }
        var dim = 0
        for n in nLineOfColumnPos {
            if n.n > -1 { dim += 1 }
        }
        return dim
    }
}
