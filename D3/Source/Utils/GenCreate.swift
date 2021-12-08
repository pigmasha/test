//
//  GenCreate.swift
//  D3
//
//  Created by M on 11.11.2021.
//

import Foundation

final class GenCreate {
    static var allElements: [Gen] {
        return [
            Gen(label: "1", deg: 0, elem: [(1, Way.e1), (1, Way.e2), (1, Way.e3)]),
            Gen(label: "c12", deg: 0, elem: [(1, Way.alpha1), (1, Way.beta2), (0, Way.zero)]),
            Gen(label: "c23", deg: 0, elem: [(0, Way.zero), (1, Way.alpha2), (1, Way.beta3)]),
            Gen(label: "c31", deg: 0, elem: [(1, Way.beta1), (0, Way.zero), (1, Way.alpha3)])
        ] + deg1Gens + deg3Gens + [
            Gen(label: "e", deg: 4, elem: [(1, Way.e1), (1, Way.e2), (1, Way.e3),
                                           (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                           (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                           (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)]),
            Gen(label: "e1_h", deg: 6, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (1, Way.e1), (1, Way.e2), (1, Way.e3),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero)]),
            Gen(label: "e2_h", deg: 6, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (1, Way.e1), (1, Way.e2), (1, Way.e3)])
        ] + deg2Gens + deg7Gens
    }

    private static var deg1Gens: [Gen] {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let w = Gen(label: "w", deg: 1, elem: [(n1 * n2, Way(type: .a12, len: 1)),
                                               (n2 * n3, Way(type: .a23, len: 1)),
                                               (n3 * n1, Way(type: .a31, len: 1)),
                                               (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let w23 = Gen(label: "w23", deg: 1, elem: [(0, Way.zero), (1, Way(type: .a23, len: 1)),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let w31 = Gen(label: "w31", deg: 1, elem: [(0, Way.zero), (0, Way.zero), (1, Way(type: .a31, len: 1)),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let w12 = Gen(label: "w12", deg: 1, elem: [(1, Way(type: .a12, len: 1)), (0, Way.zero), (0, Way.zero),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x1 = Gen(label: "x1", deg: 1, elem: [(1, Way(type: .a12, len: 3)),
                                                 (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x3 = Gen(label: "x3", deg: 1, elem: [(0, Way.zero), (0, Way.zero), (1, Way(type: .a31, len: 3)),
                                                 (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let gg: [Gen]
        if NumInt.isZero(n: n1) && NumInt.isZero(n: n2) && NumInt.isZero(n: n3) {
            gg = [w23, w31, w12]
        } else if NumInt.isZero(n: n1) && NumInt.isZero(n: n2) {
            gg = [w23, w31] + (n3 == 1 ? [] : [x1])
        } else if NumInt.isZero(n: n1) {
            gg = [w23] + (n3 == 1 ? [] : [x1]) + (n2 == 1 ? [] : [x3])
        } else {
            gg = [w]
        }
        return [Gen(label: "z1", deg: 1, elem: [(1, Way(type: .a12, len: 1)), (0, Way.zero), (0, Way.zero),
                                                (-1, Way(type: .a21, len: 1)), (0, Way.zero), (0, Way.zero)])] + gg
    }

    private static var deg2Gens: [Gen] {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        let x12 = Gen(label: "x12", deg: 2, elem: [(1, Way.alpha1), (-1, Way.beta2),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x23 = Gen(label: "x23", deg: 2, elem: [(0, Way.zero), (1, Way.alpha2), (-1, Way.beta3),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                   (0, Way.zero), (0, Way.zero)])
        let x31 = Gen(label: "x31", deg: 2, elem: [(-1, Way.beta1), (0, Way.zero), (1, Way.alpha3),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                   (0, Way.zero), (0, Way.zero)])
        let q = Gen(label: "q", deg: 2, elem: [(1, Way.alpha1(deg: n3)), (0, Way.zero), (0, Way.zero),
                                               (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                               (0, Way.zero), (0, Way.zero)])
        return (n3 == 1 ? [] : [x12]) + (n1 == 1 ? [] : [x23]) + (n2 == 1 ? [] : [x31]) + [
            Gen(label: "u1", deg: 2, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero),
                                            (1, Way(type: .a12, len: 2 * n3 - 1)),
                                            (1, Way(type: .a23, len: 2 * n1 - 1)),
                                            (1, Way(type: .a31, len: 2 * n2 - 1)),
                                            (0, Way.zero), (0, Way.zero), (0, Way.zero)]),
            Gen(label: "u2", deg: 2, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero),
                                            (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                            (1, Way(type: .a21, len: 2 * n3 - 1)),
                                            (1, Way(type: .a32, len: 2 * n1 - 1)),
                                            (1, Way(type: .a13, len: 2 * n2 - 1))])
        ] + (NumInt.isZero(n: n1) ? [q] : [])
    }

    private static var deg3Gens: [Gen] {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if !NumInt.isZero(n: n1) { return [] }
        let w23 = Gen(label: "w23_h", deg: 3, elem: [(0, Way.zero), (1, Way(type: .a23, len: 1)),
                                                     (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                     (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let w31 = Gen(label: "w31_h", deg: 3, elem: [(0, Way.zero), (0, Way.zero), (1, Way(type: .a31, len: 1)),
                                                     (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                     (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let w12 = Gen(label: "w12_h", deg: 3, elem: [(1, Way(type: .a12, len: 1)), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                     (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                     (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x1 = Gen(label: "x1_h", deg: 3, elem: [(1, Way(type: .a12, len: 3)), (0, Way.zero),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        let x3 = Gen(label: "x3_h", deg: 3, elem: [(0, Way.zero), (0, Way.zero), (1, Way(type: .a31, len: 3)),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                                   (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        if NumInt.isZero(n: n3) {
            return [w23, w31, w12]
        }
        if NumInt.isZero(n: n2) {
            return [w23, w31] + (n3 == 1 ? [] : [x1])
        }
        return [w23] + (n3 == 1 ? [] : [x1]) + (n2 == 1 ? [] : [x3])
    }

    private static var deg7Gens: [Gen] {
        let (n1, n2, n3) = (PathAlg.n1, PathAlg.n2, PathAlg.n3)
        if !NumInt.isZero(n: n1) { return [] }
        return [
            Gen(label: "u1_h", deg: 7, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (1, Way(type: .a12, len: 2 * n3 - 1)),
                                              (1, Way(type: .a23, len: 2 * n1 - 1)),
                                              (1, Way(type: .a31, len: 2 * n2 - 1)),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero)]),
            Gen(label: "u2_h", deg: 7, elem: [(0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (1, Way(type: .a21, len: 2 * n3 - 1)),
                                              (1, Way(type: .a32, len: 2 * n1 - 1)),
                                              (1, Way(type: .a13, len: 2 * n2 - 1)),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero),
                                              (0, Way.zero), (0, Way.zero), (0, Way.zero)])
        ]
    }

    private var imRows: [[(Int, Way)]] = []
    private var imRk = -1
    private let deg: Int

    init(deg: Int) {
        self.deg = deg
    }

    func check(_ elem: Gen) -> String? {
        if elem.deg != deg { return "Bad deg \(deg)" }
        let q = BimodQ(deg: elem.deg)
        if q.pij.count != elem.elem.count {
            return "Bad count, should be \(q.pij.count)"
        }
        for i in 0 ..< elem.elem.count {
            if elem.elem[i].0 == 0 { continue }
            let w = elem.elem[i].1
            if w.isZero {
                return "Zero \(i)-th way"
            }
            if w.startVertex != q.pij[i].1 {
                return "Bad startVertex in \(i)-th way \(w.str), should be " + q.pij[i].1.str
            }
            if w.endVertex != q.pij[i].0 {
                return "Bad endVertex in \(i)-th way \(w.str), should be " + q.pij[i].0.str
            }
        }
        return checkKer(elem) ?? checkNotIm(elem)
    }

    private func checkKer(_ elem: Gen) -> String? {
        let q = BimodQ(deg: elem.deg)
        let m = Matrix(zeroMatrix: elem.elem.count, h: 1)
        for i in 0 ..< elem.elem.count {
            if elem.elem[i].0 == 0 { continue }
            m.rows[0][i].add(left: elem.elem[i].1, right: Way(vertexType: q.pij[i].1), koef: elem.elem[i].0)
        }
        let zeroMatrix = Matrix(mult: m, and: Diff(deg: elem.deg))
        if zeroMatrix.height != 1 { return "checkKer: Bad matrix height \(zeroMatrix.height)" }
        for c in zeroMatrix.rows[0] {
            if c.isZero { continue }
            let res = ImMatrix.pair(from: c, way: nil)
            switch res {
            case .ok(let k, _):
                if k != 0 { return "checkKer: Comb not zero in im " + c.str + ", k = \(k)" }
            case .error(let error):
                return "checkKer: " + error
            }
        }
        return nil
    }

    func checkNotIm(_ elem: Gen, inIm: Bool = false, log: Bool = false) -> String? {
        if elem.deg == 0 { return nil }
        if imRk == -1 {
            let im = ImMatrix(diff: Diff(deg: elem.deg - 1))
            imRk = KoefIntMatrix(im: im.rows).rank
            imRows = im.rows
        }
        if !imRows.isEmpty && imRows[0].count != elem.elem.count { return "checkNotIm: Bad elem count, im width=\(imRows[0].count)" }
        for i in 0 ..< elem.elem.count {
            if elem.elem[i].0 == 0 { continue }
            let w = elem.elem[i].1
            if let j = imRows.firstIndex(where: { $0[i].0 != 0 }) {
                if w.startVertex != imRows[j][i].1.startVertex {
                    return "checkNotIm: Bad \(i)-th startVertex, elem=" + elem.str
                }
                if w.endVertex != imRows[j][i].1.endVertex {
                    return "checkNotIm: Bad \(i)-th endVertex, elem=" + elem.str
                }
            } /*else {
                PrintUtils.printImMatrix("Im", im)
                return "checkNotIm: Zero im \(i)-th column"
            }*/
        }
        imRows.append(elem.elem)
        if log { PrintUtils.printImRows("Im", imRows); PrintUtils.printKoefIntMatrix("KK", KoefIntMatrix(im: imRows)) }
        let addRk = KoefIntMatrix(im: imRows).rank
        if inIm {
            _ = imRows.popLast()
            return addRk == imRk ? nil : "checkNotIm: Not in im"
        }
        if addRk == imRk {
            _ = imRows.popLast()
            return "checkNotIm: Same rank \(addRk)"
        } else {
            imRk = addRk
        }
        return nil
    }

    func printIm() {
        PrintUtils.printImRows("Im rows", imRows);
    }
}
