//
//  Step_9_tex.swift
//  Created by M on 08.12.2021.
//

import Foundation

struct Step_9_tex {
    static func runCase() -> Bool {
        //return genRelationsSwift()
        var genToDeg: [String: Int] = [:]
        for i in 0 ... 1 {
            PathAlg.kk = i + 100
            let gens = GenCreate.allElements
            for g in gens {
                genToDeg[g.label] = g.deg
            }
        }
        guard let sections = self.sections else { return true }
        OutputFile.writeLog(.simple, "<pre>\n")
        for s in sections {
            if s.label == "" && s.zeroRelations.isEmpty && s.relations.isEmpty { continue }
            if s.zeroRelations.isEmpty && s.relations.isEmpty && s.sumRelations.isEmpty { return true }
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
        case PathAlg.kk: degStr = "k"
        case PathAlg.kk-1: degStr = "k-1"
        case PathAlg.kk-2: degStr = "k-2"
        default: degStr = "\(c)"
        }
        var str = s0
        if degStr != "" {
            if str.contains("prime") { str = "(" + str + ")" }
            if degStr.lengthOfBytes(using: .utf8) == 1 {
                str += "^" + degStr
            } else {
                str += "^{" + degStr + "}"
            }
        }
        if c == items.count { return str }
        for j in c ..< items.count {
            guard let s1 = genToTex[items[j]] else { OutputFile.writeLog(.error, "Unknown gen " + items[j]); return nil }
            if j == items.count - 2 && genToTex[items[j + 1]] == s1 {
                str += (s1.contains("prime") ? "(" + s1 + ")" : s1) + "^2"
                break
            }
            str += s1
        }
        return str
    }

    private static func koefStr(for n: Int) -> String? {
        let k = PathAlg.kk
        switch n {
        case 1, -1: return "+"
        case k: return "+k"
        case k + 1: return "+(k+1)"
        case k / 2: return "+\\tfrac{k}{2}"
        case k / 2 + 1: return "+(\\tfrac{k}{2}+1)"
        default:
            OutputFile.writeLog(.error, "Unknown koef \(n)")
            return nil
        }
    }

    private static func tex(for relation: ([String], [String], String, Int), deg: Int, _ genToDeg: [String: Int]) -> String? {
        guard let s1 = tex(for: relation.0, deg: deg, genToDeg),
              let s2 = tex(for: relation.1, deg: deg, genToDeg),
              let kk = koefStr(for: relation.3) else { return nil }
        return s1 + kk + s2
    }

    private static func tex(for relation: ([String], Int, [String], Int, [String]), deg: Int, _ genToDeg: [String: Int]) -> String? {
        guard let s1 = tex(for: relation.0, deg: deg, genToDeg),
              let s2 = tex(for: relation.2, deg: deg, genToDeg),
              let s3 = tex(for: relation.4, deg: deg, genToDeg),
              let k1 = koefStr(for: relation.1),
              let k2 = koefStr(for: relation.3) else { return nil }
        return s1 + k1 + s2 + k2 + s3
    }

