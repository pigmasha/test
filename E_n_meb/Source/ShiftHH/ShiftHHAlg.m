//
//  Created by M on 01.02.16.
//
//

#import "ShiftHHAlg.h"
#import "Utils.h"
#import "PrintUtils.h"

//
//         d_up
//     Q --------> Q
//     |           |
// hh_s|           |hh
//     |           |
//     v  d_down   V
//     Q --------> Q
//

#define PUSH(__s) \
{ \
    NSInteger nn = goodPosInD[__s].intValue; \
    [goodPosInD removeAllObjects]; \
    [goodPosInD addObject:[NumInt numWithInt:nn]]; \
    goodPos = goodPosInD[0].intValue; \
}

@implementation ShiftHHAlg

+ (NSInteger)shiftHHElem:(HHElem *)hh
                    type:(NSInteger)type
                  degree:(NSInteger)degree
                   shift:(NSInteger)shift
                  result:(HHElem *)hh_shift {
    Matrix *multRes = [[Matrix alloc] initWithMult:hh and:[[Diff alloc] initWithDeg:degree + shift - 1]];

    if (multRes.isNil) {
        WriteLog(1, "Bad multRes size");
        return -1;
    }

    Diff *d_down = [[Diff alloc] initWithDeg:shift - 1];

    NSInteger r_0 = shift % PathAlg.alg.twistPeriod;

    NSInteger width = multRes.width;
    NSInteger height = d_down.width;

    Matrix *multRes_shift = [[Matrix alloc] initWithZeroMatrix:multRes.rows.firstObject.count h:multRes.height];
    [hh_shift makeZeroMatrix:width h:height];

    NSInteger nDifferents = [multRes numberOfDifferents:multRes_shift];

    // in first step set only value which has only one variant
    // (i. e. goodPosInD.size() == 1
    BOOL isFirstStep = YES;
    // j th element of this array is element which obtained in the first step
    // These elements is really right, so we will not
    // change them in the next steps
    NSMutableArray<NSMutableSet<NumInt *> *> *colsValuesForFirstStep = [NSMutableArray new];
    for (NSUInteger j = 0; j < multRes_shift.rows.firstObject.count; j++) {
        [colsValuesForFirstStep addObject:[NSMutableSet new]];
    }

    NSInteger step = 0;
    while (nDifferents > 0) {
        BOOL stepIsNotZero = NO;
        [multRes_shift subtractMatrix:multRes];

        Matrix *hh_sub = [[Matrix alloc] initWithZeroMatrix:width h:height];

        NSMutableSet<NumInt *> *cols = [NSMutableSet new];
        NSMutableSet<NumInt *> *printedJth = [NSMutableSet new];

        for (NSInteger i = 0; i < multRes_shift.height; i++) {
            for (NSInteger j = 0; j < multRes_shift.rows[i].count; j++) { // j th column
                if (multRes_shift.rows[i][j].isZero) continue;

                // start: find good positions in i th line of d_down
                NSMutableArray<NumInt *> *goodPosInD = [NSMutableArray new];
                NSInteger goodPos = -1;

                for (NSInteger k = 0; k < d_down.rows[i].count; k++) {
                    if (d_down.rows[i][k].isZero) {
                        continue;
                    }
                    if (!isFirstStep && [colsValuesForFirstStep[j] containsObject:[NumInt numWithInt:k]]) {
                        continue;
                    }

                    Tenzor *div = [[Tenzor alloc] initByDivide:multRes_shift.rows[i][j].firstTenzor to:d_down.rows[i][k].firstTenzor];

                    if (!div.isZero) {
                        [goodPosInD addObject:[NumInt numWithInt:k]];
                        if (goodPos < 0) {
                            goodPos = k;
                        } else {
                            NSUInteger newLen = d_down.rows[i][k].firstTenzor.leftComponent.len;
                            NSUInteger oldLen = d_down.rows[i][goodPos].firstTenzor.leftComponent.len;
                            if (newLen < oldLen) goodPos = k;
                        }
                    }
                }
                // end: find good positions in i th line of d_down

                if (isFirstStep && goodPosInD.count > 1) {
                    for (NumInt *n in goodPosInD) {
                        hh_shift.rows[n.intValue][j].isFirstStep = YES;
                    }
                    if (goodPosInD.count > 1) continue;
                }

                if (!isFirstStep && goodPosInD.count > 1) {
                    NSInteger p = [self trySelectGoodPosFromArr:goodPosInD hh:hh_shift type:type shift:r_0 j:j];
                    if (p > -1) PUSH(p);
                }

                if (goodPos < 0) continue;

                float koef = 1.0;
                Tenzor *tt;

                do {
                    tt = [[Tenzor alloc] initByDivide:multRes_shift.rows[i][j].firstTenzor to:d_down.rows[i][goodPos].firstTenzor];
                    koef *= multRes_shift.rows[i][j].firstKoef / d_down.rows[i][goodPos].firstKoef;
                    [goodPosInD removeObject:[NumInt numWithInt:goodPos]];

                    if (koef != 0 && !tt.isZero) break;

                    if (goodPosInD.count > 0) {
                        goodPos = goodPosInD.firstObject.intValue;
                    }

                } while (goodPosInD.count > 0);

                if (tt.isZero) continue;

                if (![cols containsObject:[NumInt numWithInt:j]]) {
                    Comb *c = [[Comb alloc] initWithTenzor:tt koef:koef];
                    [hh_sub.rows[goodPos][j] addComb:c];
                    [cols addObject:[NumInt numWithInt:j]];
                    if (isFirstStep) {
                        [colsValuesForFirstStep[j] addObject:[NumInt numWithInt:goodPos]];
                        stepIsNotZero = YES;
                    }
                }
            }
        }
        [hh_shift addMatrix:hh_sub];
        
        if (isFirstStep) {
            for (NSInteger i0 = 0; i0 < hh_shift.height; i0++) {
                for (NSInteger j0 = 0; j0 < hh_shift.width; j0++) {
                    if (!hh_shift.rows[i0][j0].isZero) hh_shift.rows[i0][j0].isFirstStep = YES;
                }
            }
        }

        multRes_shift = [[Matrix alloc] initWithMult:d_down and:hh_shift];
        nDifferents = [multRes numberOfDifferents:multRes_shift];
        
        bool badSituation = step > 5;
        if (badSituation) {
            WriteLog(2, "hh_sub");
            printMatrix(hh_sub);
        }
        if (badSituation) return nDifferents;
        
        if (!stepIsNotZero) {
            isFirstStep = NO;
        }
        ++step;
    }

    return nDifferents;
}

