//
//  Created by M on 30.09.2018.
//

import Foundation

struct RunCase {
    static let skipTypes = [5, 10, 11, 15, 18]

    static func run(pathFrom: String, pathTo: String) -> String? {
        if FileManager.default.fileExists(atPath: (pathFrom as NSString).appendingPathComponent("Diff+Create.swift")) {
            return runDiff(pathFrom: pathFrom, pathTo: pathTo)
        } else {
            return runShifts(pathFrom: pathFrom, pathTo: pathTo)
        }
    }

    private static func runDiff(pathFrom: String, pathTo: String) -> String? {
        var str = header
        let path = (pathFrom as NSString).appendingPathComponent("Diff+Create.swift")
        guard FileManager.default.fileExists(atPath: path) else {
            return "no file Diff+Create.swift"
        }
        guard var source = try? String(contentsOfFile: path, encoding: .utf8) else {
            return "Fail to read \(path)"
        }
        source = source.replacingOccurrences(of: "*", with: "")
        do {
            str += try TexDiffConveter.convert(source: source)
        } catch {
            return "TexDiffConveter error=\(error)"
        }
        str += "\\end{document}"
        do {
            try str.write(toFile: pathTo, atomically: true, encoding: .utf8)
        } catch {
            return "Fail to write at \(pathTo), error=\(error)"
        }
        return nil
    }

    private static func runShifts(pathFrom: String, pathTo: String) -> String? {
        var str = header
        for type in 1 ... 36 {
            if skipTypes.contains(type) { continue }
            
            let typeStr = type < 10 ? "0\(type)" : "\(type)"
            var path = (pathFrom as NSString).appendingPathComponent("ShiftHHElem\(typeStr).swift")
            if !FileManager.default.fileExists(atPath: path) {
                path = (pathFrom as NSString).appendingPathComponent("ShiftHHElem\(typeStr)c.swift")
            }
            guard FileManager.default.fileExists(atPath: path) else {
                return "no swift file for type \(type)"
            }
            guard let source = try? String(contentsOfFile: path, encoding: .utf8) else {
                return "Fail to read \(path)"
            }
            var sType = ""
            do {
                sType = try TexConverter(type: type).convert(source: source)
            } catch {
                return "TexConverter failed with \(error)"
            }
            str += sType
            let typePath = (pathTo as NSString).deletingPathExtension + "-\(typeStr).tex"
            do {
                try (header + sType + "\\end{document}").write(toFile: typePath, atomically: true, encoding: .utf8)
            } catch {
                return "Fail to write at \(typePath), error=\(error)"
            }
        }
        str += "\\end{document}"
        do {
            try str.write(toFile: pathTo, atomically: true, encoding: .utf8)
        } catch {
            return "Fail to write at \(pathTo), error=\(error)"
        }
        return nil
    }
}

let header = """
\\documentclass[12pt]{amsart}
\\usepackage{amsmath,amsthm,amssymb,amscd,cite,array}
\\usepackage[dvips]{graphicx}

\\oddsidemargin=-0.2in \\evensidemargin=-0.2in \\textwidth=6.8in
\\topmargin=0.0in \\textheight=9in

\\newtheorem{pr}{Proposition}
\\newtheorem{lem}[pr]{Lemma}
\\newtheorem{thm}[pr]{Theorem}
\\newtheorem{s}[pr]{Corollary}
\\theoremstyle{remark}
\\newtheorem{zam}{Remark}
\\newtheorem*{obozn}{{\\rm\\bf Denotation}}
\\newtheorem*{obozns}{{\\rm\\bf Denotations}}

\\renewcommand\\div{\\text{ }\\vdots\\text{ }}
\\newcommand\\ndiv{\\not\\vdots\\text{ }}
\\newcommand{\\myChar}{\\mathrm{char\\,}K}
\\newcommand{\\myNod}{\\text{{\\rm gcd}}}
\\newcommand{\\Hom}{\\mathrm{Hom}}
\\renewcommand{\\Im}{\\mathrm{Im}}
\\newcommand{\\Ker}{\\mathrm{Ker}}
\\newcommand{\\HH}{\\mathrm{HH}}
\\newcommand{\\N}{\\mathbb{N}}
\\newcommand{\\Z}{\\mathbb{Z}}
\\newcommand{\\cl}{\\mathrm{cl}}

\\def\\sm{\\scriptstyle}
\\def\\a{\\alpha}
\\def\\b{\\beta}
\\def\\g{\\gamma}
\\def\\le{\\leqslant}
\\def\\ge{\\geqslant}
\\def\\ra{\\rightarrow}

\\begin{document}

"""
