//
//  Created by M on 16.07.2022.
//

import Foundation

struct Im {
    static func im(deg: Int) -> [ImMatrix]? {
        let k = PathAlg.kk
        var rows: [[Element]] = []
        var rows1: [[Element]] = []
        let calcLen: () -> Int = {
            return rows1.isEmpty ? (deg % 4) + 2 : 4
        }
        let addXy: (Int) -> Void = { pos in
            for i in 1 ... k - 1 {
                let item = (1 ... calcLen()).map { _ in Element() }
                item[pos].add(element: Element(way1: Way(type: .x, len: 2*i), way2: Way(type: .y, len: 2*i)))
                rows.append(item)
            }
        }
        let addZx: (ArrType, Int) -> Void = { type, pos in
            for i in 1 ... k - 1 {
                let item = (1 ... calcLen()).map { _ in Element() }
                item[pos].add(way: Way(type: type, len: 2*i+1), koef: 1)
                rows.append(item)
            }
        }
        let addZxZx: ((ArrType, Int), (ArrType, Int)) -> Void = { pos1, pos2 in
            for i in 1 ... k - 1 {
                let item = (1 ... calcLen()).map { _ in Element() }
                item[pos1.1].add(way: Way(type: pos1.0, len: 2*i+1), koef: 1)
                item[pos2.1].add(way: Way(type: pos2.0, len: 2*i+1), koef: 1)
                rows.append(item)
            }
        }
        let addXyWx: (Int, (ArrType, Int)) -> Void = { pos1, pos2 in
            for i in 1 ... k - 1 {
                let item = (1 ... calcLen()).map { _ in Element() }
                item[pos1].add(element: Element(way1: Way(type: .x, len: 2*i), way2: Way(type: .y, len: 2*i)))
                item[pos2.1].add(way: Way(type: pos2.0, len: 2*i), koef: 1)
                rows.append(item)
            }
        }

        let q0 = deg % 4
        switch q0 {
        case 0:
            addXy(0)
            addXy(1)
            addZxZx((.x, 0), (.y, 1))
        case 1:
            addXy(1)
            addXy(2)
            addZx(.x, 1)
            addZx(.y, 2)
            rows.append([Element(), Element(), Element(way: Way.zx)])
            rows.append([Element(), Element(way: Way.zy), Element()])
            if k % 2 == 1 {
                rows.append([Element(), Element(way: Way.xx), Element(way: Way.xx)])
            }
        case 2:
            addXy(2)
            addXy(3)
            addZx(.x, 2)
            addZx(.y, 3)
            addZxZx((.x, 0), (.y, 1))
            addXyWx(0, (.y, 2))
            addXyWx(1, (.x, 3))
            rows.append([Element(), Element(), Element(way: Way.xx), Element()])
            rows.append([Element(), Element(), Element(), Element(way: Way.xx)])
            if deg % 8 == 6 {
                rows.append([Element(way: Way.zy), Element(way: Way.zx),
                             Element(way1: Way.x, way2: Way.zy), Element(way1: Way.y, way2: Way.zx)])
            } else {
                rows.append([Element(way: Way.zy), Element(way: Way.zx),
                             Element(way: Way.x), Element(way: Way.y)])
            }
            rows1 = rows
        case 3:
            addXy(3)
            addXy(4)
            addZx(.x, 1)
            addZx(.y, 2)
            addZx(.x, 3)
            addZx(.y, 4)
            addXyWx(1, (.y, 3))
            addXyWx(2, (.x, 4))
            rows.append([Element(), Element(), Element(), Element(way: Way.zy), Element()])
            rows.append([Element(), Element(), Element(), Element(), Element(way: Way.zx)])
            rows.append([Element(), Element(), Element(), Element(way: Way.xx), Element()])
            rows.append([Element(), Element(), Element(), Element(), Element(way: Way.xx)])
            rows.append([Element(), Element(), Element(), Element(way: Way.x), Element()])
            rows.append([Element(), Element(), Element(), Element(), Element(way: Way.y)])
        default:
            fatalError("Unknown deg % 4 value \(deg % 4)")
        }
        rows1 = rows
        rows = []

        // 8k - 2
        let addG: () -> Void = {
            addXy(2)
            addXy(3)
            addZx(.x, 0)
            addZx(.y, 1)
            addZx(.x, 2)
            addZx(.y, 3)
            addXyWx(0, (.y, 2))
            addXyWx(1, (.x, 3))
            rows.append([Element(), Element(), Element(way: Way.xx), Element()])
            rows.append([Element(), Element(), Element(), Element(way: Way.xx)])
        }
        addG()
        rows.append([Element(way: Way.xx), Element(), Element(), Element()])
        rows.append([Element(), Element(way: Way.xx), Element(), Element()])
        rows.append([Element(way: Way.zy), Element(), Element(way: Way.x), Element()])
        rows.append([Element(), Element(way: Way.zx), Element(), Element(way: Way.y)])
        let g1 = rows
        rows = []
        addG()
        rows.append([Element(way: Way.xx), Element(), Element(), Element()])
        rows.append([Element(), Element(way: Way.xx), Element(), Element()])
        rows.append([Element(way: Way.zy), Element(), Element(way1: Way.x, way2: Way.zy), Element()])
        rows.append([Element(), Element(way: Way.zx), Element(), Element(way1: Way.y, way2: Way.zx)])
        let g2 = rows
        rows = []
        addG()
        rows.append([Element(), Element(), Element(way: Way.x), Element()])
        rows.append([Element(), Element(), Element(), Element(way: Way.y)])
        rows.append([Element(), Element(), Element(way: Way.zy), Element()])
        rows.append([Element(), Element(), Element(), Element(way: Way.zx)])
        let g3 = rows

        let m = deg / 4
        var result = [ImMatrix(rows: rows1)]
        if m == 0 { return result }

        switch deg % 2 {
        case 0:
            if m % 2 == 0 {
                for n in 0 ..< m / 2 {
                    result += [ ImMatrix(rows: g2, zeroPrefixLen: q0 + 8 * n + 2),
                                ImMatrix(rows: g1, zeroPrefixLen: q0 + 8 * n + 6)]
                }
            } else {
                if m > 1 {
                    for n in 0 ... (m - 3) / 2 {
                        result += [ ImMatrix(rows: g1, zeroPrefixLen: q0 + 8 * n + 2),
                                    ImMatrix(rows: g2, zeroPrefixLen: q0 + 8 * n + 6)]
                    }
                }
                result += [ ImMatrix(rows: g1, zeroPrefixLen: q0 + 2 + 4 * (m - 1)) ]
            }
        case 1:
            for n in 0 ..< m {
                result += [ ImMatrix(rows: g3, zeroPrefixLen: q0 + 4 * n + 2)]
            }
        default:
            fatalError("Unknown deg % 2 value \(deg % 2)")
        }
        return result
    }
}
