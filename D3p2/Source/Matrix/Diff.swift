//
//  Created by M on 13.10.2021.
//

import Foundation

final class Diff: Matrix {
    let deg: Int

    init(deg: Int) {
        self.deg = deg
        super.init()
        let qFrom = BimodQ(deg: deg + 1)
        let qTo = BimodQ(deg: deg)
        makeZeroMatrix(qFrom.pij.count, h: qTo.pij.count)
        fillDiff(deg: deg)
    }

    private func fillDiff(deg d: Int) {
        switch deg % 4 {
        case 0: putRho1(wave: false)
        case 1: putRho2(wave: false, koef: -1)
        case 2: putRho1(wave: true)
        case 3: putRho2(wave: true, koef: 1)
        default: fatalError()
        }
        if deg == 0 { return }
        var pos: (x: Int, y: Int) = (width - 6, height - 6)
        var t = (deg - 1) % 3 + 1
        var sigmaWave = ((deg - 1) / 3) % 2 == 1
        var tauWave = false
        var tauKoef = deg % 2 == 0 ? 1 : -1
        while true {
            putSigma(n: t, at: pos, wave: sigmaWave)
            if deg % 2 == 1 && pos.y == 0 { break }
            pos.x -= 6
            putTau(n: t == 1 ? 3 : t - 1, at: pos, wave: tauWave, koef: tauKoef)
            if deg % 2 == 0 && pos.x == 0 { break }
            tauWave = !tauWave
            tauKoef = -tauKoef
            if t == 3 { sigmaWave = !sigmaWave }
            t = t == 3 ? 1 : t + 1
            pos.y -= 6
        }
    }

    private func putRho1(wave: Bool) {
        putS(at: (0, 0), value: [Comb(left: Way.e1, right: Way(type: .a12, len: 1), koef: wave ? 1 : -1),
                                 Comb(),
                                 Comb(left: Way(type: .a31, len: 1), right: Way.e1, koef: 1)])
        putFi(from: (0, 0), to: (3, 0), koef: -1)
    }

    private func putRho2(wave: Bool, koef: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        for i in 0 ... n3 - 1 {
            rows[0][0].add(left: Way.alpha1(deg: i), right: Way(type: .a21, len: 2 * (n3 - 1 - i) + 1), koef: wave ? koef : -koef)
        }
        for i in 0 ... n3 - 1 {
            rows[0][1].add(left: Way(type: .a21, len: 2 * (n3 - 1 - i) + 1), right: Way.beta2(deg: i), koef: koef)
        }
        for i in 0 ... n1 - 1 {
            rows[1][1].add(left: Way.alpha2(deg: i), right: Way(type: .a32, len: 2 * (n1 - 1 - i) + 1), koef: wave ? koef : -koef)
        }
        for i in 0 ... n1 - 1 {
            rows[1][2].add(left: Way(type: .a32, len: 2 * (n1 - 1 - i) + 1), right: Way.beta3(deg: i), koef: koef)
        }
        for i in 0 ... n2 - 1 {
            rows[2][0].add(left: Way(type: .a13, len: 2 * (n2 - 1 - i) + 1), right: Way.beta1(deg: i), koef: koef)
        }
        for i in 0 ... n2 - 1 {
            rows[2][2].add(left: Way.alpha3(deg: i), right: Way(type: .a13, len: 2 * (n2 - 1 - i) + 1), koef: wave ? koef : -koef)
        }
        putFi(from: (0, 0), to: (0, 3), koef: 1)
    }

    private func isZero(at pos: (x: Int, y: Int), size: Int) -> Bool {
        for i in 0 ..< size {
            for j in 0 ..< size {
                if !rows[pos.y + i][pos.x + j].isZero { return false }
            }
        }
        return true
    }

    private func putSigma(n: Int, at pos: (x: Int, y: Int), wave: Bool) {
        if !isZero(at: pos, size: 6) { fatalError("putSigma not zero at (\(pos.x), \(pos.y))") }
        switch n {
        case 1: putSigma1(at: pos, wave: wave)
        case 2: putSigma2(at: pos, wave: wave)
        case 3: putSigma3(at: pos, wave: wave)
        default: fatalError("putSigma: bad n=\(n)")
        }
    }

    private func putSigma1(at pos: (x: Int, y: Int), wave: Bool) {
        putS(at: (pos.x + 3, pos.y), value: [Comb(),
                                             Comb(left: Way(type: .a31, len: 1), right: Way.e2, koef: 1),
                                             Comb(left: Way.e1, right: Way(type: .a23, len: 1), koef: wave ? -1 : 1)])
        putFi(from: (pos.x + 3, pos.y), to: (pos.x, pos.y + 3), koef: 1)
    }

    private func putSigma2(at pos: (x: Int, y: Int), wave: Bool) {
        putS(at: pos, value: [Comb(left: Way.e1, right: Way(type: .a21, len: 1), koef: -1),
                              Comb(left: Way(type: .a21, len: 1), right: Way.e2, koef: wave ? -1 : 1),
                              Comb()])
        putFi(from: pos, to: (pos.x + 3, pos.y + 3), koef: -1)
    }

    private func putSigma3(at pos: (x: Int, y: Int), wave: Bool) {
        putS(at: (pos.x + 3, pos.y), value: [Comb(left: Way(type: .a21, len: 1), right: Way.e1, koef: wave ? -1 : 1),
                                             Comb(),
                                             Comb(left: Way.e1, right: Way(type: .a13, len: 1), koef: 1)])
        putFi(from: (pos.x + 3, pos.y), to: (pos.x, pos.y + 3), koef: 1)
    }

