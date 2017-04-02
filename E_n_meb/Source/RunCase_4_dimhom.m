#ifdef MAIN_DIMHOM

#import "Utils.h"
#import "BimodQ.h"
#import "Dim.h"

void FillMyLens(NSInteger deg, NSMutableArray* items);
BOOL IsVectorsEqual(NSArray* a, NSArray* b, NSInteger s);

#define ON_ERROR(__c) { \
    NSLog(@"ERROR %d, d=%d (%@\n\n%@)", __c, deg, lengthes, myLens); \
    [lengthes release]; \
    [myLens   release]; \
    WriteLog(2, "ERROR %d", __c); \
    return YES; \
}

//----------------------------------------------------------------------------
BOOL _RunCase() {
    NSInteger s = PathAlg.alg.s;
    
    WriteLog(2, "s=%d", s);
    
    NSInteger degMax = 50 * s * PathAlg.alg.twistPeriod;
    
    for (NSInteger deg = 0; deg < degMax; deg++) {
        BimodQ *q = [[BimodQ alloc] initForDeg:deg];
        
        NSMutableArray* lengthes = [[NSMutableArray alloc] init];
        NSInteger prevSum = 0;
        for (NSInteger nSq = 0; nSq < [q.sizes count]; nSq++) {
            NSInteger sz = [[q.sizes objectAtIndex:nSq] intValue];
            
            NSMutableArray* ll = [[NSMutableArray alloc] init];
            
            for (NSInteger j = 0; j < sz * s; j++) {
                IntPair *p = q.pij[prevSum + j];
                Way *w = [[Way alloc] initFrom: [p n1] to:[p n0]];
                if ([w isZero]) { [w release]; continue; }
                
                [NumInt pushN: [w len] toArr: ll];
                if ([w len] == 0) {
                    Way *w2 = [[Way alloc] initFrom: [p n1] to:[p n0] noZeroLen: YES];
                    if (![w2 isZero]) [NumInt pushN: [w2 len] toArr: ll];
                    [w2 release];
                }
                [w release];
            }
            prevSum += sz * s;
            [lengthes addObject:ll];
            [ll release];
        }
        
        if ([lengthes count] != 6) {
            WriteLog(1, "Bad lengthes count = %d", [lengthes count]);
            [lengthes release];
            return YES;
        }
        
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
            NSLog(@"Error! Bad dimHom=%d (must be %d), s=%d, deg=%d", myDeg, deg2, s, deg % PathAlg.alg.twistPeriod);
            WriteLog(2, "Error! Bad dimHom=%d (must be %d), s=%d, deg=%d", myDeg, deg2, s, deg % PathAlg.alg.twistPeriod);
            return YES;
        }
    }
    
    return NO;
}

//---------------------------------------------------------------------------------
void FillMyLens(NSInteger deg, NSMutableArray* items) {
    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;
    
    NSInteger ell = deg / PathAlg.alg.twistPeriod;
    NSInteger d = deg % PathAlg.alg.twistPeriod;
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

#endif
