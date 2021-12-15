//
//  Step_8_tex.swift
//
//  Created by M on 08.12.2021.
//

import Foundation

struct Step_8_tex {
    static func runCase() -> Bool {
        //return genRelationsSwift()
        var genToDeg: [String: Int] = [:]
        for i in 0 ... 3 {
            if i > 0 {
                PathAlg.charK = i == 1 ? PathAlg.n1 : (i == 2 ? PathAlg.n2 : PathAlg.n3)
            }
            let gens = GenCreate.allElements
            for g in gens {
                genToDeg[g.label] = g.deg
            }
        }
        guard let sections = self.sections else { return true }
        OutputFile.writeLog(.simple, "<pre>\n")
        for s in sections {
            if s.label == "" && s.zeroRelations.isEmpty && s.relations.isEmpty { continue }
            if s.zeroRelations.isEmpty && s.relations.isEmpty { return true }
            let sfx = s.label == "" ? "" : conditions.first(where: { $0.1 == s.label })!.2
            OutputFile.writeLog(.simple, "-- степени \(s.deg)\(sfx):$$\n")
            var is1 = true
            for r in s.zeroRelations {
                guard let str = tex(for: r, deg: s.deg, genToDeg) else { return true }
                if !is1 { OutputFile.writeLog(.simple, ",\\text{ }") }; is1 = false
                OutputFile.writeLog(.simple, str)
            }
            for r in s.relations {
                guard let str = tex(for: r, deg: s.deg, genToDeg) else { return true }
                if !is1 { OutputFile.writeLog(.simple, ",\\text{ }") }; is1 = false
                OutputFile.writeLog(.simple, str)
            }
            for r in s.sumRelations {
                guard let str = tex(for: r, deg: s.deg, genToDeg) else { return true }
                if !is1 { OutputFile.writeLog(.simple, ",\\text{ }") }; is1 = false
                OutputFile.writeLog(.simple, str)
            }
            OutputFile.writeLog(.simple, ";$$\n")
        }
        OutputFile.writeLog(.simple, "</pre>\n")
        return false
    }

    private static func tex(for items: [String], deg: Int, _ genToDeg: [String: Int]) -> String? {
        var d = 0
        for i in items { d += genToDeg[i]! }
        if d != deg { OutputFile.writeLog(.error, "Bad deg for \(items): \(deg), should be \(d)"); return nil }
        guard let s0 = genToTex[items[0]] else { OutputFile.writeLog(.error, "Unknown gen " + items[0]); return nil }
        if items.count == 1 { return s0 }
        var c = items.count
        for j in 1 ..< items.count {
            if items[j] != items[0] { c = j; break }
        }
        let degStr: String
        switch c {
        case 1: degStr = ""
        case PathAlg.n1 - 1: degStr = "n_1-1"
        case PathAlg.n1: degStr = "n_1"
        case PathAlg.n1 + 1: degStr = "n_1+1"
        case PathAlg.n2 - 1: degStr = "n_2-1"
        case PathAlg.n2: degStr = "n_2"
        case PathAlg.n2 + 1: degStr = "n_2+1"
        case PathAlg.n3 - 1: degStr = "n_3-1"
        case PathAlg.n3: degStr = "n_3"
        case PathAlg.n3 + 1: degStr = "n_3+1"
        default: degStr = "\(c)"
        }
        var str = s0
        if degStr != "" {
            if degStr.lengthOfBytes(using: .utf8) == 1 {
                str += "^" + degStr
            } else {
                str += "^{" + degStr + "}"
            }
        }
        if c == items.count { return str }
        for j in c ..< items.count {
            guard let s1 = genToTex[items[j]] else { OutputFile.writeLog(.error, "Unknown gen " + items[j]); return nil }
            str += s1
        }
        return str
    }

    private static func tex(for relation: ([String], [String], String, Int), deg: Int, _ genToDeg: [String: Int]) -> String? {
        guard let s1 = tex(for: relation.0, deg: deg, genToDeg),
              let s2 = tex(for: relation.1, deg: deg, genToDeg) else { return nil }
        if relation.3 == 1 { return s1 + "-" + s2 }
        if relation.3 == -1 { return s1 + "+" + s2 }
        var k = relation.2.replacingOccurrences(of: "n", with: "n_")
        k = k.replacingOccurrences(of: "*", with: "")
        return s1 + "-" + k + s2
    }

    private static func tex(for relation: ([String], Int, [String], Int, [String]), deg: Int, _ genToDeg: [String: Int]) -> String? {
        guard let s1 = tex(for: relation.0, deg: deg, genToDeg),
              let s2 = tex(for: relation.2, deg: deg, genToDeg),
              let s3 = tex(for: relation.4, deg: deg, genToDeg) else { return nil }
        if relation.1 != 1 && relation.1 != -1 { return nil }
        if relation.3 != 1 && relation.3 != -1 { return nil }
        return s1 + (relation.1 == 1 ? "-" : "+") + s2 + (relation.3 == 1 ? "-" : "+") + s3
    }

    private static var sections: [RelationsSection]? {
        var sections: [RelationsSection] = []
        let zeroRelations = RelationsTex.zeroRelations
        var currentSection: RelationsSection?

        let add: (RelationsSection) -> Void = { s in
            sections.append(s)
            if s.label == "N>3" {
                sections.append(RelationsSection(deg: s.deg, label: "N=3"))
            }
        }
        for r in zeroRelations {
            if r.count == 0 { return nil }
            if r[0] != "" {
                currentSection!.zeroRelations.append(r)
                continue
            }
            if conditions.contains(where: { $0.1 == r[1] }) {
                add(currentSection!)
                currentSection = RelationsSection(deg: currentSection!.deg, label: r[1])
            } else {
                currentSection.flatMap { add($0) }
                guard let deg = Int(r[1]) else {
                    OutputFile.writeLog(.error, "Bad deg item \(r)")
                    return nil
                }
                currentSection = RelationsSection(deg: deg, label: "")
            }
        }
        sections.append(currentSection!)
        if !fillRelations(for: sections) { return nil }
        if !fillSumRelations(for: sections) { return nil }
        return sections
    }

