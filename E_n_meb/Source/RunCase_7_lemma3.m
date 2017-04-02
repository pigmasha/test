#ifdef MAIN_LEMMA_3

#import "PathAlg.alg.h"
#import "KoefMatrix.h"
#import "PrintUtils.h"
#import "Utils.h"

void CreateMatrix3(KoefIntMatrix *matrix);
int RankLemma3(KoefIntMatrix *matrix);

//---------------------------------------------------------------------------------
BOOL _RunCase() {
    NSInteger n = PathAlg.alg.n;
    NSInteger s = PathAlg.alg.s;

    WriteLog(0, "N=%d, S=%d, char=%d",  n, s, PathAlg.alg.charK);

    for (NSInteger i = 0; i < 2 * PathAlg.alg.twistPeriod; i++) {
        KoefIntMatrix *matrix = [[KoefIntMatrix alloc] initWithSize:s];
        CreateMatrix3(matrix);

        NSInteger rk2 = RankLemma3(matrix);

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
void CreateMatrix3(KoefIntMatrix *matrix) {
    NSInteger s = PathAlg.alg.s;

    for (NSInteger i = 0; i < s; i++) {
        NumInt* n = matrix.rows[i][i];
        [n setIntValue:(rand() % 2) ? 1 : -1];
        n = matrix.rows[[PathAlg myModS:i + 1)][i];
        [n setIntValue:(rand() % 2) ? 1 : -1];
    }
    for (NSInteger i = 0; i < s - 1; i++) {
        NumInt* n = matrix.rows[[PathAlg myModS:i + 2)][i];
        NumInt* n1 = matrix.rows[[PathAlg myModS:i + 1)][i];
        NumInt* n2 = matrix.rows[i + 1][i + 1];
        NumInt* n3 = matrix.rows[[PathAlg myModS:i + 2)][i + 1];
        [n setIntValue:n.intValue + n1.intValue * n2.intValue * n3.intValue];
    }
    for (NSInteger i = s - 1; i < s; i++) {
        NumInt* n = matrix.rows[[PathAlg myModS:i + 2)]][i];
        [n setIntValue:n.intValue + (rand() % 2) ? 1 : -1];
    }
}

//---------------------------------------------------------------------------------
int RankLemma3(KoefIntMatrix *matrix) {
    NSInteger charK = PathAlg.alg.charK;
    NSInteger n = (NSInteger)matrix.rows.count;

    if (charK == 2) {
        return (n % 3 == 0) ? n - 2 : n;
    }

    NSInteger k = 1;
    for (NSInteger i = 0; i < n; i++) {
        NumInt* n1 = matrix.rows[i][i];
        k *= n1.intValue;
        n1 = matrix.rows[[PathAlg myMod:i + 1 mod: n]][i];
        k *= n1.intValue;
    }

    NumInt* n1 = matrix.rows[[PathAlg myMod:n + 1 mod: n]][n - 1];
    NSInteger g = n1.intValue;
    n1 = matrix.rows[0][0];
    g *= n1.intValue;
    n1 = matrix.rows[1][0];
    g *= n1.intValue;
    n1 = matrix.rows[0][n - 1];
    g *= n1.intValue;

    if (charK) {
        k = MYMOD(k, charK);
        if (k > 1) k -= charK;
        g = MYMOD(g, charK);
        if (g > 1) g -= charK;
    }

    if (n % 3 == 0) {
        if (k == 1) return (g == 1) ? n - 2 : n - 1;
        return (g == -1) ? n - 1 : n;
    }
    return (charK == 3 && k == 1 && g == 1) ? n - 1 : n;
}

#endif
