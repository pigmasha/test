//
//  Created by M on 09.06.2018.
//

import Foundation

struct Step_4_dimhom {
    static func runCase() -> Bool {
        let s = PathAlg.s
        OutputFile.writeLog(.bold, "s=\(s)")

        let degMax = 50 * s * PathAlg.twistPeriod

        for deg in 0 ..< degMax {
            let q = BimodQ(deg: deg)
            var lengthes: [[NumInt]] = []
            var prevSum = 0
            for nSq in 0 ..< q.sizes.count {
                let sz = q.sizes[nSq].intValue
                var ll: [NumInt] = []
                for j in 0 ..< sz * s {
                    let p = q.pij[prevSum + j]
                    let w = Way(from: p.n1, to: p.n0)
                    if w.isZero { continue }
                    ll.append(NumInt(intValue: w.len))
                    if w.len == 0 {
                        let w2 = Way(from: p.n1, to: p.n0, noZeroLen: true)
                        if !w2.isZero { ll.append(NumInt(intValue: w2.len)) }
                    }
                }
                prevSum += sz * s
                lengthes.append(ll)
            }
            if lengthes.count != 6 {
                OutputFile.writeLog(.error, "Bad lengthes count = \(lengthes.count)")
                return true
            }
        }
        return false
    }
}

