#import "CreateHH.h"
#import "BimodQ.h"
#import "Utils.h"


@implementation CreateHH

void CreateHHVecWithNumber(NSMutableArray<WayPair *> *vec, NSInteger degree, NSInteger type);

+ (void)createHHElem:(HHElem *)hh degree:(NSInteger)degree type:(NSInteger)type {
    switch (type) {
        case 1: [self createHHElem1:hh degree:degree]; return;
        case 2: [self createHHElem2:hh degree:degree]; return;
        case 3: [self createHHElem3:hh degree:degree]; return;
        case 4: [self createHHElem4:hh degree:degree]; return;
        case 5: [self createHHElem5:hh degree:degree]; return;
        case 6: [self createHHElem6:hh degree:degree]; return;
        case 7: [self createHHElem7:hh degree:degree]; return;
        case 8: [self createHHElem8:hh degree:degree]; return;
        case 9: [self createHHElem9:hh degree:degree]; return;
        case 10: [self createHHElem10:hh degree:degree]; return;
        case 11: [self createHHElem11:hh degree:degree]; return;
        case 12: [self createHHElem12:hh degree:degree]; return;
        case 13: [self createHHElem13:hh degree:degree]; return;
        case 14: [self createHHElem14:hh degree:degree]; return;
        case 15: [self createHHElem15:hh degree:degree]; return;
        case 16: [self createHHElem16:hh degree:degree]; return;
        case 17: [self createHHElem17:hh degree:degree]; return;
        case 18: [self createHHElem18:hh degree:degree]; return;
        case 19: [self createHHElem19:hh degree:degree]; return;
        case 20: [self createHHElem20:hh degree:degree]; return;
        case 21: [self createHHElem21:hh degree:degree]; return;
        case 22: [self createHHElem22:hh degree:degree]; return;
    }

    NSInteger s = PathAlg.s;

    NSMutableArray<WayPair *> *vec = [[NSMutableArray alloc] init];
    CreateHHVecWithNumber(vec, degree, type);

    BimodQ *qFrom = [[BimodQ alloc] initForDeg:degree];
    BimodQ *qTo   = [[BimodQ alloc] initForDeg:0];

    [hh makeZeroMatrix:(NSInteger)vec.count h: 6*s];

    NSInteger sumX = 0;
    NSInteger sumY = 0;
    for (NSInteger i = 0; i < qFrom.sizes.count; i++) {
        NSInteger szFrom = qFrom.sizes[i].intValue;
        NSInteger szTo   = qTo.sizes[i].intValue;

        for (NSInteger j = 0; j < szFrom * s; j++) {
            Way *wR = [[Way alloc] initFrom:vec[j+sumX].way.startsWith.number len:0];
            Tenzor *t = [[Tenzor alloc] initWithLeft:vec[j+sumX].way right:wR];
            Comb *c = [[Comb alloc] initWithTenzor:t koef:vec[j+sumX].koef];

            NSInteger i = (j < szTo * s) ? j : j - szTo * s;
            [hh.rows[i+sumY][j+sumX] addComb:c];
        }
        
        sumX += szFrom * s;
        sumY += szTo * s;
    }
}

//----------------------------------------------------------------------------
+ (void)createHHElem1:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 0;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:6*s h:6*s];

    for (NSInteger j = 0; j < s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*j leftTo:4*j right:4*j koef:[PathAlg k1J:ell j:j m:m]];

    for (NSInteger j = s; j < 3*s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*(j+s)+1 leftTo:4*(j+s)+1 right:4*(j+s)+1 koef:1];

    for (NSInteger j = 3*s; j < 5*s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*(j+s)+2 leftTo:4*(j+s)+2 right:4*(j+s)+2 koef:1];

    for (NSInteger j = 5*s; j < 6*s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*j+3 leftTo:4*j+3 right:4*j+3 koef:[PathAlg k1J:ell j:j m:m]];
}

//----------------------------------------------------------------------------
+ (void)createHHElem2:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:6*s h:6*s];
    [HHElem addElemToHH:hh i:0 j:0 leftFrom:0 leftTo:4 right:0 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem3:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:7*s h:6*s];
    [HHElem addElemToHH:hh i:0 j:0 leftFrom:0 leftTo:1 right:0 koef:1];
    [HHElem addElemToHH:hh i:0 j:s leftFrom:0 leftTo:4*s+1 right:0 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem4:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 0;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:7*s h:6*s];

    for (NSInteger j = 0; j < s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*j leftTo:4*(j+s)+1 right:4*j koef:1];

    for (NSInteger j = 5*s-1; j < 6*s-1; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+2 leftTo:4*j+3 right:4*j+2 koef:-[PathAlg k1J:ell j:j m:m]];
}

