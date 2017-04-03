//
//  Created by M on 08.03.16.
//
//

#import "ShiftHHAlgAll.h"
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

@implementation ShiftHHAlgAll

+ (ShiftAllVariants *)allVariantsForHHElem:(HHElem *)hh degree:(NSInteger)degree shift:(NSInteger)shift
{
    Matrix *multRes = [[Matrix alloc] initWithMult:hh and:[[Diff alloc] initWithDeg:degree + shift - 1]];

    if (multRes.isNil) {
        WriteLog(1, "Bad multRes size");
        return nil;
    }

    NSInteger s = PathAlg.alg.s;
    NSInteger width = multRes.width;
    Diff *d_down = [[Diff alloc] initWithDeg:shift - 1];
    NSInteger height = d_down.rows.firstObject.count;

    NSMutableArray<NSMutableArray<ShiftVariant *> *> *allVariants = [NSMutableArray new];
    for (NSInteger col = 0; col < width; col += s) {
        NSMutableArray<ShiftVariant *> *variants = [NSMutableArray new];
        Matrix *multRes2 = [multRes submatrixFromCol:col toCol:col + s];
        [self shiftForMultRes:multRes2 dDown:d_down result:variants];
        if (variants.count == 0) return nil;
        [allVariants addObject:variants];
    }

    for (NSMutableArray<ShiftVariant *> *variant in allVariants) {
        WriteLog(4, "Count %tu ", variant.count);
    }
    WriteLog(0, "");

    return [[ShiftAllVariants alloc] initWithVariants:allVariants];
}

+ (NSString *)pathForAllVariantsWithType:(NSInteger)type
                                  degree:(NSInteger)degree
                                   shift:(NSInteger)shift
{
    return [OutputFile.fileName stringByAppendingFormat:@"type%zd_deg%zd_sh%zd.txt", type, degree, shift];
}

+ (HHElem *)selectFromAllVariants:(ShiftAllVariants *)allVariants type:(NSInteger)type shift:(NSInteger)shift
{
    NSInteger s = PathAlg.alg.s;
    NSInteger width = allVariants.variants.count * s;
    NSInteger height = allVariants.variants.lastObject.lastObject.hh.height;
    HHElem *hh_shift = [[HHElem alloc] initWithZeroMatrix:width h:height];

    NSInteger col = 0;
    for (NSArray<ShiftVariant *> *variants in allVariants.variants) {
        if (type == 3 && shift % 11 == 10 && (col >= 5 * s || col < s)) {
            [hh_shift addMatrixX:variants.lastObject.hh x:col];
        }
        else if (type == 3 && shift % 11 == 8) {
            ShiftVariant *minVar = variants[0];
            for (ShiftVariant *v in variants) {
                if (v.nonZeroCnt < minVar.nonZeroCnt) minVar = v;
            }
            [hh_shift addMatrixX:minVar.hh x:col];
        }
        else if (type == 4 && shift % 11 == 6) {
            [hh_shift addMatrixX:variants.lastObject.hh x:col];
        }
        else {
            ShiftVariant *minVar = variants[0];
            for (ShiftVariant *v in variants) {
                if (!v.hh.isZero) {
                    for (NSInteger i = 0; i < height; i++) {
                        for (NSInteger j = 0; j < s; j++) {
                            if (!v.hh.rows[i][j].isZero) {
                                hh_shift.rows[i][col+j].isPotential = YES;
                            }
                        }
                    }
                }
                //if (v.nonZeroCnt < minVar.nonZeroCnt)
                //    minVar = v;
            }
            [hh_shift addMatrixX:minVar.hh x:col];
        }
        col += s;
    }
    return hh_shift;
}