    private func putTau(n: Int, at pos: (x: Int, y: Int), wave: Bool, koef: Int) {
        if !isZero(at: pos, size: 6) { fatalError("putTau not zero at (\(pos.x), \(pos.y))") }
        switch n {
        case 1: putTau1(at: pos, wave: wave, koef: koef)
        case 2: putTau2(at: pos, wave: wave, koef: koef)
        case 3: putTau3(at: pos, wave: wave, koef: koef)
        default: fatalError("putTau: bad n=\(n)")
        }
    }

    private func putTau1(at pos: (x: Int, y: Int), wave: Bool, koef: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let k = wave ? -koef : koef
        rows[pos.y][pos.x + 4].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e2, koef: k)
        rows[pos.y][pos.x + 5].add(left: Way.e1, right: Way(type: .a23, len: 2 * n1 - 1), koef: -koef)
        rows[pos.y + 1][pos.x + 3].add(left: Way.e2, right: Way(type: .a31, len: 2 * n2 - 1), koef: -koef)
        rows[pos.y + 1][pos.x + 5].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e3, koef: k)
        rows[pos.y + 2][pos.x + 3].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e1, koef: k)
        rows[pos.y + 2][pos.x + 4].add(left: Way.e3, right: Way(type: .a12, len: 2 * n3 - 1), koef: -koef)
        putFi(from: (pos.x + 3, pos.y), to: (pos.x, pos.y + 3), koef: -1)
    }

    private func putTau2(at pos: (x: Int, y: Int), wave: Bool, koef: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let k = wave ? koef : -koef
        rows[pos.y][pos.x].add(left: Way.e1, right: Way(type: .a12, len: 2 * n3 - 1), koef: koef)
        rows[pos.y][pos.x + 2].add(left: Way(type: .a31, len: 2 * n2 - 1), right: Way.e1, koef: k)
        rows[pos.y + 1][pos.x].add(left: Way(type: .a12, len: 2 * n3 - 1), right: Way.e2, koef: k)
        rows[pos.y + 1][pos.x + 1].add(left: Way.e2, right: Way(type: .a23, len: 2 * n1 - 1), koef: koef)
        rows[pos.y + 2][pos.x + 1].add(left: Way(type: .a23, len: 2 * n1 - 1), right: Way.e3, koef: k)
        rows[pos.y + 2][pos.x + 2].add(left: Way.e3, right: Way(type: .a31, len: 2 * n2 - 1), koef: koef)
        putFi(from: pos, to: (pos.x + 3, pos.y + 3), koef: 1)
    }

    private func putTau3(at pos: (x: Int, y: Int), wave: Bool, koef: Int) {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let k = wave ? koef : -koef
        rows[pos.y][pos.x + 3].add(left: Way.e1, right: Way(type: .a21, len: 2 * n3 - 1), koef: k)
        rows[pos.y][pos.x + 4].add(left: Way(type: .a21, len: 2 * n3 - 1), right: Way.e2, koef: koef)
        rows[pos.y + 1][pos.x + 4].add(left: Way.e2, right: Way(type: .a32, len: 2 * n1 - 1), koef: k)
        rows[pos.y + 1][pos.x + 5].add(left: Way(type: .a32, len: 2 * n1 - 1), right: Way.e3, koef: koef)
        rows[pos.y + 2][pos.x + 3].add(left: Way(type: .a13, len: 2 * n2 - 1), right: Way.e1, koef: koef)
        rows[pos.y + 2][pos.x + 5].add(left: Way.e3, right: Way(type: .a13, len: 2 * n2 - 1), koef: k)
        putFi(from: (pos.x + 3, pos.y), to: (pos.x, pos.y + 3), koef: -1)
    }

    private func putS(at pos: (x: Int, y: Int), value: [Comb]) {
        if value.count != 3 { fatalError() }
        rows[pos.y][pos.x].add(comb: value[0])
        rows[pos.y][pos.x+1].add(comb: value[1])
        rows[pos.y][pos.x+2].add(comb: value[2])
        rows[pos.y+1][pos.x].add(comb: s(from: value[2], deg: 1))
        rows[pos.y+1][pos.x+1].add(comb: s(from: value[0], deg: 1))
        rows[pos.y+1][pos.x+2].add(comb: s(from: value[1], deg: 1))
        rows[pos.y+2][pos.x].add(comb: s(from: value[1], deg: 2))
        rows[pos.y+2][pos.x+1].add(comb: s(from: value[2], deg: 2))
        rows[pos.y+2][pos.x+2].add(comb: s(from: value[0], deg: 2))
    }

    private func s(from c: Comb, deg: Int) -> Comb {
        if c.isZero { return Comb() }
        if c.contents.count != 1 { fatalError() }
        let t = c.contents[0].1
        return Comb(left: s(forWay: t.leftComponent, deg: deg),
                    right: s(forWay: t.rightComponent, deg: deg),
                    koef: c.contents[0].0.n)
    }

    private func s(forWay w: Way, deg: Int) -> Way {
        if w.len > 1 { fatalError("Bad way " + w.str) }
        if deg != 1 && deg != 2 { fatalError("Bad deg \(deg)") }
        if w.len == 0 {
            let v: VertexType
            switch w.startVertex {
            case .e1: v = deg == 1 ? .e2 : .e3
            case .e2: v = deg == 1 ? .e3 : .e1
            case .e3: v = deg == 1 ? .e1 : .e2
            }
            return Way(vertexType: v)
        }
        let a: ArrType
        switch w.endArr {
        case .a12: a = deg == 1 ? .a23 : .a31
        case .a21: a = deg == 1 ? .a32 : .a13
        case .a13: a = deg == 1 ? .a21 : .a32
        case .a31: a = deg == 1 ? .a12 : .a23
        case .a23: a = deg == 1 ? .a31 : .a12
        case .a32: a = deg == 1 ? .a13 : .a21
        }
        return Way(type: a, len: 1)
    }
}