//----------------------------------------------------------------------------
+ (void)createHHElem5:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:6*s h:6*s];
    NSInteger j = 0;

    [HHElem addElemToHH:hh i:j j:j leftFrom:4*j leftTo:4*j+3 right:4*j koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem6:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 1;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:8*s h:6*s];

    for (NSInteger j = 0; j < s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*j leftTo:4*j+2 right:4*j koef:1];

    for (NSInteger j = 3*s; j < 4*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+1 leftTo:4*j+3 right:4*j+1 koef:-[PathAlg k1J:ell j:j m:m]];

    for (NSInteger j = 4*s; j < 5*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+2 leftTo:4*(j+1) right:4*j+2 koef:-[PathAlg k1JPlus1:ell j:j m:m]];

    for (NSInteger j = 6*s; j < 7*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+3 leftTo:4*(j+1)+1 right:4*j+3 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem7:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 1;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:8*s h:6*s];

    for (NSInteger j = 0; j < 2*s; j++)
        [HHElem addElemToHH:hh i:j%s j:j leftFrom:4*j leftTo:4*(j+s)+2 right:4*j koef:1];

    for (NSInteger j = 2*s; j < 4*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+1 leftTo:4*j+3 right:4*j+1 koef:1];

    for (NSInteger j = 4*s; j < 6*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+2 leftTo:4*(j+1) right:4*j+2 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem8:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 2;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:9*s h:6*s];

    for (NSInteger j = s; j < 2*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j leftTo:4*j right:4*j koef:[PathAlg k1J:ell j:j m:m]];

    for (NSInteger j = 2*s; j < 4*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+1 leftTo:4*j+1 right:4*j+1 koef:1];

    for (NSInteger j = 5*s; j < 6*s; j++)
        [HHElem addElemToHH:hh i:j-2*s j:j leftFrom:4*(j+s)+2 leftTo:4*(j+s)+2 right:4*(j+s)+2 koef:1];

    for (NSInteger j = 7*s; j < 8*s; j++)
        [HHElem addElemToHH:hh i:j-3*s j:j leftFrom:4*j+2 leftTo:4*j+2 right:4*j+2 koef:1];

    for (NSInteger j = 8*s; j < 9*s; j++)
        [HHElem addElemToHH:hh i:j-3*s j:j leftFrom:4*j+3 leftTo:4*j+3 right:4*j+3 koef:-[PathAlg k1J:ell j:j m:m]];
}

//----------------------------------------------------------------------------
+ (void)createHHElem9:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:9*s h:6*s];
    [HHElem addElemToHH:hh i:0 j:s leftFrom:0 leftTo:4 right:0 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem10:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:9*s h:6*s];
    [HHElem addElemToHH:hh i:0 j:0 leftFrom:0 leftTo:3 right:0 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem11:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 2;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:8*s h:6*s];

    for (NSInteger j = 0; j < 2*s; j++)
        [HHElem addElemToHH:hh i:j%s j:j leftFrom:4*j leftTo:4*j+1 right:4*j koef:1];

    for (NSInteger j = 2*s; j < 4*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+1 leftTo:4*(j+1) right:4*j+1 koef:[PathAlg k1JPlus1:ell j:j m:m]];

    for (NSInteger j = 4*s; j < 6*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+2 leftTo:4*j+3 right:4*j+2 koef:-[PathAlg k1J:ell j:j m:m]];
    
    for (NSInteger j = 6*s; j < 8*s; j++)
        [HHElem addElemToHH:hh i:5*s+j%s j:j leftFrom:4*j+3 leftTo:4*(j+1)+2 right:4*j+3 koef:f1(j, 7*s)];
}

//----------------------------------------------------------------------------
+ (void)createHHElem12:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:8*s h:6*s];
    [HHElem addElemToHH:hh i:0 j:0 leftFrom:0 leftTo:4*s+1 right:0 koef:1];
    [HHElem addElemToHH:hh i:0 j:s leftFrom:0 leftTo:1 right:0 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem13:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:9*s h:6*s];

    for (NSInteger j = s; j < 2*s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*(j+s)+1 leftTo:4*(j+s)+1 right:4*(j+s)+1 koef:1];

    for (NSInteger j = 3*s; j < 4*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+1 leftTo:4*j+1 right:4*j+1 koef:1];

    for (NSInteger j = 5*s; j < 7*s; j++)
        [HHElem addElemToHH:hh i:j-2*s j:j leftFrom:4*(j+s)+2 leftTo:4*(j+s)+2 right:4*(j+s)+2 koef:1];

    for (NSInteger j = 8*s; j < 9*s; j++)
        [HHElem addElemToHH:hh i:j-3*s j:j leftFrom:4*j+3 leftTo:4*(j+1) right:4*j+3 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem14:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 3;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:9*s h:6*s];

    for (NSInteger j = 0; j < s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*j leftTo:4*j right:4*j koef:[PathAlg k1J:ell j:j m:m]];

    for (NSInteger j = 2*s; j < 3*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+1 leftTo:4*j+2 right:4*j+1 koef:1];

    for (NSInteger j = 4*s; j < 5*s; j++)
        [HHElem addElemToHH:hh i:j-2*s j:j leftFrom:4*(j+s)+1 leftTo:4*(j+s)+2 right:4*(j+s)+1 koef:1];

    for (NSInteger j = 7*s; j < 8*s; j++)
        [HHElem addElemToHH:hh i:j-2*s j:j leftFrom:4*j+3 leftTo:4*j+3 right:4*j+3 koef:[PathAlg k1J:ell j:j m:m]];
}

