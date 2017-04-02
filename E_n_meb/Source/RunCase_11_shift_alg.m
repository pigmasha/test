//
//  Created by M on 23.02.16.
//
//

#ifdef MAIN_SHIFT_ALG

#import "Utils.h"
#import "PrintUtils.h"
#import "ShiftHHAlg.h"
#import "ShiftHHAlgAll.h"


BOOL ProcessType(NSInteger type);
BOOL ProcessTypeWithDeg(NSInteger type, NSInteger deg);


BOOL _RunCase() {
    static const NSInteger kCurrentType = 4;

    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;
    
    WriteLog(2, "N=%d, S=%d, Char=%d (types %d)",  n, s, [PathAlg.alg charK], 22);

    for (NSInteger type = kCurrentType; type <= kCurrentType; type++)
        if (ProcessType(type)) return YES;

    return NO;
}

BOOL ProcessType(NSInteger type) {
    for (NSInteger deg = 1; deg < 30 * PathAlg.alg.twistPeriod + 2; deg++) {
        if (![Dim deg:deg hasType:type]) continue;
        if (ProcessTypeWithDeg(type, deg))
            return YES;
        return NO;
    }
    return NO;
}

BOOL ProcessTypeWithDeg(NSInteger type, NSInteger deg) {
    static const NSInteger kTypeWithProof = 3;
    NSInteger ell = deg / PathAlg.alg.twistPeriod;

    HHElem *hh = [[HHElem alloc] initWithDeg:deg type:type];
    WriteLog(5, "HH (ell=%d, type=%d)", ell, type);

    NSInteger shiftMax = 13*PathAlg.alg.twistPeriod + 1;
    for (NSInteger shift = 0; shift < shiftMax; shift++) {
        HHElem *hh_shift = nil;
        if (type > kTypeWithProof) {
            if (shift == 0) {
                printMatrix(hh);
                continue;
            }

            ShiftAllVariants *allVariants = [ShiftHHAlgAll allVariantsForHHElem:hh degree:deg shift:shift];
            hh_shift = [ShiftHHAlgAll selectFromAllVariants:allVariants type:type shift:shift];
            if (hh_shift != nil) {
                WriteLog(5, "HH Shift %d", shift);
                printMatrix(hh_shift);
            } else {
                WriteLog(2, "HH ShiftAll error %d", shift);
                printMatrix(hh_shift);

                NSInteger nDifferences = [ShiftHHAlg shiftHHElem:hh type:type degree:deg shift:shift result:hh_shift];

                WriteLog(2, "HH Shift %d", shift);
                printMatrix(hh_shift);

                if (nDifferences != 0) {
                    WriteLog(1, "Differences count = %d", nDifferences);
                    return YES;
                }
                return YES;
            }
        } else {
            ShiftHHElem *sh = [ShiftHHElem shiftForType:type];
            hh_shift = [[HHElem alloc] init];
            [sh shift:hh_shift degree:deg shift:shift];

            //WriteLog(2, "Shift %zd", shift);
            //printMatrix(hh_shift);
        }

        if (![ShiftHHAlg checkHHMatrix:hh hhShift:hh_shift degree:deg shift:shift]) {
            WriteLog(1, "Shift %zd (%zd) checkHHMatrix failed!", shift, shift % PathAlg.alg.twistPeriod);

            if (type <= kTypeWithProof) {
                WriteLog(2, "Wrong HH Shift");
                printMatrix(hh_shift);

                WriteLog(2, "Right HH Shift");
                ShiftAllVariants *allVariants = [ShiftHHAlgAll allVariantsForHHElem:hh degree:deg shift:shift];
                printMatrix([ShiftHHAlgAll selectFromAllVariants:allVariants type:type shift:shift]);

                //[ShiftHHGenProgram printProgram:hh_shift shift:shift];
            }
            return YES;
        }
        
        hh = [[HHElem alloc] initWithMatrix:hh_shift];
    }
    return NO;
}

#endif
