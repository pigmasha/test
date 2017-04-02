//
//  Created by M on 11.01.16.
//
//

#ifdef MAIN_CREATEHH

#import "Utils.h"
#import "HHElem.h"
#import "CheckHH.h"
#import "PrintUtils.h"

BOOL ProcessType(NSInteger type);

BOOL _RunCase() {
    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;
    
    WriteLog(2, "N=%d, S=%d, Char=%d (types %d)",  n, s, [PathAlg.alg charK], 22);

    for (NSInteger type = 1; type <= 22; type++)
        if (ProcessType(type)) return YES;

    return NO;
}

BOOL ProcessType(type) {
    for (NSInteger deg = 1; deg < 30 * PathAlg.alg.twistPeriod + 2; deg++) {
        if (![Dim deg:deg hasType:type]) continue;

        NSInteger ell = deg / PathAlg.alg.twistPeriod;

        HHElem *hh = [[HHElem alloc] initWithDeg:deg type:type];
        WriteLog(2, "HH (ell=%d)", ell);
        //printMatrix(hh);

        if (!CheckHHElem(hh, deg)) {
            [hh release];
            return YES;
        }
        [hh release];
    }
    return NO;
}

#endif
