//
//  Created by M on 30.09.21.
//

import Foundation
import AppKit

enum ArrType: Int, Equatable, CaseIterable {
    case x, y

    var str: String {
        switch self {
        case .x: return "x"
        case .y: return "y"
        }
    }

    var next: ArrType {
        switch self {
        case .x: return .y
        case .y: return .x
        }
    }
}

final class Way {
    private(set) var endArr: ArrType
    private(set) var len: Int
    private(set) var isZero: Bool

    init(type: ArrType, len: Int) {
        self.endArr = type
        self.len = len
        self.isZero = false
        updateIsZero()
    }

    convenience init(way: Way) {
        self.init(type: way.endArr, len: way.len)
    }

    static var zero: Way {
        return Way(type: .x, len: 2 * PathAlg.kk + 1)
    }

    static var e: Way { return Way(type: .x, len: 0) }
    static var x: Way { return Way(type: .x, len: 1) }
    static var y: Way { return Way(type: .y, len: 1) }
    static var xx: Way { return Way(type: .x, len: 2 * PathAlg.kk) }
    static var xy: Way { return Way(type: .x, len: 2) }
    static var yx: Way { return Way(type: .y, len: 2) }
    static var xyx: Way { return Way(type: .x, len: 3) }
    static var yxy: Way { return Way(type: .y, len: 3) }
    static var zx: Way { return Way(type: .x, len: 2 * PathAlg.kk - 1) }
    static var zy: Way { return Way(type: .y, len: 2 * PathAlg.kk - 1) }
    static var wx: Way { return Way(type: .x, len: 2 * PathAlg.kk - 2) }
    static var wy: Way { return Way(type: .y, len: 2 * PathAlg.kk - 2) }

    func setWay(_ way: Way) {
        endArr = way.endArr
        len = way.len
        updateIsZero()
    }

    func hasPrefix(_ way: Way) -> Bool {
        if let twin = twin, twin.hasPrefixNoTwin(way) { return true }
        return hasPrefixNoTwin(way)
    }

    func hasPrefixNoTwin(_ way: Way) -> Bool {
        if way.isZero { return false }
        if way.isEq(self) || way.len == 0 { return true }
        return way.endArr == endArr && way.len < len
    }

    func hasSuffix(_ way: Way) -> Bool {
        if let twin = twin, twin.hasSuffixNoTwin(way) { return true }
        return hasSuffixNoTwin(way)
    }

    func hasSuffixNoTwin(_ way: Way) -> Bool {
        if way.isZero { return false }
        if way.isEq(self) || way.len == 0 { return true }
        return way.startArr == startArr && way.len < len
    }

    var startArr: ArrType {
        return len % 2 == 0 ? Way.nextArray(after: endArr) : endArr
    }

    var phi: Way {
        return Way(type: Way.nextArray(after: endArr), len: len)
    }

    static func nextArray(after t: ArrType) -> ArrType {
        switch t {
        case .x: return .y
        case .y: return .x
        }
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
        if isZero || way.len == 0 { return }
        if len == 0 { setWay(way); return }
        if len + way.len == 2 && endArr == .x && way.endArr == .x { len = maxLen; return }
        if len + way.len == 2 && endArr == .y && way.endArr == .y { len = maxLen; return }
        if isRight && startArr == way.endArr { isZero = true; return }
        if !isRight {
            if endArr == way.startArr { isZero = true; return }
            endArr = way.endArr
        }
        len += way.len
        updateIsZero()
    }

    var str: String {
        if isZero { return "0" }
        if len == 0 { return "1" }
        if len == maxLen { return "x" + Utils.supStr("2") }
        if len == maxLen - 1 { return "z" + Utils.subStr(endArr.str) }
        if len == maxLen - 2 { return "w" + Utils.subStr(endArr.str) }
        if len == 1 { return endArr.str }
        if len == 2 { return endArr.str + Way.nextArray(after: endArr).str }
        if len == 3 { return endArr.str + Way.nextArray(after: endArr).str + endArr.str }
        let lenStr = Utils.supStr("\(len / 2)")
        if len % 2 == 0 {
            return "(" + endArr.str + Way.nextArray(after: endArr).str + ")" + lenStr
        } else {
            return endArr.str + "(" + Way.nextArray(after: endArr).str + endArr.str + ")" + lenStr
        }
    }

    var twin: Way? {
        if len != maxLen { return nil }
        return Way(type: Way.nextArray(after: endArr), len: len)
    }

    func isEq(_ other: Way) -> Bool {
        if isZero || other.isZero { return false }
        if len != other.len { return false }
        if len == 0 || len == maxLen { return true }
        return endArr == other.endArr
    }

    private static var allWaysCache: (String, [Way])?

    static var allWays: [Way] {
        let cacheKey = "\(PathAlg.kk)"
        if let cache = allWaysCache, cache.0 == cacheKey { return cache.1 }
        var ways: [Way] = [Way(type: .x, len: 0)]
        var len = 1
        while true {
            //if len == 2 * PathAlg.kk { break }
            let ww = ArrType.allCases.map { Way(type: $0, len: len) }
            var hasW = false
            for w in ww {
                if w.isZero { continue }
                hasW = true
                if !ways.contains(where: { w.isEq($0) }) { ways.append(w) }
            }
            if !hasW { break }
            len += 1
        }
        allWaysCache = (cacheKey, ways)
        return ways
    }

    private func updateIsZero() {
        isZero = len > maxLen
    }

    private var maxLen: Int {
        return 2 * PathAlg.kk
    }
}
