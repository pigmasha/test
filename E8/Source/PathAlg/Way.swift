//
//  Created by M on 19.04.16.
//

import Foundation

enum ArrType: Int {
    case alpha, beta, gamma
}

struct WayArr {
    let type: ArrType
    let i: Int
}

final class Way {
    private var vStart: Vertex
    private var vEnd: Vertex
    private var arr: [WayArr]
    var isZero: Bool

    init() {
        vStart = Vertex(i: 0)
        vEnd = Vertex(i: 0)
        arr = [WayArr]()
        isZero = true
    }

    convenience init(from: Int, to: Int) {
        self.init(from: from, to: to, noZeroLen: false)
    }

    init(from: Int, to: Int, noZeroLen: Bool) {
        vStart = Vertex(i: from)
        vEnd = Vertex(i: to)
        arr = [WayArr]()
        isZero = false

        let v = Vertex(i: from)
        while true {
            if v.isEq(vEnd) && (!noZeroLen || arr.count > 0) { break }
            if arr.count > 6 { isZero = true; break }

            let x_from = v.number % 8
            let g_from = v.number / 8
            let wayArr: WayArr
            switch x_from {
            case 0:
                let x_to = vEnd.number % 8
                if x_to == 5 || x_to == 6 {
                    wayArr = WayArr(type: .beta, i: 3 * g_from)
                    v.number += 5
                } else {
                    wayArr = WayArr(type: .alpha, i: 5 * g_from)
                    v.number += 1
                }
            case 1...4:
                wayArr = WayArr(type: .alpha, i: 5 * g_from + x_from)
                v.number += (x_from == 4 ? 3 : 1)
            case 5...6:
                wayArr = WayArr(type: .beta, i: 3 * g_from + x_from - 4)
                v.number += 1
            case 7:
                wayArr = WayArr(type: .gamma, i: g_from)
                v.number += 1
            default: fatalError("bad \(x_from)")
            }
            arr.append(wayArr)
            isZero = isZeroSmart
            if isZero { break }
        }
    }

    convenience init(way: Way) {
        self.init()
        self.setWay(way)
    }

    convenience init(way1: Way, way2: Way) {
        self.init()
        self.setWay(way1)
        self.compLeft(way2)
    }

    convenience init(from: Int, len: Int) {
        self.init(from: from, to: from + len, noZeroLen: len > 0)
    }

    convenience init(to: Int, len: Int) {
        self.init(from: to - len, to: to, noZeroLen: len > 0)
    }

    var startsWith: Vertex {
        return vStart
    }

    var endsWith: Vertex {
        return vEnd
    }

    var arrays: [WayArr] {
        return arr
    }

    var len: Int {
        return arr.count
    }

    func updateArrays(_ a: [WayArr]) {
        arr = a
    }

    func setWay(_ way: Way) {
        vStart.number = way.startsWith.number
        vEnd.number = way.endsWith.number
        arr.removeAll()
        for w in way.arrays {
            arr.append(WayArr(type: w.type, i: w.i))
        }
        isZero = way.isZero
    }

    func compRight(_ way: Way) {
        if way.isZero || isZero || !way.endsWith.isEq(vStart) {
            isZero = true
            return
        }
        var p = 0
        for w in way.arrays {
            arr.insert(WayArr(type: w.type, i: w.i), at: p)
            p += 1
        }
        vStart.number = way.startsWith.number
        isZero = isZeroSmart
    }

    func compLeft(_ way: Way) {
        if way.isZero || isZero || !way.startsWith.isEq(vEnd) {
            isZero = true
            return
        }
        for w in way.arrays {
            arr.append(WayArr(type: w.type, i: w.i))
        }
        vEnd.number = way.endsWith.number
        isZero = isZeroSmart
    }

    var str: String {
        if isZero { return "0" }
        if arr.count == 0 { return vStart.str }

        let s = PathAlg.s
        var ss = ""
        for w in arr.reversed() {
            switch w.type {
            case .alpha: ss += "a\(myMod(w.i, mod: 5 * s))"
            case .beta: ss += "b\(myMod(w.i, mod: 3 * s))"
            case .gamma: ss += "g\(myMod(w.i, mod: s))"
            }
        }
        return ss
    }

    var htmlStr: String {
        if isZero { return "0" }
        if arr.count == 0 { return vStart.htmlStr }

        let s = PathAlg.s
        var ss = ""
        for w in arr.reversed() {
            switch w.type {
            case .alpha: ss += "a\(myMod(w.i, mod: 5 * s))"
            case .beta: ss += "b\(myMod(w.i, mod: 3 * s))"
            case .gamma: ss += "&gamma;\(myMod(w.i, mod: s))"
            }
        }
        return ss
    }

    var shortStr: String {
        if isZero { return "0" }
        if arr.count == 0 { return "e" }
        var ss = ""
        var item = (ArrType.alpha, 0)
        for w in arr.reversed() {
            if item.1 == 0 || item.0 != w.type {
                if item.1 != 0 {
                    ss += (item.0 == .gamma ? "\\g" : (item.0 == .beta ? "\\b" : "\\a")) +
                        (item.1 > 1 ? "^{\(item.1)}" : "")
                }
                item = (w.type, 1)
            } else {
                item.1 += 1
            }
        }
        ss += (item.0 == .gamma ? "\\g" : (item.0 == .beta ? "\\b" : "\\a")) + (item.1 > 1 ? "^{\(item.1)}" : "")
        return ss
    }

    func isEq(_ other: Way) -> Bool {
        if isZero || other.isZero { return false }
        if !vStart.isEq(other.startsWith) || !vEnd.isEq(other.endsWith) { return false }
        if (len == 0 && other.len != 0) || (len != 0 && other.len == 0) { return false }
        return true
    }

    private var isZeroSmart: Bool {
        if arr.count > 6 { return true }
        if arr.contains(where: { $0.type == .beta }) && (arr.contains(where: { $0.type == .alpha }) || arr.count > 4) {
            return true
        }
        return false
    }
}
