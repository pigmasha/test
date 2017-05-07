#import "ImMatrix.h"
#import "BimodQ.h"
#import "KoefMatrix.h"

@class Matrix;
@class Diff;


void printMatrixDeg(Matrix *diff, NSInteger degFrom, NSInteger degTo);

void printImDeg(ImMatrix * matr, NSInteger deg);
void printImDegTr(ImMatrix * matr, NSInteger deg);
void printKoefMatrix(KoefMatrix * matrix);
void printKoefIntMatrix(KoefIntMatrix * matrix, NSInteger deg, NSInteger skipLines);

void printDiffByS(const Diff *diff, NSInteger degFrom, NSInteger degTo);
void printDiff1Row(const Diff *diff, NSInteger degFrom, NSInteger degTo);
void printDiff1RowBlocks(const Diff *diff, NSInteger degFrom, NSInteger degTo);
void printDiffProgram(const Diff *diff, NSInteger type, NSInteger shift);

void printDiffProgram2(const Diff *diff, NSInteger deg);

void printMatrix(Matrix *m);
void printMatrixKoefs(Matrix *m);
