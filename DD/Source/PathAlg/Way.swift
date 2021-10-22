//
//  Created by M on 30.09.21.
//

import Foundation
import AppKit

enum ArrType: Int, Equatable {
    case x, y
}

final class Way {
    private(set) var startArr: ArrType
    private(set) var len: Int
    private(set) var isZero: Bool

    init(type: ArrType, len: Int) {
        self.startArr = type
        self.len = len
        self.isZero = len > 2 * PathAlg.k
    }

    convenience init(way: Way) {
        self.init(type: way.startArr, len: way.len)
    }

    static var e: Way {
        return Way(type: .x, len: 0)
    }

    static var x: Way {
        return Way(type: .x, len: 1)
    }

    static var y: Way {
        return Way(type: .y, len: 1)
    }

    func setWay(_ way: Way) {
        startArr = way.startArr
        len = way.len
        updateIsZero()
    }

    func hasPrefix(_ way: Way) -> Bool {
        if way.isZero { return false }
        if way.len == 0 { return true }
        if len == 2 * PathAlg.k { return true }
        return way.startArr == startArr && way.len <= len
    }

    func hasSuffix(_ way: Way) -> Bool {
        if way.isZero { return false }
        if way.len == 0 { return true }
        if len == 2 * PathAlg.k { return true }
        return way.endArr == endArr && way.len <= len
    }

    var arrays: [ArrType] {
        var arr: [ArrType] = []
        var t = startArr
        for _ in (0 ..< len) {
            arr.append(t)
            switch t {
            case .x: t = .y
            case .y: t = .x
            }
        }
        return arr
    }

    var endArr: ArrType {
        if len % 2 == 0 {
            switch startArr {
            case .x: return .y
            case .y: return .x
            }
        } else {
            return startArr
        }
    }

    func canCompRight(_ way: Way) -> Bool {
        guard way.len > 0 && len > 0 else { return true }
        return way.startArr != endArr
    }

    func compRight(_ way: Way) {
        guard way.len > 0 else { return }
        if !canCompRight(way) { fatalError("Way.compRight bad way") }
        if len == 0 { startArr = way.startArr }
        len += way.len
        updateIsZero()
    }

    func canCompLeft(_ way: Way) -> Bool {
        guard way.len > 0 && len > 0 else { return true }
        return way.endArr != startArr
    }

    func compLeft(_ way: Way) {
        guard way.len > 0 else { return }
        if !canCompLeft(way) { fatalError("Way.canCompLeft bad way") }
        startArr = way.startArr
        len += way.len
        updateIsZero()
    }

    var str: String {
        if isZero { return "0" }
        if len == 0 { return "e" }
        let str0: String
        let str1: String
        switch startArr {
        case .x: str0 = "x"; str1 = "y"
        case .y: str0 = "y"; str1 = "x"
        }
        switch len {
        case 1: return str0
        case 2: return str0 + str1
        case 3: return str0 + str1 + str0
        default:
            let deg: String
            switch len / 2 {
            case PathAlg.k: deg = "k"
            case PathAlg.k-1: deg = "k-1"
            default: deg = "\(len / 2)"
            }
            let degStr = PathAlg.isTex ? "^{\(deg)}" : "<sup>" + deg + "</sup>"
            if len % 2 == 0 {
                return "(" + str0 + str1 + ")" + degStr
            } else {
                switch startArr {
                case .x:
                    return "(xy)" + degStr + "x"
                case .y:
                    return "y(xy)" + degStr
                }
            }
        }
    }

    func isEq(_ other: Way) -> Bool {
        if isZero || other.isZero { return false }
        if len != other.len { return false }
        if len == 0 || len == 2 * PathAlg.k { return true }
        return startArr == other.startArr
    }

    static var allWays: [Way] {
        var ways: [Way] = []
        var len = 0
        while true {
            let way1 = Way(type: .x, len: len)
            let way2 = Way(type: .y, len: len)
            if way1.isZero != way2.isZero { fatalError() }
            if way1.isZero { break }
            if !ways.contains(where: { way1.isEq($0) }) { ways.append(way1) }
            if !ways.contains(where: { way2.isEq($0) }) { ways.append(way2) }
            len += 1
        }
        return ways
    }

    private func updateIsZero() {
        isZero = len > 2 * PathAlg.k
    }
}