+ (BOOL)checkHHMatrix:(HHElem *)hh
              hhShift:(HHElem *)hhShift
               degree:(NSInteger)degree
                shift:(NSInteger)shift {
    if (shift == 0) {
        if (![hh isEq:hhShift]) return NO;
        WriteLog(0, "checked shift %d :)", shift);
        return YES;
    }

    Diff *d_up = [[Diff alloc] initWithDeg:degree + shift - 1];
    Diff *d_down = [[Diff alloc] initWithDeg:shift - 1];

    Matrix *multRes = [[Matrix alloc] initWithMult:hh and:d_up];
    Matrix *multRes_shift = [[Matrix alloc] initWithMult:d_down and:hhShift];

    BOOL res = NO;
    if (multRes.isNil || multRes_shift.isNil || ![multRes isEq:multRes_shift]) {
        NSInteger nDifferents = [multRes numberOfDifferents:multRes_shift];
        WriteLog(1, "checkHHMatrix error!");
        //WriteLog(0, "multRes");
        //printMatrixDeg(multRes, 0, 0);
        //WriteLog(0, "multRes_shift");
        //printMatrixDeg(multRes_shift, 0, 0);
        //WriteLog(0, "hh_shift");
        //printMatrixDeg(hhShift, 0, 0);
        //WriteLog(0, "d_up");
        //printMatrixDeg(d_up, 0, 0);
        WriteLog(1, "Dirrerents: %d", nDifferents);
    } else {
        WriteLog(0, "checked shift %d :)", shift);
        res = YES;
    }
    return res;
}

