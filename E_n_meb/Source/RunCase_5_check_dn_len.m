#ifdef MAIN_CHECK_DN_LEN

#import "Utils.h"
#import "Diff.h"
#import "PrintUtils.h"
#import "CalcDiff.h"

//---------------------------------------------------------------------------------
BOOL _RunCase() {
    NSInteger n = PathAlg.n;
    NSInteger s = PathAlg.s;
    
    WriteLog(3, "N=%d, S=%d",  n, s);
    
    for (NSInteger deg = 1; deg < 2 * PathAlg.twistPeriod + 2; deg++) {
        Diff *diff = [[Diff alloc] initWithDeg:deg];
        
        NSInteger err = checkDiffLen(diff, deg);
        
        if (err) {
            [diff release];
            WriteLog(2, "deg=%d: ERROR= %d!", deg, err);
            NSLog(@"deg=%d: ERROR= %d!", deg, err);
            return YES;
        }
        [diff release];
    }
    return NO;
}

#endif
