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

    func compRight(_ way: Way) {
        guard way.len > 0 else { return }
        if way.len % 2 == 0 {
            if way.startArr != startArr { fatalError("Way.compRight bad way") }
        } else {
            if way.startArr == startArr { fatalError("Way.compRight bad way") }
        }
        startArr = way.startArr
        len += way.len
        updateIsZero()
    }

    func compLeft(_ way: Way) {
        guard way.len > 0 else { return }
        if len % 2 == 0 {
            if way.startArr != startArr { fatalError("Way.compLeft bad way") }
        } else {
            if way.startArr == startArr { fatalError("Way.compLeft bad way") }
        }
        len += way.len
        updateIsZero()
    }

    var str: String {
        if isZero { return "0" }
        if len == 0 { return "1" }
        let str0: String
        let str1: String
        switch self.endArr {
        case .x: str0 = "x"; str1 = "y"
        case .y: str0 = "y"; str1 = "x"
        }
        switch len {
        case 1: return str0
        case 2: return str0 + str1
        case 3: return str0 + str1 + str0
        default:
            return "(" + str0 + str1 + ")<sup>\(len / 2)</sup>" + (len % 2 == 0 ? "" : str0)
        }
    }

    func isEq(_ other: Way) -> Bool {
        if isZero || other.isZero { return false }
        if len != other.len { return false }
        if len == 0 || len == 2 * PathAlg.k { return true }
        return startArr == other.startArr
    }

    private func updateIsZero() {
        isZero = len > 2 * PathAlg.k
    }
}
