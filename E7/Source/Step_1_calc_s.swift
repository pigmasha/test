//
//  Created by M on 26/10/2018.
//

struct Step_1_calc_s {
    static func runCase() -> Bool {
        OutputFile.writeLog(.simple, header)
        OutputFile.writeLog(.simple, "N=\(PathAlg.n), S=\(PathAlg.s)\n\n")
        var res = false
        for i in 0 ... 6 {
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
        for d in 0 ... 15 {
            homos.append(lastHomo)
            let myKer = PKer.ker(lastHomo, onlyGen: true, logRemoves: false)
            //myKer.printTex()
            if myKer.items.count != 1 && myKer.items.count != 2 && myKer.items.count != 3 {
                OutputFile.writeLog(.simple, "bad ker count \(myKer.items.count)")
                myKer.printTex()
                return true
            }
            var matrix: [[WayKoef]] = []
            for i in 0 ..< myKer.items[0].count { matrix += [myKer.items.map { $0[i] }] }

            let homo = PHomo(from: myKer.items.map { ($0[0].isZero ? $0[1] : $0[0]).way.endsWith.number },
                             to: lastHomo.from,
                             matrix: matrix)
            //if checkLast(homo, deg: d, i: i) { break }
            printHomo(homo, deg: d)
            if checkExact(lastHomo, homo) { return true }
            lastHomo = homo
        }
        /*for i in 1 ..< homos.count {
            if checkExact(homos[i-1], homos[i]) { return true }
        }*/
        return false
    }

    //     h_2      h_1
    // Q_3 ---→ Q_2 ---→ Q_1
    private static func checkExact(_ homo1: PHomo, _ homo2: PHomo) -> Bool {
        let ker = PKer.ker(homo1, onlyGen: false, logRemoves: false)
        let im = PKer.im(homo2)
        var imErr = false
        for k in ker.items {
            if !im.contains(k) {
                OutputFile.writeLog(.simple, "$$\\text{No: }" +  k.str + "\\text{ in im}$$\n")
                imErr = true
            }
        }
        if imErr {
            im.printTex()
        }
        var kerErr = false
        for k in im.items {
            if !ker.contains(k) {
                OutputFile.writeLog(.simple, "$$\\text{No: }" +  k.str + "\\text{ in ker}$$\n")
                kerErr = true
            }
        }
        if kerErr {
            ker.printTex()
        }
        return imErr || kerErr
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
        } else if homo.from.count == 1 && homo.to.count == 3 {
            matrixStr = "\\triplet{\(homo.matrix[0][0].str)}{\(homo.matrix[1][0].str)}{\(homo.matrix[2][0].str)}"
        } else if homo.from.count == 2 && homo.to.count == 2 {
            matrixStr = "\\binom{\\phantom{-}\(homo.matrix[0][0].str)\\phantom{-}"
                + "\(homo.matrix[0][1].str)}{\(homo.matrix[1][0].str)\\phantom{-}\(homo.matrix[1][1].str)}"
        } else if homo.from.count == 2 && homo.to.count == 3 {
            matrixStr = "\\triplet{\\phantom{-}\(homo.matrix[0][0].str)\\phantom{-}"
                + "\(homo.matrix[0][1].str)}{\(homo.matrix[1][0].str)\\phantom{-}\(homo.matrix[1][1].str)}"
                + "{\(homo.matrix[2][0].str)\\phantom{-}\(homo.matrix[2][1].str)}"
        } else if homo.from.count == 3 && homo.to.count == 2 {
            matrixStr = "\\binom{\(homo.matrix[0][0].str)\\phantom{-}"
                + "\(homo.matrix[0][1].str)\\phantom{-}\(homo.matrix[0][2].str)}"
                + "{\(homo.matrix[1][0].str)\\phantom{-}\\phantom{-}\(homo.matrix[1][1].str)"
                + "\\phantom{-}\\phantom{-}\(homo.matrix[1][2].str)}"
        } else if homo.from.count == 3 && homo.to.count == 3 {
            matrixStr = "\\triplet{\(homo.matrix[0][0].str)\\phantom{-}"
                + "\(homo.matrix[0][1].str)\\phantom{-}\(homo.matrix[0][2].str)}"
                + "{\(homo.matrix[1][0].str)\\phantom{-}\\phantom{-}\(homo.matrix[1][1].str)"
                + "\\phantom{-}\\phantom{-}\(homo.matrix[1][2].str)}"
                + "{\(homo.matrix[2][0].str)\\phantom{-}\\phantom{-}\(homo.matrix[2][1].str)"
                + "\\phantom{-}\\phantom{-}\(homo.matrix[2][2].str)}"
        } else {
            fatalError("Bad counts \(homo.from.count) and \(homo.to.count)")
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
        guard k != 0 else { return "7r" }
        guard k > 7 else { return "7r+\(k)" }
        return "7(r+\(k/7))" + (k % 7 == 0 ? "" : "+\(k%7)")
    }
}

struct PHomo {
    let from: [Int]
    let to: [Int]
    let matrix: [[WayKoef]]
}

enum PElementsType {
    case ker, im
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
\\newcommand\\triplet[3]{\\left(\\genfrac{}{}{0pt}{}{#1}{\\genfrac{}{}{0pt}{}{#2}{#3}}\\right)}

\\def\\sm{\\scriptstyle}
\\def\\a{\\alpha}
\\def\\b{\\beta}
\\def\\g{\\gamma}
\\def\\le{\\leqslant}
\\def\\ge{\\geqslant}
\\def\\ra{\\rightarrow}

\\begin{document}

"""