+ (void)shiftForMultRes:(Matrix *)multRes dDown:(Diff *)dDown result:(NSMutableArray<ShiftVariant *> *)result
{
    NSInteger multResW = (NSInteger)multRes.width;

    BOOL hasNonZeroElements = NO;
    for (NSInteger i = 0; i < multRes.height; i++) {
        for (NSInteger j = 0; j < multResW; j++) { // j th column
            if (multRes.rows[i][j].isZero) continue;
            hasNonZeroElements = YES;
        }
    }

    NSInteger s = PathAlg.alg.s;
    NSInteger height = dDown.rows.firstObject.count;

    if (!hasNonZeroElements) {
        HHElem *hh = [[HHElem alloc] init];
        [hh makeZeroMatrix:multResW h:height];
        [result addObject:[[ShiftVariant alloc] initWithHH:hh key:nil]];
        return;
    }

    NSInteger rowMask = twoDeg(height / s);

    for (NSInteger r = 1; r < rowMask; r++) {
        HHElem *hhElem = [[HHElem alloc] init];

        NSInteger nDiff = [self shiftForRowMask:r multRes:multRes dDown:dDown result:hhElem];

        if (nDiff == 0) {
            BOOL hasHH = NO;
            for (ShiftVariant *v in result) {
                if ([v.hh isEq:hhElem debug:NO]) {
                    if (v.key.intValue > r)
                        v.key.intValue = (int)r;
                    hasHH = YES;
                    break;
                }
            }
            if (!hasHH) {
                [result addObject:[[ShiftVariant alloc] initWithHH:hhElem key:[NumInt numWithInt:(NSInteger)r]]];
            }
        }
    }
}

+ (NSInteger)shiftForRowMask:(NSInteger)rowMask
                     multRes:(Matrix *)multRes
                       dDown:(Diff *)dDown
                      result:(HHElem *)hh_shift
{
    NSInteger s = PathAlg.alg.s;
    NSInteger width = multRes.width;
    NSInteger height = dDown.width;

    Matrix *multRes_shift = [[Matrix alloc] initWithZeroMatrix:width h:multRes.height];
    [hh_shift makeZeroMatrix:width h:height];

    NSInteger nDifferents = [multRes numberOfDifferents:multRes_shift];

    NSInteger step = 0;
    while (nDifferents > 0) {
        [multRes_shift subtractMatrix:multRes];

        Matrix *hh_sub = [[Matrix alloc] initWithZeroMatrix:width h:height];

        NSMutableSet<NumInt *> *cols = [NSMutableSet new];

        for (NSInteger i = 0; i < multRes_shift.height; i++) {
            for (NSInteger j = 0; j < multRes_shift.rows[i].count; j++) { // j th column
                if (multRes_shift.rows[i][j].isZero) continue;

                NSInteger goodPos = -1;

                for (NSInteger k = 0; k < dDown.rows[i].count; k++) {
                    if (dDown.rows[i][k].isZero || !hh_shift.rows[k][j].isZero) {
                        continue;
                    }
                    NSInteger k0 = k / s;
                    k0 = 1 << k0;
                    if ((rowMask & k0) == 0)
                        continue;

                    Tenzor *div = [[Tenzor alloc] initByDivide:multRes_shift.rows[i][j].firstTenzor to:dDown.rows[i][k].firstTenzor];

                    if (!div.isZero) {
                        goodPos = k;
                        break;
                    }
                }
                // end: find good positions in i th line of d_down
                if (goodPos < 0) continue;

                float koef = 1.0;
                Tenzor *tt;

                tt = [[Tenzor alloc] initByDivide:multRes_shift.rows[i][j].firstTenzor to:dDown.rows[i][goodPos].firstTenzor];
                koef *= multRes_shift.rows[i][j].firstKoef / dDown.rows[i][goodPos].firstKoef;

                if (tt.isZero) continue;

                if (![cols containsObject:[NumInt numWithInt:j]]) {
                    Comb *c = [[Comb alloc] initWithTenzor:tt koef:koef];
                    [hh_sub.rows[goodPos][j] addComb:c];
                    [cols addObject:[NumInt numWithInt:j]];
                }
            }
        }
        [hh_shift addMatrix:hh_sub];

        multRes_shift = [[Matrix alloc] initWithMult:dDown and:hh_shift];
        nDifferents = [multRes numberOfDifferents:multRes_shift];

        if (step > 5) break;
        
        ++step;
    }
    
    return nDifferents;
}

@end
