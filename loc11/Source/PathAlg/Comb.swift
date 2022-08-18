//
//  Created by M on 22.04.16.
//

import Foundation

final class Comb {
    var label: String?
    private(set) var contents: [(NumInt, Tenzor)] = []
    private var labels: [String] = []

    static var ex: Comb {
        return Comb(left: Way.e, right: Way.x, label: "")
    }

    static var ey: Comb {
        return Comb(left: Way.e, right: Way.y, label: "")
    }

    static var xe: Comb {
        return Comb(left: Way.x,  right: Way.e, label: "")
    }

    static var ye: Comb {
        return Comb(left: Way.y,  right: Way.e, label: "")
    }
    
    init() {
        self.label = nil
    }

    init(label: String) {
        self.label = label
    }

    convenience init(tenzor: Tenzor, koef: Int) {
        self.init()
        add(tenzor: tenzor, koef: koef)
    }

    init(left: Way, right: Way, koef: Int) {
        self.label = nil
        add(tenzor: Tenzor(left: left, right: right), koef: koef)
    }

    init(left: Way, right: Way, label: String) {
        let tt = Tenzor(left: left, right: right)
        self.label = label == "" ? tt.str : label
        add(tenzor: tt, koef: 1)
    }

    init(comb: Comb) {
        self.label = nil
        for (n, t) in comb.contents {
            add(tenzor: t, koef: n.n)
        }
    }

    convenience init(comb: Comb, compRight c: Comb, updateLabel: Bool = false) {
        self.init(comb: comb)
        if updateLabel { label = comb.label }
        compRight(comb: c, updateLabel: updateLabel)
    }

    var isZero: Bool {
        return contents.isEmpty
    }

    var phi: Comb {
        let changeStrings: (String, String, String) -> String = { s, s1, s2 in
            return s.replacingOccurrences(of: s1, with: "w̃")
                .replacingOccurrences(of: s2, with: s1)
                .replacingOccurrences(of: "w̃", with: s2)
        }
        let labelPhi: (String) -> String = { s in
            return changeStrings(changeStrings(s, "x̃", "ỹ"), "x", "y")
        }
        let c = Comb(label: labelPhi(label ?? ""))
        for (n, t) in contents {
            c.add(left: t.leftComponent.phi, right: t.rightComponent.phi, koef: n.n)
        }
        return c
    }

    func add(tenzor: Tenzor, koef: Int) {
        if tenzor.isZero || NumInt.isZero(n: koef) { return }
        if let i = contents.firstIndex(where: { $0.1.isEq(tenzor) }) {
            contents[i].0.n += koef
            if contents[i].0.isZero {
                contents.remove(at: i)
            }
        } else {
            contents.append((NumInt(n: koef), Tenzor(tenzor: tenzor)))
        }
    }

    func add(left: Way, right: Way) {
        add(tenzor: Tenzor(left: left, right: right), koef: 1)
    }

    func add(left: Way, right: Way, koef: Int) {
        add(tenzor: Tenzor(left: left, right: right), koef: koef)
    }

    func add(comb: Comb) {
        if let label = comb.label {
            if let idx = labels.firstIndex(of: label) {
                labels.remove(at: idx)
            } else {
                labels.append(label)
            }
        }
        for (k, t) in comb.contents {
            add(tenzor: t, koef: k.n)
        }
    }

    func add(comb: Comb, koef: Int) {
        for (k, t) in comb.contents {
            add(tenzor: t, koef: k.n * koef)
        }
    }

    func clear() {
        contents = []
        labels = []
        label = nil
    }

    func updateLabel() {
        label = labels.joined(separator: " + ")
    }

