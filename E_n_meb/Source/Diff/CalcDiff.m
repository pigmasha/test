#import "CalcDiff.h"
#import "BimodQ.h"
#import "Utils.h"
#import "DiffLen.h"

int createZeroDiff(Diff *diff, BimodQ *qFrom, BimodQ *qTo);

#define ON_ERROR(__err) { \
    [PrintUtils printMatrixDeg:diff :deg + 1 :deg]; \
    WriteLog(2, "check diff"); \
    [PrintUtils printMatrixDeg:checkDiff :deg + 1 :deg]; \
    return __err; \
}

//---------------------------------------------------------------------------------
int calcDiffWithNumber(Diff *diff, NSInteger deg, Diff *prevDiff) {
    WriteLog(4, "deg=%d ", deg);

    NSInteger s = PathAlg.s;

    NSInteger d = deg % PathAlg.twistPeriod;

    BimodQ *qFrom = [[BimodQ alloc] initForDeg:d + 1];
    BimodQ *qTo   = [[BimodQ alloc] initForDeg:d];
    
    Diff *checkDiff = [[Diff alloc] initWithZeroMatrix:(NSInteger)qFrom.pij.count h:(NSInteger)qTo.pij.count];
    
    NSInteger col = 0;
    NSInteger row = 0;
    for (NSInteger nSq = 0; nSq < qFrom.sizes.count; nSq++) {
        bool sq1 = false;
        for (NSInteger i = 0; i < qTo.sizes[nSq].intValue; i++) {
            for (NSInteger j = 0; j < qFrom.sizes[nSq].intValue; j++) {
                for (NSInteger k = 0; k < s; k++) {
                    NSInteger ii = row + i * s + k;
                    NSInteger jj = col + j * s + k;

                    NSInteger fromSz = qFrom.sizes[nSq].intValue;
                    NSInteger toSz   = qTo.sizes[nSq].intValue;
                    
                    Way *wL = [[Way alloc] initFrom:qTo.pij[ii].n0 to:qFrom.pij[jj].n0 noZeroLen: YES];
                    Way *wR = [[Way alloc] initFrom:qFrom.pij[jj].n1 to:qTo.pij[ii].n1];
                    
                    if (fromSz == 2 && toSz == 2) {
                        if (i == 0 && j == 0) {
                            if ([wL isZero]) {
                                return 1;
                            }
                            sq1 = ([wL len] == 1);
                        }
                        if (j == 1 && ((i == 1 && sq1) || (i == 0 && !sq1))) {
                            checkDiff.rows[ii][jj].isOnlyZero = YES;
                            continue;
                        }
                    }

                    if ([wL isZero] || [wR isZero]) {
                        WriteLog(2, "deg=%d, row %d, col %d, fromSz %d, toSz %d", deg, ii, jj, fromSz, toSz);
                        [PrintUtils printMatrixDeg:checkDiff :deg + 1 :deg];
                        return 1;
                    }
                    Tenzor *t = [[Tenzor alloc] initWithLeft:wL right:wR];
                    Comb *c = [[Comb alloc] initWithTenzor: t koef: 1];
                    
                    if (toSz == 2 && fromSz == 1 && i == 1 && [wL len] < 3) [c compKoef: -1];
                    if (toSz == 2 && fromSz == 2 && i == 1 && j == 0) [c compKoef: -1];
                    
                    [checkDiff.rows[ii][jj] addComb:c];
                }
            }
        }
        col += s * [[qFrom sizes][nSq] intValue];
        row += s * [[qTo sizes][nSq] intValue];
    }

    if (deg == 0) {
        NSInteger res = createZeroDiff(checkDiff, qFrom, qTo);
        if (res) ON_ERROR((int)res);
    } else {
        Diff *multRes = [[Diff alloc] initWithMult:prevDiff and: diff];
        BOOL isZero = [multRes isZero];
        if (!isZero) ON_ERROR(9);
    }

    [checkDiff twist:deg type:1];

    if (checkDiff.height != [[diff rows] count]) ON_ERROR(10);
    if (checkDiff.width != [[[diff rows] lastObject] count]) ON_ERROR(11);

    for (NSInteger i = 0; i < checkDiff.height; i++) {
        for (NSInteger j = 0; j < checkDiff.width; j++) {
            Comb *c1 = checkDiff.rows[i][j];
            Comb *c2 = diff.rows[i][j];
            if (c1.isOnlyZero && !c2.isZero) ON_ERROR(12);
            if (c1.isZero) continue;

            if (![c2 hasSummand:c1]) {
                WriteLog(4, "i=%d,j=%d", i, j);
                ON_ERROR(13);
            }
        }
    }
    WriteLog(0, "OK!");
    return 0;
}

