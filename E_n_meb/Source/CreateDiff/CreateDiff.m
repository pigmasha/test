#import "CreateDiff.h"
#import "CreateDiffEven.h"
#import "CreateDiffOdd.h"
#import "BimodQ.h"
#import "Utils.h"

//----------------------------------------------------------------------------
void createDiffWithNumber(Diff *diff, NSInteger degree) {
    NSInteger r = (degree % PathAlg.twistPeriod);
    NSInteger m = (NSInteger)(r / 2);

    if (r % 2 == 0) {
        createEvenDiffWithNumber(diff, m);
    } else {
        createOddDiffWithNumber(diff, m);
    }

    NSInteger l = (NSInteger)(degree / PathAlg.twistPeriod);

    NSArray* rows = [diff rows];
    for (NSInteger i = 0; i < l; i++)
    {
        for (NSInteger i = 0; i < [rows count]; ++i)
            for (NSInteger j = 0; j < [[rows lastObject] count]; ++j)
                [[[rows objectAtIndex:i] objectAtIndex:j] twistWithBackward:NO];
    }
}

void addTenToPos(Diff *diff, NSInteger i, NSInteger j, NSInteger leftFrom, NSInteger leftTo, NSInteger rightFrom, NSInteger rightTo, NSInteger koef) {
    addTenToPosNoZero(diff, i, j, leftFrom, leftTo, NO, rightFrom, rightTo, NO, koef);
}

//----------------------------------------------------------------------------
void addTenToPosNoZero(Diff *diff, NSInteger i, NSInteger j, NSInteger leftFrom, NSInteger leftTo, BOOL leftNoZero,
                 NSInteger rightFrom, NSInteger rightTo, BOOL rightNoZero, NSInteger koef) {
    Way *wL = [[Way alloc] initFrom:leftFrom to:leftTo noZeroLen:leftNoZero];
    Way *wR = [[Way alloc] initFrom:rightFrom to:rightTo noZeroLen:rightNoZero];
    
    if ([wL isZero] || [wR isZero]) {
        return;
    }
    Tenzor *t = [[Tenzor alloc] initWithLeft:wL right:wR];
    Comb *c = [[Comb alloc] initWithTenzor:t koef:koef];

    [diff.rows[i][j] addComb:c];
}

//----------------------------------------------------------------------------
void addTenToPosLen(Diff *diff, NSInteger i, NSInteger j, NSInteger leftTo, NSInteger leftLen, NSInteger rightFrom, NSInteger rightLen, NSInteger koef) {
    Way *wL = [[Way alloc] initTo:leftTo len: leftLen];
    Way *wR = [[Way alloc] initFrom: rightFrom len: rightLen];
    
    if ([wL isZero] || [wR isZero]) {
        return;
    }
    Tenzor *t = [[Tenzor alloc] initWithLeft:wL right:wR];
    Comb *c = [[Comb alloc] initWithTenzor:t koef:koef];
    
    [diff.rows[i][j] addComb:c];
}
