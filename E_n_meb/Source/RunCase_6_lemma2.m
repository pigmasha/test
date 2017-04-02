#ifdef MAIN_LEMMA_2

#import "PathAlg.alg.h"
#import "KoefMatrix.h"
#import "PrintUtils.h"
#import "Utils.h"

void CreateMatrix2(KoefIntMatrix *matrix);
int RankLemma2(KoefIntMatrix *matrix);

//---------------------------------------------------------------------------------
BOOL _RunCase() {
    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;

    WriteLog(0, "N=%d, S=%d, char=%d",  n, s, PathAlg.alg.charK);

    for (NSInteger i = 0; i < 2 * PathAlg.alg.twistPeriod; i++) {
        KoefIntMatrix *matrix = [[KoefIntMatrix alloc] initWithSize:s];
        CreateMatrix2(matrix);

        NSInteger rk2 = RankLemma2(matrix);

        NSInteger rk1 = [matrix rank];

        if (rk2 && rk1 != rk2) {
            WriteLog(1, "%d (must be %d)! N=%d, S=%d, char=%d, matrix:", rk2, rk1, n, s, [PathAlg.alg charK]);
            printKoefIntMatrix(matrix, 0, 0);
        }

        [matrix release];
    }
    return NO;
}

//---------------------------------------------------------------------------------
void CreateMatrix2(KoefIntMatrix *matrix) {
    NSInteger s = PathAlg.alg.s;

    for (NSInteger i = 0; i < s; i++) {
        NumInt* n = matrix.rows[i][i];
        [n setIntValue:(rand() % 2) ? 1 : -1];
        n = matrix.rows[[PathAlg myModS:i + 1)][i];
        [n setIntValue:(rand() % 2) ? 1 : -1];
    }
}

//---------------------------------------------------------------------------------
int RankLemma2(KoefIntMatrix *matrix) {
    NSInteger charK = PathAlg.alg.charK;
    NSInteger n = (NSInteger)matrix.rows.count;

    if (charK == 2)
        return n - 1;

    NSInteger k = 1;
    for (NSInteger i = 0; i < n; i++) {
        NumInt* n1 = matrix.rows[i][i];
        k *= n1.intValue;
        n1 = matrix.rows[[PathAlg myMod:i + 1 mod: n]][i];
        k *= n1.intValue;
    }

    return (k == minusDeg(n)) ? n - 1 : n;
}

#endif
