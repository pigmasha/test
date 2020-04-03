//
//  Created by M on 22.04.16.
//

import Foundation

final class Comb {
    private var tenzors: [TenzorPair]
    var isPotential = false
    var isFirstStep = false
    var isOnlyZero = false

    init() {
        tenzors = [TenzorPair]()
    }

    init(tenzor: Tenzor, koef: Double) {
        tenzors = [TenzorPair]()
        if !tenzor.isZero && koef != 0 {
            addTenzor(tenzor, koef: koef)
        }
    }

    init(comb: Comb) {
        tenzors = [TenzorPair]()
        addComb(comb)
    }

    var content: [TenzorPair] {
        return tenzors
    }

    var isZero: Bool {
        return tenzors.count == 0
    }

    func compRightW(_ way: Way) {
        for item in tenzors {
            item.tenzor.compRightW(way)
        }
        normalForm()
    }

    func compLeftW(_ way: Way) {
        for item in tenzors {
            item.tenzor.compLeftW(way)
        }
        normalForm()
    }

    func compRightT(_ tenzor: Tenzor) {
        for item in tenzors {
            item.tenzor.compRight(tenzor)
        }
        normalForm()
    }

    func compRight(_ comb: Comb) {
        if (isZero) { return }

        let c = Comb(comb: self)
        tenzors.removeAll()
        if (comb.isZero) { return }

        for item in comb.content {
            let c2 = Comb(comb: c)
            c2.compRightT(item.tenzor)
            c2.compKoef(item.koef)
            addComb(c2)
        }
        normalForm()
    }

    func compKoef(_ koef: Double) {
        for item in tenzors {
            item.koef *= koef
        }
        normalForm()
    }

    func addComb(_ comb: Comb) {
        for item in comb.content {
            tenzors.append(TenzorPair(tenzor: Tenzor(tenzor: item.tenzor), koef: Double(item.koef)))
        }
        normalForm()
    }

    func addComb(_ comb: Comb, koef: Double) {
        for item in comb.content {
            tenzors.append(TenzorPair(tenzor: Tenzor(tenzor: item.tenzor), koef: Double(item.koef * koef)))
        }
        normalForm()
    }

    func setComb(_ comb: Comb) {
        tenzors.removeAll()
        addComb(comb)
    }

    func twist(backward: Bool = false) {
        let sk = backward ? -1 : 1

        for item in tenzors {
            let way = item.tenzor.leftComponent

            var arrays: [WayArr] = []
            for arrow in way.arrays {
                let a: WayArr
                switch arrow.type {
                case .alpha:
                    a = WayArr(type: arrow.type, i: arrow.i + 15 * 5 * sk)
                    if arrow.i % 5 != 4 {
                        item.koef *= -1
                    }
                case .beta:
                    a = WayArr(type: arrow.type, i: arrow.i + 15 * 3 * sk)
                    if arrow.i % 3 != 0 {
                        item.koef *= -1
                    }
                case .gamma:
                    a = WayArr(type: arrow.type, i: arrow.i + 15 * sk)
                    item.koef *= -1
                }
                arrays += [a]
            }
            way.updateArrays(arrays)
            way.startsWith.number = PathAlg.sigma(way.startsWith.number)
            way.endsWith.number = PathAlg.sigma(way.endsWith.number)
        }
        normalForm()
    }

    func hasSummand(_ comb: Comb) -> Bool {
        if (comb.content.count != 1) { return false }
        let p = comb.content.last!
        for item in tenzors {
            if item.koef == p.koef && item.tenzor.isEq(p.tenzor) { return true }
        }
        return false
    }

    func addTenzor(_ tenzor: Tenzor, koef: Double) {
        tenzors.append(TenzorPair(tenzor: Tenzor(tenzor: tenzor), koef: koef))
        normalForm()
    }

    func setKoef(_ koef: Double) {
        tenzors.first?.koef = koef
    }

    func terminateKoef(isLast: Bool) -> Double {
        return (isLast ? tenzors.last?.koef : tenzors.first?.koef) ?? 0
    }

    func terminateTenzor(isLast: Bool) -> Tenzor? {
        return isLast ? tenzors.last?.tenzor : tenzors.first?.tenzor
    }

    var str: String {
        if isZero { return "0" }
        var ss = ""
        for item in tenzors {
            let koef = Int(item.koef)
            if koef > 0 && ss != "" { ss += "+" }
            if koef != 1 {
                ss += (koef == -1) ? "-" : "\(koef)"
            }
            ss += item.tenzor.str
        }
        return ss
    }

    var htmlStr: String {
        if isZero {
            return isPotential ? "&bull;" : (isFirstStep ? "&#x1f43d;" : "&nbsp;&nbsp;&nbsp;")
        }
        var ss = isFirstStep ? "<b> " : ""
        var is1 = true
        for item in tenzors {
            let koef = Int(item.koef)
            if koef > 0 && !is1 { ss += "+" }
            is1 = false
            if koef != 1 {
                ss += (koef == -1) ? "-" : "\(koef)"
            }
            ss += item.tenzor.htmlStr
        }
        return ss + (isFirstStep ? "</b>" : "")
    }

    func compareK(_ other: Comb) -> Double {
        if isZero { return other.isZero ? 1 : 0 }
        if other.isZero { return 0 }

        if tenzors.count != other.content.count { return 0 }

        var koef1 = 0.0
        var koef2 = 0.0

        let charK = Double(PathAlg.charK)

        for item in tenzors {
            var kk1 = 0.0
            var kk2 = 0.0
            for item2 in other.content {
                if item2.tenzor.isEq(item.tenzor) {
                    kk1 = item2.koef
                    kk2 = item.koef
                    break
                }
            }

            if (charK > 0) {
                while (kk1 < 0) { kk1 += charK }
                while (kk1 >= charK) { kk1 -= charK }
                while (kk2 < 0) { kk2 += charK }
                while (kk2 >= charK) { kk2 -= charK }
            }
            if (kk1 == 0) { return 0 }

            if (koef1 != 0) {
                if (PathAlg.charK == 0) {
                    if (koef1 * kk2 != koef2 * kk1) { return 0 }
                } else {
                    let k1 = Int(koef1 * kk2 - koef2 * kk1)
                    if (k1 % PathAlg.charK != 0) { return 0 }
                }
            }
            koef1 = kk1
            koef2 = kk2
        }
        return (koef2 == 0) ? 0 : koef1 / koef2
    }

    private func normalForm() {
        let charK = PathAlg.charK
        var hasElem = true
        while (hasElem) {
            hasElem = false

            for i in 0..<tenzors.count {
                let pp1 = tenzors[i]
                let koef = Int(pp1.koef)
                if (charK == 0 && koef == 0) || (charK > 0  && (koef % charK == 0)) || pp1.tenzor.isZero {
                    tenzors.remove(at: i)
                    hasElem = true
                    break
                }

                for j in 0..<i {
                    let pp2 = tenzors[j]
                    if pp2.tenzor.isEq(pp1.tenzor) {
                        pp2.koef = pp2.koef + pp1.koef
                        tenzors.remove(at: i)
                        hasElem = true
                        break
                    }
                }
                if (hasElem) { break }
            }
        }
    }
}
