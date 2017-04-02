#ifdef MAIN_DIMHH

#import "Utils.h"
#import "Diff.h"
#import "ImMatrix.h"
#import "PrintUtils.h"
#import "KoefMatrix.h"


int dimHH2(NSInteger deg);

//---------------------------------------------------------------------------------
BOOL _RunCase() {
    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;
    
    WriteLog(2, "N=%d, S=%d, Char=%d",  n, s, [PathAlg.alg charK]);
    
    for (NSInteger deg = 1; deg < 30 * PathAlg.alg.twistPeriod + 2; deg++) {
        NSInteger r = (deg % PathAlg.alg.twistPeriod);
        NSInteger m = (NSInteger)(r / 2);
        NSInteger ell = deg / PathAlg.alg.twistPeriod;

        NSInteger dimHom1 = dimHom(deg);
        NSInteger dimIm1 = dimIm(deg);
        NSInteger dimIm2 = dimIm(deg - 1);
        NSInteger dimHH1 = dimHH(deg);
        
        if (dimHH1 != dimHom1 - dimIm1 - dimIm2 || dimHH1 != dimHH2(deg)) {
            WriteLog(1, "HH %d and %d (deg=%d, r=%d, ell=%d, char=%d)", dimHH1, dimHom1 - dimIm1 - dimIm2, deg, r, ell, [PathAlg.alg charK]);
        }
    }
    return NO;
}

//----------------------------------------------------------------------------
int dimHH2(NSInteger deg) {
    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;
    NSInteger charK = [PathAlg.alg charK];

    NSInteger ell = deg / PathAlg.alg.twistPeriod;
    NSInteger r = deg % PathAlg.alg.twistPeriod;
    NSInteger m = r / 2;

    if (s == 1) {
        if (r == 0 && ell % 2 == 0 && charK == 3) return 6;
        if (r == 4 && ell % 2 == 1 && charK == 3) return 6;

        if (r == 0 && ell % 2 == 0 && charK != 3) return 5;
        if (r == 4 && ell % 2 == 1 && charK != 3) return 5;
        if (r == 6 && ell % 2 == 1 && charK == 2) return 5;

        if (r == 6 && ell % 2 == 1 && charK != 2) return 4;
        if (r == 10 && ell % 2 == 0) return 4;

        if (r == 6 && ell % 2 == 0 && charK == 3) return 2;
        if (r == 10 && ell % 2 == 1 && charK == 3) return 2;

        if (r == 1 || r == 9) return 1;
        if (r == 2 && ell % 2 == 1) return 1;
        if (r == 3 && (ell % 2 == 1 || charK == 2)) return 1;
        if (r == 4 && ell % 2 == 0 && charK == 2) return 1;
        if (r == 5 && charK == 3) return 1;
        if (r == 6 && ell % 2 == 0 && charK != 3) return 1;
        if (r == 7 && (ell % 2 == 0 || charK == 2)) return 1;
        if (r == 8 && ell % 2 == 0) return 1;
        if (r == 10 && ell % 2 == 1 && charK != 3) return 1;

        return 0;
    }

    BOOL eq20 = ((ell * (n + s) + m) % (2 * s) == 0);
    BOOL eq21 = ((ell * (n + s) + m) % (2 * s) == 1);

    BOOL eq2s0 = ((ell * (n + s) + m) % (2 * s) == s);
    BOOL eq2s1 = ((ell * (n + s) + m) % (2 * s) == s + 1);

    if ((r == 0 || r == 1 || r == 8 || r == 9) && eq20 && (ell % 2 == 0 || charK == 2)) return 1;
    if (r == 0 && eq2s1 && ell % 2 == 0 && charK == 3) return 1;
    if ((r == 1 || r == 9) && eq2s0 && (ell % 2 == 1 || charK == 2)) return 1;
    if ((r == 2 || r == 10) && eq2s1 && (ell % 2 == 1 || charK == 2)) return 1;
    if (r == 3 && eq20) return 1;
    if (r == 3 && eq2s0 && charK == 2) return 1;
    if ((r == 4 || r == 5) && eq2s0 && ell % 2 == 1 && charK == 3) return 1;
    if (r == 4 && eq21) return 1;
    if (r == 4 && eq2s1 && charK == 2) return 1;
    if (r == 5 && eq20 && ell % 2 == 0 && charK == 3) return 1;
    if ((r == 6 || r == 7) && eq20 && charK == 2) return 1;
    if ((r == 6 || r == 7) && eq2s0) return 1;
    if (r == 6 && eq21 && ell % 2 == 0 && charK == 3) return 1;
    if (r == 10 && eq20 && ell % 2 == 1 && charK == 3) return 1;

    return 0;
}

#endif