//----------------------------------------------------------------------------
+ (void)createHHElem15:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:9*s h:6*s];
    [HHElem addElemToHH:hh i:0 j:0 leftFrom:0 leftTo:4 right:0 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem16:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:8*s h:6*s];
    [HHElem addElemToHH:hh i:0 j:0 leftFrom:0 leftTo:2 right:0 koef:1];
    [HHElem addElemToHH:hh i:s j:2*s leftFrom:1 leftTo:3 right:1 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem17:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:8*s h:6*s];
    [HHElem addElemToHH:hh i:0 j:0 leftFrom:0 leftTo:4*s+2 right:0 koef:1];
    [HHElem addElemToHH:hh i:0 j:s leftFrom:0 leftTo:2 right:0 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem18:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 4;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:6*s h: 6*s];

    for (NSInteger j = s; j < 3*s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*(j+s)+1 leftTo:4*(j+s)+2 right:4*(j+s)+1 koef:1];

    for (NSInteger j = 5*s; j < 6*s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*j+3 leftTo:4*(j+1) right:4*j+3 koef:-[PathAlg k1JPlus1:ell j:j m:m]];
}

//----------------------------------------------------------------------------
+ (void)createHHElem19:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 4;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:7*s h: 6*s];

    [HHElem addElemToHH:hh i:s j:s leftFrom:1 leftTo:4 right:1 koef:1];
    [HHElem addElemToHH:hh i:2*s j:2*s leftFrom:4*s+1 leftTo:4 right:4*s+1 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem20:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 4;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:7*s h:6*s];

    for (NSInteger j = 0; j < s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*j leftTo:4*j+3 right:4*j koef:[PathAlg k1J:ell j:j m:m]];

    for (NSInteger j = s; j < 2*s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*(j+s)+1 leftTo:4*(j+1) right:4*(j+s)+1 koef:-[PathAlg k1JPlus1:ell j:j m:m]];

    for (NSInteger j = 3*s; j < 4*s; j++)
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*(j+s)+2 leftTo:4*(j+s+1)+1 right:4*(j+s)+2 koef:1];

    for (NSInteger j = 6*s; j < 7*s; j++)
        [HHElem addElemToHH:hh i:j-s j:j leftFrom:4*j+3 leftTo:4*(j+1)+2 right:4*j+3 koef:1];
}

//----------------------------------------------------------------------------
+ (void)createHHElem21:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger m = 5;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:6*s h:6*s];

    NSInteger k = 1;
    for (NSInteger j = 0; j < s; j++) {
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*j leftTo:4*j right:4*j koef:minusDeg(j)*k];
        k *= [PathAlg sigmaDeg:ell i:j+m isGamma:YES];
    }

    k = 1;
    for (NSInteger j = 5*s; j < 6*s; j++) {
        [HHElem addElemToHH:hh i:j j:j leftFrom:4*j+3 leftTo:4*j+3 right:4*j+3 koef:minusDeg(j+1)*k];
        k *= [PathAlg sigmaDeg:ell i:j+m isGamma:YES];
    }
}

//----------------------------------------------------------------------------
+ (void)createHHElem22:(HHElem *)hh degree:(NSInteger)degree {
    NSInteger s = PathAlg.s;
    NSInteger ell = degree / PathAlg.twistPeriod;

    [hh makeZeroMatrix:6*s h:6*s];
    [HHElem addElemToHH:hh i:0 j:0 leftFrom:0 leftTo:4 right:0 koef:1];
}

//----------------------------------------------------------------------------
void addToHHVec(NSMutableArray<WayPair *> *vec, NSInteger from, NSInteger to, NSInteger k) {
    if (k == 0) {
        [vec addObject:[WayPair pairWithWay:nil koef:k]];
    } else {
        Way *w = [[Way alloc] initFrom:from to:to];
        [vec addObject:[WayPair pairWithWay:w koef:k]];
    }
}

void CreateHHVecWithNumber(NSMutableArray<WayPair *> *vec, NSInteger degree, NSInteger type) {
    NSInteger s = PathAlg.s;
    NSInteger m = (NSInteger)((degree % PathAlg.twistPeriod) / 2);
    NSInteger ell = degree / PathAlg.twistPeriod;

    switch (type) {
        case 1:
            for (NSInteger j = 0; j < s; j++)
                addToHHVec(vec, 4*j, 4*j, [PathAlg k1J:ell j:j m:m]);

            for (NSInteger j = s; j < 3*s; j++)
                addToHHVec(vec, 4*(j+s)+1, 4*(j+s)+1, 1);

            for (NSInteger j = 3*s; j < 5*s; j++)
                addToHHVec(vec, 4*(j+s)+2, 4*(j+s)+2, 1);

            for (NSInteger j = 5*s; j < 6*s; j++)
                addToHHVec(vec, 4*j+3, 4*j+3, [PathAlg k1J:ell j:j m:m]);
            break;
        case 2:
            addToHHVec(vec, 0, 4, 1);
            for (NSInteger j = 1; j < 6*s; j++) addToHHVec(vec, 0, 0, 0);
            break;
        default:
            break;
    }
}

@end
