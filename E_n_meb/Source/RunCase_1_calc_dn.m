#ifdef MAIN_CALC_DN

#import "RunCase.h"
#import "CalcDiff.h"
#import "Utils.h"
#import "Diff.h"

BOOL _RunCase() {
    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;
    
    WriteLog(3, "N=%d, S=%d",  n, s);
    
    BOOL isErr = NO;
    
    Diff *prevDiff = nil;
    
    for (NSInteger deg = 0; deg < 2 * PathAlg.alg.twistPeriod + 2; deg++) {
        Diff *diff = [[Diff alloc] initWithDeg:deg];
        NSInteger err = calcDiffWithNumber(diff, deg, prevDiff);
        
        if (err) {
            [diff release];
            WriteLog(2, "ERROR %d!", err);
            isErr = YES;
            break;
        }
        [prevDiff release];
        prevDiff = [[Diff alloc] initWithMatrix:diff];
        [diff release];
    }
    [prevDiff release];
    return isErr;
}

#endif
