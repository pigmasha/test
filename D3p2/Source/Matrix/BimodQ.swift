//
//  BimodQ.swift
//
//  Created by M on 31.10.2021.
//

import Foundation

final class BimodQ {
    let pij: [(VertexType, VertexType)]

    init(deg: Int) {
        let L1: [(VertexType, VertexType)] = [(.e1, .e1), (.e2, .e2), (.e3, .e3)]
        let L2: [(VertexType, VertexType)] = [(.e1, .e2), (.e2, .e3), (.e3, .e1), (.e2, .e1), (.e3, .e2), (.e1, .e3)]
        var pp: [(VertexType, VertexType)] = []
        let d = deg / 2
        if deg % 2 == 0 {
            for i in 0 ... d {
                if i == 0 {
                    pp += L1
                } else {
                    pp += i % 3 == 0 ? L1 + L1 : L2
                }
            }
        } else {
            for i in 0 ... d {
                pp += i % 3 == 1 ? L1 + L1 : L2
            }
        }
        pij = pp
    }

    var str: String {
        var s = ""
        let s1 = PathAlg.isTex ? "P_{" : "P<sub>"
        let s2 = PathAlg.isTex ? "}" : "</sub>"
        let s3 = PathAlg.isTex ? "\\oplus " : "&oplus;"
        for p in pij {
            if s != "" { s += s3 }
            s += s1 + p.0.str + "," + p.1.str + s2
        }
        return s
    }
}
