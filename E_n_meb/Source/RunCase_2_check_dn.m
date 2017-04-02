#ifdef MAIN_CHECK_DN

#import "Utils.h"
#import "Diff.h"
#import "PrintUtils.h"

//---------------------------------------------------------------------------------
BOOL _RunCase() {
    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;
    
    WriteLog(3, "N=%d, S=%d",  n, s);
    
    for (NSInteger deg = 1; deg < 2 * PathAlg.alg.twistPeriod + 2; deg++) {
        Diff *prevDiff = [[Diff alloc] initWithDeg:deg - 1];
        Diff *diff = [[Diff alloc] initWithDeg:deg];

        //WriteLog(0, "deg = %d, diff", deg);
        //printMatrixDeg(diff, deg + 1, deg);
        
        Matrix * multRes = [[Matrix alloc] initMult:prevDiff and: diff];
        [prevDiff release];
        [diff release];

        if ([multRes isNil]) {
            [multRes release];
            WriteLog(2, "deg=%d: mult is nil!", deg);
            return YES;
        }
        
        if (![multRes isZero]) {
            [multRes release];
            WriteLog(2, "deg=%d: mult no zero!", deg);
            return YES;
        }
        [multRes release];
    }
    return NO;
}

#endif
