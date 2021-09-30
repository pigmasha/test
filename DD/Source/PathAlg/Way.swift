//
//  Created by M on 30.09.21.
//

import Foundation
import AppKit

enum ArrType: Int, Equatable {
    case x, y
}

final class Way {
    private var arr: [ArrType]
    private(set) var isZero: Bool

    init() {
        arr = []
        isZero = true
    }

    init(type: ArrType, len: Int) {
        guard len <= 2 * PathAlg.k else {
            arr = []
            isZero = true
            return
        }
        arr = []
        var t = type
        for _ in (0 ..< len) {
            arr.append(t)
            switch t {
            case .x: t = .y
            case .y: t = .x
            }
        }
        isZero = false
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

    var arrays: [ArrType] {
        return arr
    }

    var len: Int {
        return arr.count
    }

    func compRight(_ way: Way) {
        arr = way.arrays + arr
        updateIsZero()
    }

    func compLeft(_ way: Way) {
        arr += way.arrays
        updateIsZero()
    }

    var str: String {
        if isZero { return "0" }
        if arr.count == 0 { return "1" }

        var ss = ""
        var nxy = 0
        var nyx = 0
        for w in arr.reversed() {
            switch w {
            case .x: ss += "x"
            case .y: ss += "y"
            }
            if ss == "xy" { nxy += 1; ss = "" }
            if nxy == 0 && ss == "yx" { nyx += 1; ss = "" }
        }
        if nxy == 0 && nyx == 0 { return ss }
        if nxy == 1 { return "xy" + ss }
        if nyx == 1 { return "yx" + ss }
        if nxy != 0 { return "(xy)<sup>\(nxy)</sup>" + ss }
        return "(yx)<sup>\(nyx)</sup>" + ss
    }

    func isEq(_ other: Way) -> Bool {
        if isZero || other.isZero { return false }
        if len != other.len { return false }
        if len == 0 { return true }
        if len == 2 * PathAlg.k { // (xy)^k=(yx)^k
            var xy1 = true
            var xy2 = true
            for i in 1 ..< len {
                if arr[i - 1] == arr[i] { xy1 = false }
                if other.arr[i - 1] == other.arr[i] { xy2 = false }
                if !xy1 && !xy2 { break }
            }
            if xy1 && xy2 { return true }
        }
        for i in 0 ..< len {
            if arr[i] != other.arr[i] { return false }
        }
        return true
    }

    private func setWay(_ way: Way) {
        arr = way.arrays
        updateIsZero()
    }

    private func updateIsZero() {
        isZero = arr.count > 2 * PathAlg.k
    }
}
