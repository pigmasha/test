//
//  Created by M on 22.02.18.
//

import Foundation

final class KoefMatrix {
    let deg: Int
    private var items: [ [NumFloat] ]

    init(im: ImMatrix) {
        deg = im.deg
        items = []
        for row in im.rows {
            items += [ row.map { NumFloat(floatValue: $0.koef) } ]
        }
    }

    var rows: [ [NumFloat] ] {
        return items
    }
}

final class KoefIntMatrix {
    let deg: Int
    private var items: [ [NumInt] ]

    init(im: ImMatrix) {
        deg = im.deg
        items = []
        for row in im.rows {
            items += [ row.map { NumInt(intValue: Int($0.koef)) } ]
        }
    }
    init(size: Int) {
        deg = 0
        items = []
        for _ in 0 ..< size {
            var item: [NumInt] = []
            for _ in 0 ..< size {
                item += [ NumInt(intValue: 0) ]
            }
            items += [item]
        }
    }

    var rows: [ [NumInt] ] {
        return items
    }

    func addLine(to addTo: Int, tok addToK: Int, line add: Int, k: Int) {
        let rowTo = items[addTo]
        let rowAdd = items[add]
        for i in 0 ..< rowTo.count {
            let n = rowTo[i]
            n.intValue = addToK * n.intValue + k * rowAdd[i].intValue
        }
    }

    func divLine(_ line: Int, tok k: Int) {
        let row = items[line]
        for n in row {
            n.intValue = n.intValue / k
        }
    }

    func multCol(_ col: Int, tok k: Int) {
        for row in items {
            let n = row[col]
            n.intValue = n.intValue * k
        }
    }

    var rank: Int {
        var nLineOfColumnPos: [NumInt] = []
        for _ in 0 ..< items[0].count {
            nLineOfColumnPos += [ NumInt(intValue: -1) ]
        }
        let charK = PathAlg.charK
        let nCols = items[0].count
        for i in 0 ..< items.count {
            var findPos = false
            var j = 0
            while !findPos {
                let row = items[i]
                j = 0
                while j < nCols {
                    let n2 = row[j].intValue
                    if charK > 0 {
                        if n2 % charK != 0 { break }
                    } else {
                        if n2 != 0 { break }
                    }
                    j += 1
                }
                guard j < nCols else { break } // line is zero
                let j2 = nLineOfColumnPos[j].intValue
                guard j2 != -1 else {
                    nLineOfColumnPos[j].intValue = i
                    findPos = true
                    continue
                }
                addLine(to: i, tok: -items[j2][j].intValue, line:j2, k:row[j].intValue)
                if charK > 0 {
                    for k in 0 ..< nCols {
                        let n2 = row[k]
                        n2.intValue = PathAlg.modCharK(n2.intValue)
                    }
                }
                var nod = 0
                for k in 0 ..< nCols {
                    let n2 = row[k]
                    guard n2.intValue != 0 else { continue }
                    nod = nod != 0 ? Utils.gcd(n2.intValue, j: nod) : n2.intValue
                }
                if nod > 1 { divLine(i, tok: nod) }
            }
        }
        var dim = 0
        for n in nLineOfColumnPos {
            if n.intValue > -1 { dim += 1 }
        }
        return dim
    }
}
