//
//  Created by M on 30.09.21.
//

import Foundation
import AppKit

enum ArrType: Int, Equatable, CaseIterable {
    case alpha, beta

    var str: String {
        switch self {
        case .alpha: return "a"
        case .beta: return "b"
        }
    }
}

private enum WayType: Equatable {
    case e(Int), array(ArrType, Int), two(Int), zero
}

final class Way {
    private var type: WayType

    init() {
        type = .zero
    }

    init(e vertex: Int) {
        type = .e(vertex)
    }

    init(two vertex: Int) {
        type = .two(vertex)
    }

    init(type: ArrType, num: Int) {
        self.type = .array(type, num)
    }

    init(from: Int, to: Int) {
        let n = PathAlg.n
        if from == to {
            type = .e(from)
        } else {
            switch from {
            case 1, 2:
                type = to == 3 ? .array(.alpha, from) : .zero
            case 3:
                switch to {
                case 1, 2: type = .array(.beta, to)
                case 4: type = .array(.alpha, from)
                default: type = n == 4 && to == 5 ? .array(.alpha, 4) : .zero
                }
            default:
                if from == n || from == n + 1 {
                    type = to == n - 1 ? .array(.beta, from - 1) : .zero
                } else if from == n - 1 {
                    if to == n || to == n + 1 {
                        type = .array(.alpha, to - 1)
                    } else {
                        type = to == n - 2 ? .array(.beta, to) : .zero
                    }
                } else {
                    type = to == from + 1 ? .array(.alpha, from) : (to == from - 1 ? .array(.beta, to) : .zero)
                }
            }
        }
    }

    convenience init(way: Way) {
        self.init()
        setWay(way)
    }

    static var e1: Way { return Way(e: 1) }
    static var e2: Way { return Way(e: 2) }
    static var e3: Way { return Way(e: 3) }
    static var e4: Way { return Way(e: 4) }
    static var e5: Way { return Way(e: 5) }

    static var a1: Way { return Way(type: .alpha, num: 1) }
    static var a2: Way { return Way(type: .alpha, num: 2) }
    static var a3: Way { return Way(type: .alpha, num: 3) }
    static var a4: Way { return Way(type: .alpha, num: 4) }

    static var b1: Way { return Way(type: .beta, num: 1) }
    static var b2: Way { return Way(type: .beta, num: 2) }
    static var b3: Way { return Way(type: .beta, num: 3) }
    static var b4: Way { return Way(type: .beta, num: 4) }

    var isZero: Bool {
        return type == .zero
    }

    var len: Int {
        switch type {
        case .e, .zero: return 0
        case .array: return 1
        case .two: return 2
        }
    }

    var hasBeta: Bool {
        switch type {
        case .e, .zero:
            return false
        case .array(let arrType, _):
            return arrType == .beta
        case .two:
            return true
        }
    }

    var startVertex: Int {
        switch type {
        case .e(let v):
            return v
        case .array(let arrType, let i):
            let n = PathAlg.n
            switch arrType {
            case .alpha: return i == n ? n - 1 : i
            case .beta: return i == 1 ? 3 : i + 1
            }
        case .two(let v):
            return v
        case .zero:
            return 0
        }
    }

    var endVertex: Int {
        switch type {
        case .e(let v):
            return v
        case .array(let arrType, let i):
            let n = PathAlg.n
            switch arrType {
            case .alpha: return i == 1 ? 3 : i + 1
            case .beta: return i == n ? n - 1 : i
            }
        case .two(let v):
            return v
        case .zero:
            return 0
        }
    }

    static var zero: Way {
        return Way.init()
    }

    func setWay(_ way: Way) {
        self.type = way.type
    }

    // xy.hasPefix(x)
    func hasPrefix(_ way: Way) -> Bool {
        if way.isZero { return false }
        if way.isEq(self) { return true }
        return way.endVertex == endVertex && way.len < len
    }

    func hasSuffix(_ way: Way) -> Bool {
        if way.isZero { return false }
        if way.isEq(self) { return true }
        return way.startVertex == startVertex && way.len < len
    }

    // xy: endArr=x
    // xy.compRight(x) = xyx
    func compRight(_ way: Way) {
        comp(way, isRight: true)
    }

    //
    func compLeft(_ way: Way) {
        comp(way, isRight: false)
    }

    private func comp(_ way: Way, isRight: Bool) {
        if isZero { return }
        if way.isZero || len + way.len > 2 { type = .zero; return }
        if isRight && way.endVertex != startVertex { type = .zero; return }
        if !isRight && way.startVertex != endVertex { type = .zero; return }
        if way.len == 0 { return }
        if len == 0 {
            type = way.type
            return
        }
        switch way.type {
        case .e, .zero, .two:
            fatalError("Bad way.compRight type")
        case .array(let arrType1, let i1):
            switch type {
            case .e, .two, .zero:
                fatalError("Bad way.compRight type")
            case .array(let arrType2, let i2):
                if arrType1 == arrType2 || i1 != i2 {
                    type = .zero
                } else {
                    type = .two(isRight ? endVertex : startVertex)
                }
            }
        }
    }

    var str: String {
        switch type {
        case .e(let i):
            return "e" + Utils.subStr(i)
        case .array(let arrType, let i):
            return arrType.str + Utils.subStr(i)
        case .two(let i):
            if i == 1 || i == 2 {
                return ArrType.beta.str + Utils.subStr(i) + ArrType.alpha.str + Utils.subStr(i)
            }
            return ArrType.alpha.str + Utils.subStr(i - 1) + ArrType.beta.str + Utils.subStr(i - 1)
        case .zero:
            return "0"
        }
    }

    var strProg: String {
        switch type {
        case .e(let i):
            return "Way.e\(i)"//"Way(e: \(i))"
        case .array(let arrType, let i):
            return "Way.\(arrType.str)\(i)"//(type: .\(arrType == .alpha ? "alpha" : "beta"), num: \(i))"
        case .two(let i):
            return "Way(two: \(i))"
        case .zero:
            return "Way()"
        }
    }

    func isEq(_ other: Way) -> Bool {
        if type != other.type { return false }
        switch type {
        case .e, .array, .two:
            return startVertex == other.startVertex
        case .zero:
            return false
        }
    }

    private static var allWaysCache: (String, [Way])?

    static var allWays: [Way] {
        let cacheKey = "\(PathAlg.n)"
        if let cache = allWaysCache, cache.0 == cacheKey { return cache.1 }
        let n = PathAlg.n
        var ways: [Way] = []
        for i in 1 ... n + 1 {
            ways.append(Way(e: i))
        }
        for i in 1 ... n {
            ways.append(Way(type: .alpha, num: i))
            ways.append(Way(type: .beta, num: i))
        }
        for i in 1 ... n + 1 {
            ways.append(Way(two: i))
        }
        allWaysCache = (cacheKey, ways)
        return ways
    }
}
