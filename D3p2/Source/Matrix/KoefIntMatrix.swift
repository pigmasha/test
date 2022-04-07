//
//  Created by M on 22.02.18.
//

import Foundation

final class KoefIntMatrix {
    private(set) var items: [[NumInt]]
    private(set) var ways: [Way]

    init(rows: [[Int]]) {
        items = rows.map { row in row.map { NumInt(n: $0) } }
        ways = []
    }

    init(im: [[(Int, Way)]]) {
        items = []
        ways = []
        if im.isEmpty { return }
        var transpItems: [[NumInt]] = []
        for j in 0 ..< im[0].count {
            var colWays: [Way] = []
            for row in im {
                let w = row[j].1
                if row[j].0 != 0 && !colWays.contains(where: { $0.isEq(w) }) { colWays.append(w) }
            }
            for w in colWays {
                transpItems.append(im.map { row in
                    NumInt(n: row[j].0 != 0 && row[j].1.isEq(w) ? row[j].0 : 0)
                })
            }
            ways += colWays
        }
        for j in 0 ..< transpItems[0].count {
            items.append(transpItems.map{ $0[j] })
        }
    }
    
    var rows: [[NumInt]] {
        return items
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