/*BOOL _RunCase() {
    for (NSInteger deg = 0; deg < degMax; deg++) {
        NSMutableArray* myLens = [[NSMutableArray alloc] init];
        FillMyLens(deg, myLens);

        if (!IsVectorsEqual([lengthes objectAtIndex:0], [myLens objectAtIndex:0], s)) ON_ERROR(1);
        if (!IsVectorsEqual([lengthes objectAtIndex:1], [myLens objectAtIndex:1], s)) ON_ERROR(2);
        if (!IsVectorsEqual([lengthes objectAtIndex:2], [myLens objectAtIndex:1], s)) ON_ERROR(3);
        if (!IsVectorsEqual([lengthes objectAtIndex:3], [myLens objectAtIndex:2], s)) ON_ERROR(4);
        if (!IsVectorsEqual([lengthes objectAtIndex:4], [myLens objectAtIndex:2], s)) ON_ERROR(5);
        if (!IsVectorsEqual([lengthes objectAtIndex:5], [myLens objectAtIndex:3], s)) ON_ERROR(6);

        NSInteger deg2 = 0;
        for (NSArray* item in lengthes) deg2 += [item count];

        [lengthes release];
        [myLens   release];

        NSInteger myDeg = dimHom(deg);
        if (deg2 != myDeg) {
            NSLog(@"Error! Bad dimHom=%d (must be %d), s=%d, deg=%d", myDeg, deg2, s, deg % PathAlg.twistPeriod);
            return YES;
        }
    }

    return NO;
}

//---------------------------------------------------------------------------------
void FillMyLens(NSInteger deg, NSMutableArray* items) {
    NSInteger n = PathAlg.n;
    NSInteger s = PathAlg.s;

    NSInteger ell = deg / PathAlg.twistPeriod;
    NSInteger d = deg % PathAlg.twistPeriod;
    NSInteger m = d / 2;

    BOOL eq0 = (s == 1) ? YES :((ell * n + m) % s == 0);
    BOOL eq1 = (s == 1) ? YES :((ell * n + m) % s == 1);

    BOOL eq2s0 = ((ell * (n + s) + m) % (2 * s) == 0);
    BOOL eq2s1 = ((ell * (n + s) + m) % (2 * s) == 1);

    BOOL eqs2s0 = ((ell * (n + s) + m) % (2 * s) == s);
    BOOL eqs2s1 = ((ell * (n + s) + m) % (2 * s) == s + 1) || (s == 1 && ((ell * (n + 1) + m) % 2 == 0));

    NSMutableArray* lens1 = [[NSMutableArray alloc] init];
    NSMutableArray* lens2 = [[NSMutableArray alloc] init];
    NSMutableArray* lens3 = [[NSMutableArray alloc] init];
    NSMutableArray* lens4 = [[NSMutableArray alloc] init];
    switch (d) {
    case 0:
        // 1
        if (eq0) [NumInt pushN: 0 toArr: lens1];
        if (eq1) [NumInt pushN: 4 toArr: lens1];
        // 2
        if (eq2s0) [NumInt pushN: 0 toArr: lens2];
        if (eq2s1 || s == 1) [NumInt pushN: 4 toArr: lens2];
        // 3
        if (eq2s0) [NumInt pushN: 0 toArr: lens3];
        if (eq2s1 || s == 1) [NumInt pushN: 4 toArr: lens3];
        // 4
        if (eq0) [NumInt pushN: 0 toArr: lens4];
        if (eq1) [NumInt pushN: 4 toArr: lens4];
        break;
    case 1:
        // 1
        if (eq0) { [NumInt pushN: 1 toArr: lens1]; [NumInt pushN: 1 toArr: lens1]; }
        // 2
        if (eq2s0) [NumInt pushN: 1 toArr: lens2];
        // 3
        if (eq0) [NumInt pushN: 1 toArr: lens3];
        // 4
        if (eq0) [NumInt pushN: 1 toArr: lens4];
        break;
    case 2:
        // 1
        if (eq1) [NumInt pushN: 3 toArr: lens1];
        // 2
        if (eq2s0) [NumInt pushN: 1 toArr: lens2];
        // 3
        if (eqs2s1) [NumInt pushN: 3 toArr: lens3];
        // 4
        if (eq0) [NumInt pushN: 1 toArr: lens4];
        break;
    case 3:
        // 1
        if (eq0) { [NumInt pushN: 2 toArr: lens1]; [NumInt pushN: 2 toArr: lens1]; }
        // 2
        if (eq0) [NumInt pushN: 2 toArr: lens2];
        // 3
        if (eq0) [NumInt pushN: 2 toArr: lens3];
        // 4
        if (eq0) { [NumInt pushN: 2 toArr: lens4]; [NumInt pushN: 2 toArr: lens4]; }
        break;
    case 4:
        // 1
        if (eq0) [NumInt pushN: 0 toArr: lens1];
        if (eq1) { [NumInt pushN: 3 toArr: lens1]; [NumInt pushN: 4 toArr: lens1]; }
        // 2
        if (eqs2s0) [NumInt pushN: 0 toArr: lens2];
        if (eqs2s1 || s == 1) [NumInt pushN: 4 toArr: lens2];
        // 3
        if (eq2s1) [NumInt pushN: 3 toArr: lens3];
        if (eqs2s0) [NumInt pushN: 0 toArr: lens3];
        if (eqs2s1 || s == 1) [NumInt pushN: 4 toArr: lens3];
        // 4
        if (eq0) [NumInt pushN: 0 toArr: lens4];
        if (eq1) [NumInt pushN: 4 toArr: lens4];
        break;
    case 5:
        // 1
        if (eq0) { [NumInt pushN: 1 toArr: lens1]; [NumInt pushN: 1 toArr: lens1]; }
        // 2
        if (eq0) [NumInt pushN: 3 toArr: lens2];
        // 3
        if (eq0) [NumInt pushN: 1 toArr: lens3];
        // 4
        if (eq0) { [NumInt pushN: 3 toArr: lens4]; [NumInt pushN: 3 toArr: lens4]; }
        break;
    case 6:
        // 1
        if (eq0) [NumInt pushN: 0 toArr: lens1];
        if (eq1) [NumInt pushN: 4 toArr: lens1];
        // 2
        if (eq2s0) [NumInt pushN: 0 toArr: lens2];
        if (eq2s1 || s == 1) [NumInt pushN: 4 toArr: lens2];
        if (eqs2s0) [NumInt pushN: 1 toArr: lens2];
        // 3
        if (eq2s0) [NumInt pushN: 0 toArr: lens3];
        if (eq2s1 || s == 1) [NumInt pushN: 4 toArr: lens3];
        // 4
        if (eq0) { [NumInt pushN: 0 toArr: lens4]; [NumInt pushN: 1 toArr: lens4]; }
        if (eq1) [NumInt pushN: 4 toArr: lens4];
        break;
    case 7:
        // 1
        if (eq0) { [NumInt pushN: 2 toArr: lens1]; [NumInt pushN: 2 toArr: lens1]; }
        // 2
        if (eq0) [NumInt pushN: 2 toArr: lens2];
        // 3
        if (eq0) [NumInt pushN: 2 toArr: lens3];
        // 4
        if (eq0) { [NumInt pushN: 2 toArr: lens4]; [NumInt pushN: 2 toArr: lens4]; }
        break;
    case 8:
        // 1
        if (eq1) [NumInt pushN: 3 toArr: lens1];
        // 2
        if (eq2s0) [NumInt pushN: 1 toArr: lens2];
        // 3
        if (eqs2s1) [NumInt pushN: 3 toArr: lens3];
        // 4
        if (eq0) [NumInt pushN: 1 toArr: lens4];
        break;
    case 9:
        // 1
        if (eq0) [NumInt pushN: 3 toArr: lens1];
        // 2
        if (eq0) [NumInt pushN: 3 toArr: lens2];
        // 3
        if (eqs2s0) [NumInt pushN: 3 toArr: lens3];
        // 4
        if (eq0) { [NumInt pushN: 3 toArr: lens4]; [NumInt pushN: 3 toArr: lens4]; }
        break;
    case 10:
        // 1
        if (eq0) [NumInt pushN: 0 toArr: lens1];
        if (eq1) [NumInt pushN: 4 toArr: lens1];
        // 2
        if (eqs2s0) [NumInt  pushN: 0 toArr: lens2];
        if (eqs2s1 || s == 1) [NumInt pushN: 4 toArr: lens2];
        // 3
        if (eqs2s0) [NumInt pushN: 0 toArr: lens3];
        if (eqs2s1 || s == 1) [NumInt pushN: 4 toArr: lens3];
        // 4
        if (eq0) [NumInt pushN: 0 toArr: lens4];
        if (eq1) [NumInt pushN: 4 toArr: lens4];
        break;
    }
    [items addObject:lens1];
    [lens1 release];
    [items addObject:lens2];
    [lens2 release];
    [items addObject:lens3];
    [lens3 release];
    [items addObject:lens4];
    [lens4 release];
}

//---------------------------------------------------------------------------------
BOOL IsVectorsEqual(NSArray* a, NSArray* b, NSInteger s) {
    if ([a count] != s * [b count]) return NO;
    NSInteger aL[10];
    NSInteger bL[10];
    for (NSInteger i = 0; i < 10; i++) {
        aL[i] = 0;
        bL[i] = 0;
    }
    for (NumInt* n in a) aL[[n intValue]]++;
    for (NumInt* n in b) bL[[n intValue]]++;

    for (NSInteger i = 0; i < 10; i++) {
        if (aL[i] != bL[i] * s) return NO;
    }
    return YES;
}
*/
