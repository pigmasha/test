@class Diff;

void createDiffWithNumber(Diff *diff, NSInteger degree);

void addTenToPos(Diff *diff,NSInteger i,NSInteger j, NSInteger leftFrom, NSInteger leftTo, NSInteger rightFrom, NSInteger rightTo, NSInteger koef);
void addTenToPosNoZero(Diff *diff,NSInteger i,NSInteger j, NSInteger leftFrom, NSInteger leftTo, BOOL leftNoZero,
                       NSInteger rightFrom, NSInteger rightTo, BOOL rightNoZero, NSInteger koef);
void addTenToPosLen(Diff *diff, NSInteger i, NSInteger j, NSInteger leftTo, NSInteger leftLen, NSInteger rightFrom, NSInteger rightLen, NSInteger koef);
