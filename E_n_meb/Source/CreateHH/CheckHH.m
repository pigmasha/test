//
//  CheckHH.m
//  E_n_meb
//
//  Created by M on 26.11.15.
//
//

#import "CheckHH.h"
#import "BimodQ.h"
#import "ImMatrix.h"
#import "KoefMatrix.h"
#import "Utils.h"

@implementation CheckHH

+ (BOOL)checkHHElem:(HHElem *)hh degree:(NSInteger)degree
{
    BimodQ *qFrom = [[BimodQ alloc] initForDeg:degree];
    BimodQ *qTo   = [[BimodQ alloc] initForDeg:0];

    if (hh.height != qTo.pij.count) {
        WriteLog(1, "CheckHHElem error! Wrong number of rows");
        return NO;
    }
    if (hh.width != qFrom.pij.count) {
        WriteLog(1, "CheckHHElem error! Wrong number of columns");
        return NO;
    }

    for (NSInteger i = 0; i < hh.height; i++) {
        for (NSInteger j = 0; j < hh.width; j++) {
            if (hh.rows[i][j].isZero) continue;

            Tenzor *t = hh.rows[i][j].content.firstObject.tenzor;
            Vertex *v1 = [[Vertex alloc] initWithI:qFrom.pij[j].n0];

            if (![t.leftComponent.endsWith isEq:v1]) {
                WriteLog(1, "CheckHHElem error! Bad way at pos %d, %d (left ends in %d, must be %d), Diff:",
                         i, j, t.leftComponent.endsWith.number, v1.number);
                Diff *diff = [[Diff alloc] initWithDeg:degree];
                [PrintUtils printMatrixDeg:@"" :diff :degree :degree - 1];
                return NO;
            }

            Vertex *v2 = [[Vertex alloc] initWithI:qTo.pij[i].n0];

            if (![t.leftComponent.startsWith isEq:v2]) {
                WriteLog(1, "CheckHHElem error! Bad way at pos %d, %d (left starts in %d, must be %d), Diff:",
                         i, j, t.leftComponent.startsWith.number, v2.number);
                Diff *diff = [[Diff alloc] initWithDeg:degree];
                [PrintUtils printMatrixDeg:@"" :diff :degree :degree - 1];
                return NO;
            }

            if (![t.rightComponent.startsWith isEq:v2]) {
                WriteLog(1, "CheckHHElem error! Bad way at pos %d, %d (right starts in %d, must be %d), Diff:",
                         i, j, t.rightComponent.startsWith.number, v2.number);
                Diff *diff = [[Diff alloc] initWithDeg:degree];
                [PrintUtils printMatrixDeg:@"" :diff :degree :degree - 1];
                return NO;
            }
        }
    }

    if (![self checkForKer:hh degree:degree]) {
        WriteLog(1, "CheckHHForKer error!");
        return NO;
    }
    if (![self checkForIm:hh degree:degree]) {
        WriteLog(1, "CheckHHForIm error!");
        return NO;
    }

    return YES;
}

+ (BOOL)checkForKer:(HHElem *)hh degree:(NSInteger)degree
{
    Diff *diff = [[Diff alloc] initWithDeg:degree];
    Matrix *multResult = [[Matrix alloc] initWithMult:hh and:diff];
    if (multResult.isZero) {
        return NO;
    }

    NSInteger charK = PathAlg.charK;

    for (NSInteger i = 0; i < multResult.width; i++) {
        float totalKoef = 0;
        Way *columnWay = nil;
        for (NSInteger j = 0; j < multResult.height; j++) {
            Comb *c = multResult.rows[j][i];

            for (TenzorPair *p in c.content) {
                if (!p.koef) continue;
                if (p.tenzor.isZero) continue;

                Way *w = [[Way alloc] initWithWay:p.tenzor.leftComponent];
                Way *wR = [[Way alloc] initFrom:p.tenzor.leftComponent.startsWith.number
                                                 to:p.tenzor.rightComponent.endsWith.number];
                [w compRight:wR];
                [w compRight:p.tenzor.rightComponent];
                if (!w.isZero && !columnWay) {
                    columnWay = [[Way alloc] initWithWay:w];
                }

                if (!w.isZero && ![columnWay isEq:w]) {
                    WriteLog(1, "CheckHHForKer error: various ways (%s and %s) in column %d!", w.htmlStr, columnWay.htmlStr, i);
                    return NO;
                }
                if (!w.isZero) totalKoef += p.koef;
            }
        }

        if ((charK > 0 && ((NSInteger)totalKoef % charK)) || (charK == 0 && totalKoef != 0)) {
            [PrintUtils printMatrix:@"HH" :hh];
            WriteLog(1, "Im");
            ImMatrix *im = [[ImMatrix alloc] initWithDiff:diff];
            [PrintUtils printIm:im deg:degree - 1];
            WriteLog(1, "Error in %d column", i);

            return NO;
        }
    }
    return YES;
}

+ (BOOL)checkForIm:(HHElem *)hh degree:(NSInteger)degree
{
    if (degree == 0) return YES;

    NSInteger s = PathAlg.s;

    Diff *diff = [[Diff alloc] initWithDeg:degree - 1];
    ImMatrix *im = [[ImMatrix alloc] initWithDiff:diff];

    // create line with koefficients
    NSMutableArray<WayPair *> *hhElem = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < hh.width; i++) {
        NSInteger j = 0;
        while (j < hh.height) {
            if (!hh.rows[j][i].isZero) break;
            ++j;
        }
        if (j == hh.height) {
            [hhElem addObject:[WayPair pairWithWay:nil koef:0]];
            continue;
        }

        Tenzor *tt = hh.rows[j][i].content.firstObject.tenzor;
        NSInteger hhKoef = (NSInteger)hh.rows[j][i].content.firstObject.koef;

        Way *w = [[Way alloc] initWithWay:tt.leftComponent];
        Way *wR = [[Way alloc] initFrom:tt.leftComponent.startsWith.number to:tt.rightComponent.endsWith.number];
        [w compRight:wR];
        [w compRight:tt.rightComponent];

        j = 0;
        while (j < im.rows.count && (im.rows[j][i].way.isZero || im.rows[j][i].koef == 0))
            j++;

        if (j < im.rows.count) {
            Way* ww = im.rows[j][i].way;

            NSInteger koef = (NSInteger) (hhKoef * ([ww isEq:w] ? 1 : 0));

            [hhElem addObject:[WayPair pairWithWay:ww koef:koef]];

            if (s == 1 && ww.len == 4 && w.len == 0) {
                return YES;
            }
        } else {
            [hhElem addObject:[WayPair pairWithWay:w koef:hhKoef]];
        }
    }

    KoefIntMatrix *k = [[KoefIntMatrix alloc] initWithIm:im];
    NSInteger dimIm = [k rank];

    [im addRow:hhElem];

    if (im.rows.count == 0) {
        WriteLog(1, "Error: bad row size %tu", hhElem.count);
        return NO;
    }

    k = [[KoefIntMatrix alloc] initWithIm:im];
    NSInteger dimImAdd = [k rank];

    if (dimImAdd == dimIm) {
        WriteLog(0, "Im");
        [PrintUtils printIm:im deg:degree - 1];
        WriteLog(0, "dim=%d", dimImAdd);
    }

    return (dimImAdd > dimIm);
}

@end
