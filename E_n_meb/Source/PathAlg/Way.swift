//
//  Created by M on 19.04.16.
//

import Foundation

enum ArrType: Int {
    case alpha
    case gamma
}

final class Way {
    private var vStart: Vertex
    private var vEnd: Vertex
    private var arr: [[NumInt]]
    var isZero: Bool

    init() {
        vStart = Vertex()
        vEnd = Vertex()
        arr = [[NumInt]]()
        isZero = true
    }

    convenience init(from: Int, to: Int) {
        self.init(from: from, to: to, noZeroLen: false)
    }

    init(from: Int, to: Int, noZeroLen: Bool) {
        vStart = Vertex(i: from)
        vEnd = Vertex(i: to)
        arr = [[NumInt]]()
        isZero = false

        let s = PathAlg.s
        let v = Vertex(i: from)
        let r_to = vEnd.number / 4

        while true {
            if v.isEq(vEnd) && (!noZeroLen || arr.count > 0) { break }

            if arr.count > 4 {
                isZero = true
                break
            }

            var r_from = v.number / 4
            let x_from = v.number % 4

            var resType = ArrType.alpha
            var resArr = 0

            switch x_from {
            case 0:
                if r_to >= s {
                    if r_from < s { r_from += s }
                } else {
                    if r_from >= s { r_from -= s }
                }
                resType = .alpha
                resArr = 3 * r_from
                v.number = 4 * r_from + 1
            case 1...2:
                resType = .alpha
                resArr = 3 * r_from + x_from
                v.number += 1
            case 3:
                resType = .gamma
                resArr = r_from
                v.number += 1
            default:
                break
            }
            arr.append([ NumInt(intValue: resType.rawValue), NumInt(intValue: resArr) ])
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

    var arrays: [[NumInt]] {
        return arr
    }

    var len: Int {
        return arr.count
    }

    func setWay(_ way: Way) {
        vStart.number = way.startsWith.number
        vEnd.number = way.endsWith.number
        arr.removeAll()
        for w in way.arrays {
            arr.append([ NumInt(intValue: w.first!.intValue), NumInt(intValue: w.last!.intValue) ])
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
            arr.insert([ NumInt(intValue: w.first!.intValue), NumInt(intValue: w.last!.intValue) ], at: p)
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
            arr.append([ NumInt(intValue: w.first!.intValue), NumInt(intValue: w.last!.intValue) ])
        }
        vEnd.number = way.endsWith.number
        isZero = isZeroSmart
    }

    var str: String {
        if isZero { return "0" }
        if arr.count == 0 { return vStart.str }

        let s = PathAlg.s
        var ss = ""
        for w in arr {
            let isG = w.first!.intValue == ArrType.gamma.rawValue
            let koef = myMod(w.last!.intValue, mod: isG ? s : 6 * s)
            ss += isG ? "g\(koef)" : "a\(koef)"
        }
        return ss
    }

    var htmlStr: String {
        if isZero { return "0" }
        if arr.count == 0 { return vStart.htmlStr }

        let s = PathAlg.s
        var ss = ""
        for w in arr {
            let isG = w.first!.intValue == ArrType.gamma.rawValue
            let koef = myMod(w.last!.intValue, mod: isG ? s : 6 * s)
            ss += isG ? "&gamma;\(koef)" : "a\(koef)"
        }
        return ss
    }

    var shortStr: String {
        if isZero { return "0" }
        if arr.count == 0 { return "e" }
        var ss = ""
        /*let s = PathAlg.s
        for w in arr.reversed() {
            let isG = w.first!.intValue == ArrType.gamma.rawValue
            let koef = myMod(w.last!.intValue, mod: isG ? s : 6 * s)
            ss += isG ? "\\g_{\(koef)}" : "\\a_{\(koef)}"
        }*/

        var item = (0, 0)
        for w in arr.reversed() {
            let type = w.first!.intValue == ArrType.gamma.rawValue ? 1 : 2
            if item.0 == type {
                item.1 += 1
            } else {
                if item.1 != 0 {
                    ss += (item.0 == 1 ? "\\g" : "\\a") + (item.1 > 1 ? "^{\(item.1)}" : "")
                }
                item = (type, 1)
            }
        }
        ss += (item.0 == 1 ? "\\g" : "\\a") + (item.1 > 1 ? "^{\(item.1)}" : "")
        return ss
    }

    func isEq(_ other: Way) -> Bool {
        if isZero || other.isZero { return false }
        if len != other.len { return false }
        if !vStart.isEq(other.startsWith) || !vEnd.isEq(other.endsWith) { return false }
        return true
    }

    private var isZeroSmart: Bool {
        if arr.count > 4 { return true }

        let s = PathAlg.s
        
        let x_from = vStart.number % 4
        let x_to = vEnd.number % 4

        if vStart.number == vEnd.number && arr.count > 0 {
            return x_from == 1 || x_from == 2
        }

        if (x_from == 1 || x_from == 2) && (x_to == 1 || x_to == 2) {
            var d = vEnd.number - vStart.number
            if d < 0 { d += 8 * s }
            if d > 4 { return true }
        }
        return false
    }
}