    var str: String {
        if isZero { return "0" }
        if labels.count > 0 {
            var s = labels.joined(separator: " + ")
            if !PathAlg.isTex { return s }
            s = s.replacingOccurrences(of: "Δx̃", with: "\\Delta(\\widetilde{x})")
            s = s.replacingOccurrences(of: "Δỹ", with: "\\Delta(\\widetilde{y})")
            s = s.replacingOccurrences(of: "Δz_x", with: "\\Delta(z_x)")
            s = s.replacingOccurrences(of: "Δz_y", with: "\\Delta(z_y)")
            s = s.replacingOccurrences(of: "x̃", with: "\\widetilde{x}")
            s = s.replacingOccurrences(of: "ỹ", with: "\\widetilde{y}")
            s = s.replacingOccurrences(of: "Δ", with: "\\Delta ")
            //s = s.replacingOccurrences(of: "w_x", with: "(xy)^{k-1}")
            //s = s.replacingOccurrences(of: "w_y", with: "(yx)^{k-1}")
            s = s.replacingOccurrences(of: "*", with: "\\otimes ")
            return s
        }
        var s = ""
        for i in 0 ..< contents.count {
            let k = contents[i].0.n
            if k < 0 {
                s += k == -1 ? "-" : "\(k)"
            } else {
                if i > 0 { s += "+" }
                if k != 1 { s += "\(k)" }
            }
            s += contents[i].1.str
        }
        return s
    }

    func compKoef(_ koef: Int) {
        var hasZero = false
        contents.forEach {
            $0.0.n *= koef
            if $0.0.isZero { hasZero = true }
        }
        if hasZero {
            contents = contents.filter { !$0.0.isZero }
        }
    }

    func compRight(comb: Comb, updateLabel: Bool = false) {
        var result: [(NumInt, Tenzor)] = []
        for (k, t) in comb.contents {
            result += Comb.compRight(contents: contents, tenzor: t, koef: k.n)
        }
        contents = Comb.removeZerosAndDubles(result)
        if updateLabel, let label1 = comb.label, let label2 = self.label {
            //label = (PathAlg.isTex ? "\\left(" : "(") + label2 + (PathAlg.isTex ? "\\right)" : ")") + label1
            label = label2 + (PathAlg.isTex ? "\\cdot " : "*") + label1
        }
    }

    func eqKoef(_ other: Comb) -> Int {
        guard !contents.isEmpty && contents.count == other.contents.count else { return 0 }
        var kk = 0
        for i1 in 0 ..< contents.count {
            guard let i2 = other.contents.firstIndex(where: { contents[i1].1.isEq($0.1) }) else { return 0 }
            let k = contents[i1].0.eqKoef(other.contents[i2].0)
            if k == 0 { return 0 }
            if kk > 0 && k != kk { return 0 }
            kk = k
        }
        return kk
    }

    func isEq(_ other: Comb) -> Bool {
        return eqKoef(other) == 1
    }

    private static func compRight(contents: [(NumInt, Tenzor)], tenzor: Tenzor, koef: Int) -> [(NumInt, Tenzor)] {
        if tenzor.isZero || NumInt.isZero(n: koef) { return [] }
        var result: [(NumInt, Tenzor)] = []
        for (n, t) in contents {
            let n1 = NumInt(n: n.n * koef)
            if n1.isZero { continue }
            let t1 = Tenzor(tenzor: t)
            t1.compRight(tenzor)
            if !t1.isZero { result.append((n1, t1)) }
        }
        return removeZerosAndDubles(result)
    }

    private static func removeZerosAndDubles(_ items: [(NumInt, Tenzor)]) -> [(NumInt, Tenzor)] {
        var result: [(NumInt, Tenzor)] = []
        let myContents = items.filter { !$0.0.isZero && !$0.1.isZero }
        var hasZero = false
        for (n, w) in myContents {
            if let i = result.firstIndex(where: { $0.1.isEq(w) }) {
                result[i].0.n += n.n
                if result[i].0.isZero { hasZero = true }
            } else {
                result.append((n, w))
            }
        }
        return hasZero ? result.filter { !$0.0.isZero } : result
    }
}
