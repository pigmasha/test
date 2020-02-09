//
//  Created by Mariya Kachalova on 22/12/2019.
//

import Foundation

final class BimodKoefs {
    let koefs: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]])

    init(deg: Int) {
        switch deg {
        case 0: koefs = BimodKoefs.koefs0
        case 1: koefs = BimodKoefs.koefs1
        case 2: koefs = BimodKoefs.koefs2
        case 3: koefs = BimodKoefs.koefs3
        case 4: koefs = BimodKoefs.koefs4
        case 5: koefs = BimodKoefs.koefs5
        case 6: koefs = BimodKoefs.koefs6
        case 7: koefs = BimodKoefs.koefs7
        case 8: koefs = BimodKoefs.koefs8
        case 9: koefs = BimodKoefs.koefs9
        case 10: koefs = BimodKoefs.koefs10
        case 11: koefs = BimodKoefs.koefs11
        case 12: koefs = BimodKoefs.koefs12
        case 13: koefs = BimodKoefs.koefs13
        case 14: koefs = BimodKoefs.koefs14
        case 15: koefs = BimodKoefs.koefs15
        case 16: koefs = BimodKoefs.koefs16
        case 17: koefs = BimodKoefs.koefs17
        case 18: koefs = BimodKoefs.koefs18
        case 19: koefs = BimodKoefs.koefs19
        case 20: koefs = BimodKoefs.koefs20
        case 21: koefs = BimodKoefs.koefs21
        case 22: koefs = BimodKoefs.koefs22
        case 23: koefs = BimodKoefs.koefs23
        case 24: koefs = BimodKoefs.koefs24
        case 25: koefs = BimodKoefs.koefs25
        case 26: koefs = BimodKoefs.koefs26
        case 27: koefs = BimodKoefs.koefs27
        case 28: koefs = BimodKoefs.koefs28
        default: fatalError()
        }
    }

    func koefs(at i: Int) -> [[Int]] {
        switch i {
        case 0: return koefs.0
        case 1: return koefs.1
        case 2: return koefs.2
        case 3: return koefs.3
        case 4: return koefs.4
        case 5: return koefs.5
        case 6: return koefs.6
        case 7: return koefs.7
        default: fatalError("Bad index \(i)")
        }
    }

    private static var koefs0: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]])
    }

    private static var koefs1: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]])
    }

    private static var koefs2: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1],[-1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]])
    }

    private static var koefs3: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1,1]])
    }

    private static var koefs4: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,0],[-1,1]], [[1]], [[1]], [[1]], [[1,1]], [[1]], [[1,1]], [[1],[-1]])
    }

    private static var koefs5: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1,0],[1,0,1]], [[1]], [[1]], [[1]], [[1],[-1]], [[1]], [[1],[-1]], [[1,1]])
    }

    private static var koefs6: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,0],[-1,1],[-1,0]], [[1]], [[1]], [[1,1]], [[1]], [[1,1]], [[1,1]], [[1,0],[-1,1]])
    }

    private static var koefs7: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,0,1,0],[1,1,0,1]], [[1]], [[1]], [[1],[-1]], [[1]], [[1],[-1]], [[1,0],[-1,1]], [[1,1,0],[1,0,1]])
    }

    private static var koefs8: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,0,0],[0,1,0],[-1,0,1],[-1,-1,0]], [[1]], [[1,1]], [[1]], [[1,1]], [[1,1]],
                [[1,1,0],[1,0,1]], [[1,0],[-1,1],[-1,0]])
    }

    private static var koefs9: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1,0,0],[-1,0,1,0],[1,0,0,1]], [[1]], [[1],[-1]], [[1]], [[1],[-1]], [[1,0],[-1,1]],
                [[1,0],[-1,1],[-1,0]], [[1,0,1,0],[1,1,0,1]])
    }

    private static var koefs10: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,0,0],[-1,1,0],[1,0,1],[-1,0,0]], [[1,1]], [[1]], [[1,1]], [[1,1]], [[1,1,0],[1,0,1]],
                [[1,1,0],[1,0,1]], [[1,0,0],[0,1,0],[-1,0,1],[-1,-1,0]])
    }

    private static var koefs11: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1,0,0,0],[1,0,1,0,1],[0,-1,0,1,0]], [[1],[-1]], [[1]], [[1],[-1]], [[1,0],[-1,1]],
                [[1,0],[-1,1],[-1,0]], [[1,0],[-1,1],[-1,0]], [[1,1,0,0],[-1,0,1,0],[1,0,0,1]])
    }

    private static var koefs12: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1,0],[-1,0,0],[0,-1,1],[-1,0,0],[-1,0,-1]], [[1]], [[1,1]], [[1,1]], [[1,0],[1,1]],
                [[1,1,0],[1,0,1]], [[1,1,0],[1,0,1]], [[1,0,0],[-1,1,0],[1,0,1],[-1,0,0]])
    }

    private static var koefs13: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1,0,0],[-1,0,0,1],[-1,0,1,0]], [[1]], [[1],[-1]], [[1,0],[-1,1]], [[1],[-1]], [[1,0],[-1,1],[-1,0]],
                [[1,0],[-1,1],[-1,0]], [[1,1,0,0,0],[1,0,1,0,1],[0,-1,0,1,0]])
    }

    private static var koefs14: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,0,0],[-1,1,0],[1,0,1],[1,0,0]], [[1,1]], [[1,1]], [[1,0],[1,1]], [[1,1]], [[1,1,0],[1,0,1]],
                [[1,0,0],[1,1,1]], [[1,1,0],[-1,0,0],[0,-1,1],[-1,0,0],[-1,0,-1]])
    }

    private static var koefs15: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1,0,0,0],[1,0,1,0,1],[0,-1,0,1,0]], [[1],[-1]], [[1,0],[-1,1]], [[1],[-1]], [[1],[-1]],
                [[1,0],[-1,1],[-1,0]], [[1,0],[-1,1],[0,-1]], [[1,1,0,0],[-1,0,0,1],[-1,0,1,0]])
    }

    private static var koefs16: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1,0],[-1,0,0],[0,-1,1],[-1,0,0],[-1,0,-1]], [[1,1]], [[1,0],[1,1]], [[1,1]], [[1]],
                [[1,0,0],[1,1,1]], [[1,0,1],[1,1,0]], [[1,0,0],[-1,1,0],[1,0,1],[1,0,0]])
    }

    private static var koefs17: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1,0,0],[-1,0,0,1],[-1,0,1,0]], [[1,0],[-1,1]], [[1],[-1]], [[1],[-1]], [[1]], [[1,0],[-1,1],[0,-1]],
                [[1,0],[-1,1],[-1,0]], [[1,1,0,0,0],[1,0,1,0,1],[0,-1,0,1,0]])
    }

    private static var koefs18: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,0,0],[-1,1,0],[1,0,1],[1,0,0]], [[1,0],[1,1]], [[1,1]], [[1]], [[1,1]], [[1,0,1],[1,1,0]],
                [[1,1,0],[1,0,1]], [[1,1,0],[-1,0,0],[0,-1,1],[-1,0,0],[-1,0,-1]])
    }

    private static var koefs19: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1,0,0],[1,0,0,1],[0,-1,1,0]], [[1],[-1]], [[1],[-1]], [[1]], [[1],[-1]], [[1,0],[-1,1],[-1,0]],
                [[1,0],[-1,1],[-1,0]], [[1,1,0,0],[-1,0,0,1],[-1,0,1,0]])
    }

    private static var koefs20: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1],[-1,0],[-1,0],[-1,-1]], [[1,1]], [[1]], [[1,1]], [[1]], [[1,1,0],[1,0,1]], [[1,0],[1,1]],
                [[1,0,0],[-1,1,0],[1,0,1],[1,0,0]])
    }

    private static var koefs21: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,0,0],[-1,1,1]], [[1],[-1]], [[1]], [[1],[-1]], [[1]], [[1,0],[-1,1],[-1,0]], [[1],[-1]],
                [[1,1,0,0],[1,0,0,1],[0,-1,1,0]])
    }

    private static var koefs22: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,0],[1,1],[0,-1]], [[1]], [[1,1]], [[1]], [[1]], [[1,0],[1,1]], [[1,1]], [[1,1],[-1,0],[-1,0],[-1,-1]])
    }

    private static var koefs23: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1],[-1,0]], [[1]], [[1],[-1]], [[1]], [[1]], [[1],[-1]], [[1],[-1]], [[1,0,0],[-1,1,1]])
    }

    private static var koefs24: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1],[-1]], [[1,1]], [[1]], [[1]], [[1]], [[1,1]], [[1]], [[1,0],[1,1],[0,-1]])
    }

    private static var koefs25: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1,1]], [[1],[-1]], [[1]], [[1]], [[1]], [[1],[-1]], [[1]], [[1,1],[-1,0]])
    }

    private static var koefs26: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1],[-1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1],[-1]])
    }

    private static var koefs27: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1,1]])
    }

    private static var koefs28: ([[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]], [[Int]]) {
        return ([[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1]], [[1],[-1]])
    }
}

