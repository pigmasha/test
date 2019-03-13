//
//  Created by M on 26/10/2018.
//

struct Step_1_calc_s {
    static func runCase() -> Bool {
        OutputFile.writeLog(.simple, header)
        OutputFile.writeLog(.simple, "N=\(PathAlg.n), S=\(PathAlg.s)\n\n")
        var res = false
        for i in 0 ... 3 {
            if processS(i) { res = true; break }
        }
        OutputFile.writeLog(.simple, "\\end{document}\n")
        return res
    }

    private static func processS(_ i: Int) -> Bool {
        OutputFile.writeLog(.simple, "\\begin{center}{\\large $\\mathbf{S_{\(kStr(i))}}$}\\end{center}\n\n")
        let w = maxLenWay(end: i)
        var homos: [PHomo] = []
        var lastHomo = PHomo(from: [w.endsWith.number], to: [w.startsWith.number], matrix: [[WayKoef(koef: 1, way: w)]])
        for d in 0 ... 20 {
            homos.append(lastHomo)
            let myKer = PKer.ker(lastHomo, onlyGen: true, logRemoves: false)
            //printKer(myKer)
            if myKer.count != 1 && myKer.count != 2 {
                print("bad ker count \(myKer.count)")
                return true
            }
            var matrix: [[WayKoef]] = []
            for i in 0 ..< myKer[0].count { matrix += [myKer.map { $0[i] }] }

            let homo = PHomo(from: myKer.map { ($0[0].isZero ? $0[1] : $0[0]).way.endsWith.number },
                             to: lastHomo.from,
                             matrix: matrix)
            if checkLast(homo, deg: d, i: i) { break }
            printHomo(homo, deg: d)
            lastHomo = homo
        }
        for i in 1 ..< homos.count {
            if checkExact(homos[i-1], homos[i]) { return true }
        }
        return false
    }

    //     h_2      h_1
    // Q_3 ---→ Q_2 ---→ Q_1
    private static func checkExact(_ homo1: PHomo, _ homo2: PHomo) -> Bool {
        let ker = PKer.ker(homo1, onlyGen: false, logRemoves: false)
        let im = PKer.im(homo2)
        for k in ker {
            if !im.contains(where: { $0.isEq(k)}) {
                print("No \(k.map { $0.str }.joined(separator: " ")) in im")
                printIm(im)
                return true
            }
        }
        for k in im {
            if !ker.contains(where: { $0.isEq(k)}) {
                print("No \(k.map { $0.str }.joined(separator: " ")) in ker")
                printKer(ker)
                return true
            }
        }
        //printKer(ker)
        //printIm(im)
        return false
    }

    private static func checkLast(_ homo: PHomo, deg: Int, i: Int) -> Bool {
        guard homo.from.count == 1 && homo.to.count == 1 else { return false }
        let w = maxLenWay(end: homo.from[0])
        guard w.isEq(homo.matrix[0][0].way) else { return false }
        OutputFile.writeLog(.simple, "$$\\Omega^{\(deg+1)}(S_{\(kStr(i))})\\simeq S_{\(kStr(homo.from[0]))}$$\n")
        return true
    }

    private static func printHomo(_ homo: PHomo, deg: Int) {
        let matrixStr: String
        if homo.from.count == 1 && homo.to.count == 1 {
            matrixStr = homo.matrix[0][0].str
        } else if homo.from.count == 2 && homo.to.count == 1 {
            matrixStr = "(\(homo.matrix[0][0].str)\\text{ }\(homo.matrix[0][1].str))"
        } else if homo.from.count == 1 && homo.to.count == 2 {
            matrixStr = "\\binom{\(homo.matrix[0][0].str)}{\(homo.matrix[1][0].str)}"
        } else {
            matrixStr = "\\binom{\\phantom{-}\(homo.matrix[0][0].str)\\phantom{-}"
                + "\(homo.matrix[0][1].str)}{\(homo.matrix[1][0].str)\\phantom{-}\(homo.matrix[1][1].str)}"
        }
        let sStr = deg == 0 ? "\\longrightarrow S_{\(kStr(homo.to[0]))}" : ""
        OutputFile.writeLog(.simple, "$$d_{\(deg)}: Q_{\(deg+1)}=\(pStr(homo.from))"
            + "\\stackrel{\(matrixStr)}\\longrightarrow \(pStr(homo.to))\(sStr)$$\n")
    }

    private static func maxLenWay(end: Int) -> Way {
        var way = Way(from: end, to: end, noZeroLen: true)
        if way.isZero { way = Way(from: end, to: end) }
        var cnt = 1
        for i in 0 ... PathAlg.vertexMod {
            let w = Way(from: i, to: end)
            if !w.isZero && w.len > way.len { way = w; cnt = 1 }
            if !w.isZero && w.len == way.len && !w.isEq(way) { cnt += 1 }
        }
        if cnt != 1 || way.len == 0 { fatalError("Search way error: \(cnt) different ways \(way.htmlStr)") }
        return way
    }

    private static func pStr(_ p: [Int]) -> String {
        return p.map { "P_{\(kStr($0))}" }.joined(separator: "\\oplus ")
    }

    private static func kStr(_ k: Int) -> String {
        guard k != 0 else {
            return "4r"
        }
        guard k > 3 else {
            return "4r+\(k)"
        }
        let s = PathAlg.s
        let sfx = k % 4 == 0 ? "" : "+\(k%4)"
        guard k / 4 >= PathAlg.s else {
            return "4(r+\(k/4))" + sfx
        }
        let k2 = k / 4 - s
        return "4(r+s\(k2 == 0 ? "" : "+\(k2)"))" + sfx
    }

    private static func printKer(_ ker: [[WayKoef]]) {
        OutputFile.writeLog(.simple, "$$\\text{Ker: }" + ker.map { item in
            return item.count == 1 ? "\(item[0].str)" : "(\(item[0].str)\\text{ }\(item[1].str))"
        }.joined(separator: ", ") + "$$\n")
    }

    private static func printIm(_ im: [[WayKoef]]) {
        OutputFile.writeLog(.simple, "$$\\text{Im: }" + im.map { item in
            return item.count == 1 ? "\(item[0].str)" : "(\(item[0].str)\\text{ }\(item[1].str))"
        }.joined(separator: ", ") + "$$\n")
    }
}

struct PHomo {
    let from: [Int]
    let to: [Int]
    let matrix: [[WayKoef]]
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