    private static func fillRelations(for sections: [RelationsSection]) -> Bool {
        let relations = RelationsTex.relations
        var currentSection: RelationsSection?
        for r in relations {
            if r.0.count == 0 { return false }
            if r.0[0] != "" {
                currentSection!.relations.append(r)
                continue
            }
            if conditions.contains(where: { $0.1 == r.0[1] }) {
                guard let s = sections.first(where: { $0.deg == currentSection!.deg && $0.label == r.0[1] }) else {
                    OutputFile.writeLog(.error, "No section for deg \(currentSection!.deg), label \(r.0[1])")
                    return false
                }
                currentSection = s
            } else {
                guard let deg = Int(r.0[1]) else {
                    OutputFile.writeLog(.error, "Bad deg item \(r)")
                    return false
                }
                currentSection = sections.first { $0.deg == deg && $0.label == "" }!
            }
        }
        return true
    }

    private static func fillSumRelations(for sections: [RelationsSection]) -> Bool {
        guard let s = sections.first(where: { $0.deg == 2 && $0.label == "n3" }) else {
            OutputFile.writeLog(.error, "No section for sum relations")
            return false
        }
        s.sumRelations = RelationsTex.sumRelations
        return true
    }

    private static var genToTex: [String: String] = [
        "c12": "c_1", "c23": "c_2", "c31": "c_3",
        "z1": "z", "w": "w", "x1": "x_1", "x3": "x_3", "w23": "w_2", "w31": "w_3", "w12": "w_1",
        "x12": "d_1", "x23": "d_2", "x31": "d_3", "u1": "u_1", "u2": "u_2",
        "x1_h": "y_1", "x3_h": "y_3",
        "w23_h": "s_2", "w31_h": "s_3", "w12_h": "s_1",
        "e": "e", "e1_h": "h_1", "e2_h": "h_2",
        "u1_h": "v_1", "u2_h": "v_2", "q": "q"
    ]

    private static var conditions: [(String, String, String)] = [
        ("if NumInt.isZero(n: n1) {", "n1", ", если выполнены (у2), (y3) или (у4)"),
        ("if NumInt.isZero(n: n2) {", "n2", ", если выполнены (y3) или (у4)"),
        ("if NumInt.isZero(n: n3) {", "n3", ", если выполнено (у4)"),
        ("if NumInt.isZero(n: n1) && !NumInt.isZero(n: n2) {", "n1N2", ", если выполнено (у2)"),
        ("if NumInt.isZero(n: n1) && !NumInt.isZero(n: n3) {", "n1N3", ", если выполнены (у2) или (y3)"),
        ("if NumInt.isZero(n: n2) && !NumInt.isZero(n: n3) {", "n2N3", ", если выполнено (у3)"),
        ("if !NumInt.isZero(n: n1) {", "N1", ", если выполнено (у1)"),
        ("if !NumInt.isZero(n: n2) {", "N2", ", если выполнены (у1) или (y2)"),
        ("if !NumInt.isZero(n: n3) {", "N3", ", если выполнены (у1), (y2) или (у3)"),
        ("if PathAlg.N == 3 {", "N=3", ", если $N=3$"),
        ("if PathAlg.N > 3 {", "N>3", ", если $N>3$"),
    ]

    private static func genRelationsSwift() -> Bool {
        let path = "/Users/m/test/D3/Source/Utils/Relations.swift"
        guard let s0 = try? String(contentsOf: URL(fileURLWithPath: path)) else { return true }
        let s1 = "private static var zeroRelations: [[String]]"
        let s2 = "private static var relations: [([String], [String], String, Int)]"
        let parts = s0.components(separatedBy: s1)
        if parts.count != 2 { return true }
        let parts2 = (s1 + parts[1]).components(separatedBy: s2)
        if parts2.count != 2 { return true }

        var result = ""
        for i in 0 ..< parts2.count {
            let ss: (String) -> String = {
                return "relations += [ " + (i == 0 ? "[\"\", \"" : "([\"\", \"") + $0 + (i == 0 ? "\"] ]" : "\"], [], \"\", 0)]")
            }
            let ss2: (String) -> String = {
                return ss($0) + "; if true {"
            }
            var s = parts2[i]
            for d in 0 ... 20 {
                s = s.replacingOccurrences(of: "// \(d)\n", with: ss("\(d)") + " // \(d)\n")
            }
            for (c1, c2, _) in conditions {
                s = s.replacingOccurrences(of: c1, with: ss2(c2))
            }
            result += s
            if i == 0 { result += s2 }
        }
        result = result.replacingOccurrences(of: "private static var", with: "static var")
        OutputFile.writeLog(.simple, "<pre>//\n// RelationsTex.swift\n// Generated by Step_8_tex\n//\n\nimport Foundation\n\nstruct RelationsTex {\n    " + result + "</pre>")
        return false
    }
}

final class RelationsSection {
    let deg: Int
    let label: String
    var zeroRelations: [[String]] = []
    var relations: [([String], [String], String, Int)] = []
    var sumRelations: [([String], Int, [String], Int, [String])] = []

    init(deg: Int, label: String) {
        self.deg = deg
        self.label = label
    }
}
