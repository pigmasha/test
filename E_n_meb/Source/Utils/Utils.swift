
import Foundation

class Utils : NSObject {
    static func gcd(_ ii: Int, j jj: Int) -> Int {
        let i = ii < 0 ? -ii : ii
        let j = jj < 0 ? -jj : jj
        var k = i > j ? i : j
        var l = i > j ? j : i
        var p = 0
        while (k % l != 0) {
            p = k % l
            k = l
            l = p
        }
        return l
    }
}