//---------------------------------------------------------------------------------
int createZeroDiff(Diff *diff, BimodQ *qFrom, BimodQ *qTo) {
    for (NSInteger i = 0; i < [qTo.pij count]; i++) {
        for (NSInteger j = 0; j < [qFrom.pij count]; j++) {
            Comb *c1 = diff.rows[i][j];
            if (!c1.isZero) continue;

            Way *wL = [[Way alloc] initFrom:qTo.pij[i].n0 to:qFrom.pij[j].n0];
            Way *wR = [[Way alloc] initFrom:qFrom.pij[j].n1 to:qTo.pij[i].n1];
            
            if (!wL.isZero && !wR.isZero) {
                if (wL.len + wR.len != 1) {
                    return 1;
                }
                Tenzor *t = [[Tenzor alloc] initWithLeft:wL right:wR];
                [c1 addComb:[[Comb alloc] initWithTenzor:t koef:-1]];
            }
        }
    }
    for (NSInteger j = 0; j < [qFrom.pij count]; j++) {
        BOOL hasPos = NO;
        BOOL hasNeg = NO;
        for (NSInteger i = 0; i < [qTo.pij count]; i++) {
            Comb *c1 = [diff rows][i][j];
            if (c1.isZero) continue;
            
            float k = [c1 firstKoef];
            if (k > 0) {
                if (hasPos) return 2;
                hasPos = YES;
            }
            if (k < 0) {
                if (hasNeg) return 3;
                hasNeg = YES;
            }
            if (!k) return 4;
        }
        if (!hasPos) return 5;
        if (!hasNeg) return 6;
    }

    return 0;
}

//---------------------------------------------------------------------------------
// return error code
//---------------------------------------------------------------------------------
int checkDiffLen(Diff *diff, NSInteger deg) {
    DiffLen* lens = [[DiffLen alloc] initWithDeg:deg];
    
    if (![[lens items] count]) return 0;
    NSArray* items = [lens items];
    NSArray<NSArray<Comb *> *>* rows = [diff rows];
    if ([items count] != [rows count]) return 1;
    if ([[items lastObject] count] != [rows.lastObject count]) return 2;
    
    for (NSInteger i = 0; i < rows.count; i++) {
        for (NSInteger j = 0; j < [rows.lastObject count]; j++) {
            Comb *c = rows[i][j];
            IntPair *n = items[i][j];
            if ([c isZero]) {
                if (n.n0 || n.n1) return 3;
            } else {
                TenzorPair *p = [[c content] lastObject];
                Tenzor *t = [p tenzor];
                if ([t.leftComponent len] != [n n0]) {
                    NSLog(@"deg=%zd:(%zd, %zd): left %zd != %zd - my", deg, i, j, [[t leftComponent] len], [n n0]);
                    return 4;
                }
                if ([t.rightComponent len] != [n n1]) {
                    NSLog(@"deg=%zd:(%zd, %zd): right %zd != %zd - my", deg, i, j, [[t rightComponent] len], [n n1]);
                    return 5;
                }
            }
        }
    }
    
    return 0;
}
