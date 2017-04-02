#ifdef MAIN_IM

#import "Utils.h"
#import "Diff.h"
#import "ImMatrix.h"
#import "PrintUtils.h"
#import "KoefMatrix.h"

//---------------------------------------------------------------------------------
BOOL _RunCase() {
    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;
    
    WriteLog(2, "N=%d, S=%d, Char=%d",  n, s, [PathAlg.alg charK]);
    
    for (NSInteger deg = 1; deg < 12 * PathAlg.alg.twistPeriod + 2; deg++) {
        NSInteger r = (deg % PathAlg.alg.twistPeriod);
        NSInteger m = (NSInteger)(r / 2);
        NSInteger ell = deg / PathAlg.alg.twistPeriod;

        Diff *diff = [[Diff alloc] initWithDeg:deg];
        ImMatrix * im = [[ImMatrix alloc] initWithDiff: diff];
        KoefIntMatrix * k = [[KoefIntMatrix alloc] initWithIm: im];

        //printMatrixDeg(diff, deg + 1, deg);
        //printImDeg(im, deg);
        //printKoefIntMatrix(k, deg, 0);
        
        NSInteger rk1 = [k rank];
        NSInteger rk2 = [Dim dimIm:deg];

        if (rk1 != rk2) WriteLog(1, "Rk %d and %d (deg=%d, r=%d, ell=%d, char=%d)", rk1, rk2, deg, r, ell, [PathAlg.alg charK]);

        [im release];
        [diff release];
    }
    return NO;
}

#endif
