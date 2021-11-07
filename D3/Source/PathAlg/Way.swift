//
//  Created by M on 30.09.21.
//

import Foundation
import AppKit

enum ArrType: Int, Equatable, CaseIterable {
    case a21, a12, a32, a23, a31, a13
}

enum VertexType: Int, Equatable, CaseIterable {
    case e1, e2, e3

    var str: String {
        switch self {
        case .e1: return "1"
        case .e2: return "2"
        case .e3: return "3"
        }
    }
}

final class Way {
    private(set) var endArr: ArrType
    private(set) var len: Int
    private(set) var isZero: Bool

    init(type: ArrType, len: Int) {
        if len == 0 { fatalError() }
        self.endArr = type
        self.len = len
        self.isZero = false
        updateIsZero()
    }

    init(vertexType: VertexType) {
        switch vertexType {
        case .e1: endArr = .a12
        case .e2: endArr = .a23
        case .e3: endArr = .a32
        }
        self.len = 0
        self.isZero = false
        updateIsZero()
    }

    convenience init(way: Way) {
        if way.len == 0 {
            self.init(vertexType: way.startVertex)
        } else {
            self.init(type: way.endArr, len: way.len)
        }
    }

    func setWay(_ way: Way) {
        endArr = way.endArr
        len = way.len
        updateIsZero()
    }

    func hasPrefix(_ way: Way) -> Bool {
        if way.isZero { return false }
        if way.isEq(self) { return true }
        if way.startVertex != startVertex { return false }
        if way.len == 0 { return true }
        return way.startArr == startArr && way.len < len
    }

    func hasSuffix(_ way: Way) -> Bool {
        if way.isZero { return false }
        if way.isEq(self) { return true }
        if way.endVertex != endVertex { return false }
        if way.len == 0 { return true }
        return way.endArr == endArr && way.len < len
    }

    var startArr: ArrType {
        return len % 2 == 0 ? Way.nextArray(after: endArr) : endArr
    }

    var startVertex: VertexType {
        if len == 0 { return endVertex }
        let a = startArr
        switch a {
        case .a12: return .e2
        case .a21: return .e1
        case .a13: return .e3
        case .a31: return .e1
        case .a23: return .e3
        case .a32: return .e2
        }
    }

    var endVertex: VertexType {
        switch endArr {
        case .a12: return .e1
        case .a21: return .e2
        case .a13: return .e1
        case .a31: return .e3
        case .a23: return .e2
        case .a32: return .e3
        }
    }

    private var arrays: [ArrType] {
        var arr: [ArrType] = []
        var t = endArr
        for _ in (0 ..< len) {
            arr.insert(t, at: 0)
            t = Way.nextArray(after: t)
        }
        return arr
    }

    private static func nextArray(after t: ArrType) -> ArrType {
        switch t {
        case .a12: return .a21
        case .a21: return .a12
        case .a13: return .a31
        case .a31: return .a13
        case .a23: return .a32
        case .a32: return .a23
        }
    }

    func compRight(_ way: Way) {
        if isZero { return }
        if startVertex != way.endVertex { isZero = true; return }
        if way.len == 0 { return }
        if len == 0 { endArr = way.endArr }
        if endArr != way.endArr && endArr != Way.nextArray(after: way.endArr) { isZero = true; return }
        len += way.len
        updateIsZero()
    }

    func compLeft(_ way: Way) {
        if isZero { return }
        if endVertex != way.startVertex { isZero = true; return }
        if way.len == 0 { return }
        if len == 0 { endArr = way.endArr }
        if endArr != way.endArr && endArr != Way.nextArray(after: way.endArr) { isZero = true; return }
        endArr = way.endArr
        len += way.len
        updateIsZero()
    }

