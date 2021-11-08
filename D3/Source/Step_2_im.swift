//
//  Step_2_im.swift
//
//  Created by M on 07.11.2021.
//

import Foundation

struct Step_2_im {
    static func runCase() -> Bool {
        for d in 0 ... 10 {
            let im = ImMatrix(diff: Diff(deg: d))
            PrintUtils.printImMatrix("Im \(d)", im)
            let k = KoefIntMatrix(im: im.rows)
            PrintUtils.printKoefIntMatrix("Koefs", k)
        }
        return false
    }
}