    private static var sections: [RelationsSection]? {
        let zeroRelations = RelationsTex.zeroRelations
        var maxDeg = 0
        for r in zeroRelations {
            if r.count == 0 { return nil }
            if r[0] != "" { continue }
            if conditions.contains(where: { $0.1 == r[1] }) { continue }
            guard let deg = Int(r[1]) else { OutputFile.writeLog(.error, "Bad deg item-1 \(r)"); return nil }
            maxDeg = deg
        }

        var sections: [RelationsSection] = []
        for deg in 0 ... maxDeg {
            sections.append(RelationsSection(deg: deg, label: ""))
            conditions.forEach { sections.append(RelationsSection(deg: deg, label: $0.1)) }
        }

        var currentSection: RelationsSection?
        for r in zeroRelations {
            if r[0] != "" {
                currentSection!.zeroRelations.append(r)
                continue
            }
            if conditions.contains(where: { $0.1 == r[1] }) {
                currentSection = sections.first{ $0.deg == currentSection!.deg && $0.label == r[1] }
            } else {
                guard let deg = Int(r[1]) else {
                    OutputFile.writeLog(.error, "Bad deg item-2 \(r)")
                    return nil
                }
                currentSection = sections.first{ $0.deg == deg && $0.label == "" }
            }
        }
        if !fillRelations(for: sections) { return nil }
        if !fillSumRelations(for: sections) { return nil }
        return sections.filter { !$0.zeroRelations.isEmpty || !$0.relations.isEmpty || !$0.sumRelations.isEmpty }
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
        let relations = RelationsTex.sumRelations
        var currentSection: RelationsSection?
        for r in relations {
            if r.0.count == 0 { return false }
            if r.0[0] != "" {
                currentSection!.sumRelations.append(r)
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
                    OutputFile.writeLog(.error, "Bad deg item-3 \(r)")
                    return false
                }
                currentSection = sections.first { $0.deg == deg && $0.label == "" }!
            }
        }
        return true
    }

    static var genToTex: [String: String] = [
        "p1": "p_1", "p2": "p_2", "p3": "p_3", "p4": "p_4",
        "u1": "u_1", "u2": "u_2", "u3": "u_3", "u4": "u_4", "u1'": "u_1^\\prime ",
        "v1": "v_1", "v2": "v_2", "v3": "v_3", "v4": "v_4", "v5": "v_5", "v6": "v_6",
        "w1": "w_1", "w1'": "w_1^\\prime ", "w2": "w_2", "w2'": "w_2^\\prime ",
        "t": "t"
    ]

    private static var conditions: [(String, String, String)] = [
        ("if k % 2 == 0 {", "k%2=0", ", если $k$ ч\\\"етно"),
        ("if k % 2 == 1 {", "k%2=1", ", если $k$ неч\\\"етно"),
        ("if k % 4 == 0 {", "k%4=0", ", если $k$ делится на $4$"),
        ("if k % 4 == 2 {", "k%4=2", ", если $k$ ч\\\"етно и не делится на $4$"),
    ]

    private static func genRelationsSwift() -> Bool {
        let path = "/Users/m/test/loc11/Source/Utils/Relations.swift"
        guard let s0 = try? String(contentsOf: URL(fileURLWithPath: path)) else { return true }
        let s1 = "private static var zeroRelations: [[String]]"
        let s2 = "private static var relations: [([String], [String], String, Int)]"
        let s3 = "private static var sumRelations: [([String], Int, [String], Int, [String])]"
        let parts1 = s0.components(separatedBy: s1)
        if parts1.count != 2 { return true }
        let parts2 = parts1[1].components(separatedBy: s2)
        if parts2.count != 2 { return true }
        let parts3 = parts2[1].components(separatedBy: s3)
        if parts3.count != 2 { return true }
        let parts = [s1 + parts2[0], s2 + parts3[0], s3 + parts3[1]]
        var result = ""
        for i in 0 ..< parts.count {
            let ss: (String) -> String = {
                let sfx: String
                switch i {
                case 0: sfx = "\"] ]"
                case 1: sfx = "\"], [], \"\", 0)]"
                default: sfx = "\"], 0, [], 0, [])]"
                }
                return "relations += [ " + (i == 0 ? "[\"\", \"" : "([\"\", \"") + $0 + sfx
            }
            let ss2: (String) -> String = {
                return ss($0) + "; if true {"
            }
            var s = parts[i]
            for d in 0 ... 20 {
                s = s.replacingOccurrences(of: "// \(d)\n", with: ss("\(d)") + " // \(d)\n")
            }
            for (c1, c2, _) in conditions {
                s = s.replacingOccurrences(of: c1, with: ss2(c2))
            }
            result += s
        }
        result = result.replacingOccurrences(of: "private static var", with: "static var")
        OutputFile.writeLog(.simple, "<pre>//\n// RelationsTex.swift\n// Generated by Step_9_tex\n//\n\nimport Foundation\n\nstruct RelationsTex {\n    " + result + "</pre>")
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