    var str: String {
        if isZero { return "0" }
        if len == 0 {
            let prefix = PathAlg.isTex ? "e_{" : "e<sub>"
            let suffix = PathAlg.isTex ? "}" : "</sub>"
            switch startVertex {
            case .e1: return prefix + "1" + suffix
            case .e2: return prefix + "2" + suffix
            case .e3: return prefix + "3" + suffix
            }
        }
        let alphaPrefix = PathAlg.isTex ? "\\a_{" : "&alpha;<sub>"
        let suffix = len == 2 || len == 3 ? (PathAlg.isTex ? "}" : "</sub>") : (PathAlg.isTex ? "}^{\(len / 2)}" : "</sub><sup>\(len / 2)</sup>")
        if len % 2 == 0 {
            let betaPrefix = PathAlg.isTex ? "\\b_{" : "&beta;<sub>"
            switch endArr {
            case .a21: return betaPrefix + "2" + suffix
            case .a12: return alphaPrefix + "1" + suffix
            case .a32: return betaPrefix + "3" + suffix
            case .a23: return alphaPrefix + "2" + suffix
            case .a31: return alphaPrefix + "3" + suffix
            case .a13: return betaPrefix + "1" + suffix
            }
        } else {
            let aPrefix = PathAlg.isTex ? "a_{" : "a<sub>"
            let aSuffix = PathAlg.isTex ? "}" : "</sub>"
            let typeToStr: (ArrType) -> String = { t in
                switch t {
                case .a21: return "21"
                case .a12: return "12"
                case .a32: return "32"
                case .a23: return "23"
                case .a31: return "31"
                case .a13: return "13"
                }
            }
            if len == 1 {
                return aPrefix + typeToStr(endArr) + aSuffix
            }
            switch endArr {
            case .a21: return aPrefix + typeToStr(endArr) + aSuffix + alphaPrefix + "1" + suffix
            case .a12: return alphaPrefix + "1" + suffix + aPrefix + typeToStr(endArr) + aSuffix
            case .a32: return aPrefix + typeToStr(endArr) + aSuffix + alphaPrefix + "2" + suffix
            case .a23: return alphaPrefix + "2" + suffix + aPrefix + typeToStr(endArr) + aSuffix
            case .a13: return aPrefix + typeToStr(endArr) + aSuffix + alphaPrefix + "3" + suffix
            case .a31: return alphaPrefix + "3" + suffix + aPrefix + typeToStr(endArr) + aSuffix
            }
        }
    }

    func isEq(_ other: Way) -> Bool {
        if isZero || other.isZero { return false }
        if len == 0 { return startVertex == other.startVertex }
        switch endArr {
        case .a21:
            if len == 2 * PathAlg.n3 && other.len == 2 * PathAlg.n1 && other.endArr == .a23 { return true }
        case .a12:
            if len == 2 * PathAlg.n3 && other.len == 2 * PathAlg.n2 && other.endArr == .a13 { return true }
        case .a32:
            if len == 2 * PathAlg.n1 && other.len == 2 * PathAlg.n2 && other.endArr == .a31 { return true }
        case .a23:
            if len == 2 * PathAlg.n1 && other.len == 2 * PathAlg.n3 && other.endArr == .a21 { return true }
        case .a31:
            if len == 2 * PathAlg.n2 && other.len == 2 * PathAlg.n1 && other.endArr == .a32 { return true }
        case .a13:
            if len == 2 * PathAlg.n2 && other.len == 2 * PathAlg.n3 && other.endArr == .a12 { return true }
        }
        return len == other.len && endArr == other.endArr
    }

    static var allWays: [Way] {
        var ways: [Way] = VertexType.allCases.map { Way(vertexType: $0) }
        var len = 1
        while true {
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
        return ways
    }

    private func updateIsZero() {
        switch endArr {
        case .a21, .a12: isZero = len > 2 * PathAlg.n3
        case .a32, .a23: isZero = len > 2 * PathAlg.n1
        case .a31, .a13: isZero = len > 2 * PathAlg.n2
        }
    }
}