+ (NSInteger)trySelectGoodPosFromArr:(NSMutableArray<NumInt *> *)arr hh:(Matrix *)hh type:(NSInteger)type shift:(NSInteger)shift j:(NSInteger)j {
    NSInteger s = PathAlg.alg.s;

    for (NSInteger ii = 0; ii < arr.count; ii++) {
        NSInteger i = arr[ii].intValue;
        if (!hh.rows[i][j].isZero) continue;

        if (type == 1 || type == 2) { if (i == j) return ii; }

        if (type == 3)
        {
            if (shift == 1 && j < 5*s) return ii;
            if (shift == 3 && j >= s && j < 2*s) return ii;
            if (shift == 3 && i >= s) return ii;
            if (shift == 4 && j >= 5*s && i >= 2*s) return ii;
            if (shift == 5 && j < s && i >= 2*s) return ii;
            if (shift == 5 && j >= 7*s && i >= 3*s) return ii;
            if (shift == 6 && j >= 2*s && j < 5*s) return ii;
            if (shift == 6 && j >= 5*s && j < 7*s && i >= s) return ii;
            if (shift == 6 && j >= 7*s && i >= 4*s) return ii;
            if (shift == 7 && j < 2*s) return ii;
            if (shift == 7 && j >= 5*s && i >= 4*s && i < 5*s) return ii;
            if (shift == 8 && j >= s && i >= s) return ii;
            if (shift == 10 && j < s && i >= s) return ii;
            if (shift == 10 && j >= 5*s && i >= 5*s) return ii;
        }

        /*if (type == 4)
        {
            if (shift == 1 && j < s && i >= s) return ii;
            if (shift == 1 && j >= 4*s && j < 5 * s && i >= 2 * s) return ii;
            if (shift == 2 && i >= s) return ii;
            if (shift == 4 && j < s && i >= 2 * s) return ii;
            if (shift == 6 && j >= 6 * s && i >= 2 * s) return ii;
            if (shift == 8 && j >= 5 * s) return ii;
            if (shift == 10 && j >= 5 * s && i >= s) return ii;
            if (shift == 10 && j < s && i != j) return ii;
        }

        if (type == 5)
        {
            if (shift == 4 && i >= s) return ii;
            if (shift == 5) return ii;
        }

        if (type == 6)
        {
            if (shift == 1) return ii;
            if (shift == 4 && j < s) return ii;
            if (shift == 4 && j >= 2*s) return ii;
            if (shift == 4 && j >= s && j < 2*s && i >= s) return ii;
            if (shift == 5 && i >= s) return ii;
            if (shift == 6) return ii;
            if (shift == 7 && i >= s) return ii;
            if (shift == 10 && j >= 5*s && i >= s) return ii;
            if (shift == 10 && j >=s && j < 5*s) return ii;
            if (shift == 10 && j < s && i != j + 2*s) return ii;
        }
        if (type == 12)
        {
            if (shift == 4 && j < s && i != j) return ii;
            if (shift == 4 && j >= 5 * s && i >= 2*s) return ii;
        }
        if (type == 11)
        {
            if (shift == 4 && j < s && i >= 3*s) return ii;
            if (shift == 4 && j >= 5*s && i >= 4*s) return ii;
            if (shift == 6 && j < s && i >= 3*s) return ii;
        }
        if (type == 20)
        {
            if (shift == 4 && j < s && i >= 3*s) return ii;
        }
        if (type == 22)
        {
            if (shift == 3 && j < s) return ii;
            if (shift == 4 && j < 2*s && i >= 2*s) return ii;
            if (shift == 4 && j >= 6*s && i >= 2*s) return ii;
            if (shift == 7 && j < s && i >= 3*s) return ii;
            if (shift == 7 && j >= 7*s && j < 8*s && i >= s) return ii;
            if (shift == 7 && j >= 8*s && (i >= 7*s || i < 2*s)) return ii;
        }*/
    }

    return -1;
}

@end
