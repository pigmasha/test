#import "CreateDiffEven.h"
#import "Utils.h"

void createDiffWithNumber0(Diff *diff);
void createDiffWithNumber2(Diff *diff);
void createDiffWithNumber4(Diff *diff);
void createDiffWithNumber6(Diff *diff);
void createDiffWithNumber8(Diff *diff);
void createDiffWithNumber10(Diff *diff);

//----------------------------------------------------------------------------
// creates d_{2m} (0 <= m <= 5)
//----------------------------------------------------------------------------
void createEvenDiffWithNumber(Diff *diff, NSInteger m)  {
    switch (m) {
        case 0: createDiffWithNumber0(diff); break;
        case 1: createDiffWithNumber2(diff); break;
        case 2: createDiffWithNumber4(diff); break;
        case 3: createDiffWithNumber6(diff); break;
        case 4: createDiffWithNumber8(diff); break;
        case 5: createDiffWithNumber10(diff); break;
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber0(Diff *diff) {
    NSInteger s = PathAlg.alg.s;
    NSInteger m = 0;
    [diff makeZeroMatrix:7*s h: 6*s];

    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        addTenToPos(diff, j%s, j, 4*(j+m), 4*(j+m)+1, 4*j, 4*j, 1);
        addTenToPos(diff, j+s, j, 4*(j+m)+1, 4*(j+m)+1, 4*j, 4*j+1, -1);
    }
    
    for (j = 2*s; j < 4*s; j++) {
        addTenToPos(diff, j-s, j, 4*(j+m)+1, 4*(j+m)+2, 4*j+1, 4*j+1, 1);
        addTenToPos(diff, j+s, j, 4*(j+m)+2, 4*(j+m)+2, 4*j+1, 4*j+2, -1);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        addTenToPos(diff, j-s, j, 4*(j+m)+2, 4*(j+m)+3, 4*j+2, 4*j+2, 1);
        addTenToPos(diff, j%s+5*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+2, 4*j+3, -1);
    }
    
    for (j = 6*s; j < 7*s; j++) {
        addTenToPos(diff, (j+1)%s, j, 4*(j+m+1), 4*(j+m+1), 4*j+3, 4*(j+1), -1);
        addTenToPos(diff, j-s, j, 4*(j+m)+3, 4*(j+m+1), 4*j+3, 4*j+3, 1);
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber2(Diff *diff) {
    NSInteger s = PathAlg.alg.s;
    NSInteger m = 1;
    [diff makeZeroMatrix:8*s h: 6*s];

    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        addTenToPos(diff, j%s, j, 4*(j+m-1)+3, 4*(j+m)+2, 4*j, 4*j, 1);
        addTenToPos(diff, j+s, j, 4*(j+m)+2, 4*(j+m)+2, 4*j, 4*j+1, -f1(j,s));
        addTenToPos(diff, (j+s)%(2*s)+3*s, j, 4*(j+m)+1, 4*(j+m)+2, 4*j, 4*(j+s)+2, f1(j,s));
    }
    
    for (j = 2*s; j < 4*s; j++) {
        NSInteger i_2 = j % s;
        addTenToPos(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+1, 4*(j+1), -f1(j, 3*s)*f1(i_2,s-1));
        addTenToPos(diff, j-s, j, 4*(j+m)+2, 4*(j+m)+3, 4*j+1, 4*j+1, 1);
        addTenToPos(diff, j+s, j, 4*(j+m+s)+1, 4*(j+m)+3, 4*j+1, 4*j+2, -1);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        if (j<5*s-1 || j==6*s-1)addTenToPos(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m+1), 4*j+2, 4*(j+1), 1);
        addTenToPos(diff, j-s, j, 4*(j+m+s)+1, 4*(j+m+1), 4*j+2, 4*j+2, 1);
        addTenToPos(diff, j%s+5*s, j, 4*(j+m+1), 4*(j+m+1), 4*j+2, 4*j+3, -1);
    }
    
    for (j = 6*s; j < 8*s; j++) {
        if (j<7*s-1 || j==8*s-1)addTenToPos(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*j+3, 4*(j+1), -1);
        addTenToPos(diff, (j+s+1)%(2*s)+3*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*j+3, 4*(j+s+1)+2, -1);
        addTenToPos(diff, j%s+5*s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*j+3, 4*j+3, 1);
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber4(Diff *diff) {
    NSInteger s = PathAlg.alg.s;
    NSInteger m = 2;
    [diff makeZeroMatrix:8*s h: 9*s];

    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        if (j<s) addTenToPos(diff, j, j, 4*(j+m-1)+3, 4*(j+m)+1, 4*j, 4*j, 1);
        addTenToPos(diff, j%s+s, j, 4*(j+m), 4*(j+m)+1, 4*j, 4*j, -f1(j,s));
        addTenToPos(diff, (j+s)%(2*s)+2*s, j, 4*(j+m)+1, 4*(j+m)+1, 4*j, 4*(j+s)+1, -1);
        addTenToPos(diff, j+(5-f0(j,s))*s, j, 4*(j+m)+1, 4*(j+m)+1, 4*j, 4*j+2, 1);
    }
    
    for (j = 2*s; j < 4*s; j++) {
        NSInteger i_2 = j % s;
        if(j<3*s-1||j==4*s-1)addTenToPos(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m+1), 4*j+1, 4*(j+1), 1);
        addTenToPos(diff, (j+1)%s+s, j, 4*(j+m+1), 4*(j+m+1), 4*j+1, 4*(j+1), -f1(i_2,s-1)*f1(j,3*s));
        addTenToPos(diff, j, j, 4*(j+m+s)+1, 4*(j+m+1), 4*j+1, 4*j+1, 1);
        addTenToPos(diff, j+(4-f0(j,3*s))*s, j, 4*(j+m+s)+2, 4*(j+m+1), 4*j+1, 4*j+2, -1);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        if(j<5*s-1||j==6*s-1)addTenToPos(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+2, 4*(j+1), 1);
        addTenToPos(diff, j+(1-f0(j,5*s))*s, j, 4*(j+m)+1, 4*(j+m)+3, 4*j+2, 4*j+2, 1);
        addTenToPos(diff, j+(2-f0(j,5*s))*s, j, 4*(j+m+s)+2, 4*(j+m)+3, 4*j+2, 4*j+2, -1);
        addTenToPos(diff, j%s+8*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+2, 4*j+3, -f1(j,5*s));
    }
    
    for (j = 6*s; j < 8*s; j++) {
        if(j<7*s-1||j==8*s-1)addTenToPos(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m+1)+2, 4*j+3, 4*(j+1), -f1(j,7*s));
        addTenToPos(diff, (j+s+1)%(2*s)+2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+2, 4*j+3, 4*(j+s+1)+1, f1(j,7*s));
        if(j<7*s-1||j==8*s-1)addTenToPos(diff, (j+1)%s+7*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*j+3, 4*(j+s+1)+2, -f1(j,7*s));
        if(j>=7*s-1&&j<8*s-1)addTenToPos(diff, (j+1)%s+5*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*j+3, 4*(j+s+1)+2, -f1(j,7*s));
        addTenToPos(diff, j%s+8*s, j, 4*(j+m)+3, 4*(j+m+1)+2, 4*j+3, 4*j+3, 1);
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber6(Diff *diff) {
    NSInteger s = PathAlg.alg.s;
    NSInteger m = 3;
    [diff makeZeroMatrix:8*s h: 9*s];

    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        NSInteger j_2 = j / s;
        addTenToPos(diff, j%s, j, 4*(j+m), 4*(j+m)+2, 4*j, 4*j, 1);
        addTenToPos(diff, j+(j_2+1)*s, j, 4*(j+m)+1, 4*(j+m)+2, 4*j, 4*j+1, -1);
        addTenToPos(diff, j+(4-3*j_2)*s, j, 4*(j+m)+2, 4*(j+m)+2, 4*j, 4*(j+s)+1, -1);
        addTenToPos(diff, j+5*s, j, 4*(j+m)+2, 4*(j+m)+2, 4*j, 4*j+2, 1);
    }
    
    for (j = 2*s; j < 4*s; j++) {
        NSInteger j_2 = j / s;
        addTenToPos(diff, j+s*(j_2-3), j, 4*(j+m)+1, 4*(j+m)+3, 4*j+1, 4*j+1, 1);
        addTenToPos(diff, j+s*(j_2-2), j, 4*(j+m+s)+2, 4*(j+m)+3, 4*j+1, 4*j+1, -1);
        addTenToPos(diff, j+3*s, j, 4*(j+m)+2, 4*(j+m)+3, 4*j+1, 4*j+2, -1);
        addTenToPos(diff, j%s+7*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j+1, 4*j+3, 1);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        if (j>=5*s) addTenToPos(diff, (j+1)%s, j, 4*(j+m+1), 4*(j+m+1), 4*j+2, 4*(j+1), 1);
        addTenToPos(diff, j+s, j, 4*(j+m)+2, 4*(j+m+1), 4*j+2, 4*j+2, 1);
        if (j>=5*s) addTenToPos(diff, j+2*s, j, 4*(j+m)+3, 4*(j+m+1), 4*j+2, 4*j+3, -1);
        addTenToPos(diff, j%s+8*s, j, 4*(j+m+1), 4*(j+m+1), 4*j+2, 4*j+3, -f1(j,5*s));
    }
    
    for (j = 6*s; j < 8*s; j++) {
        if (j<7*s) addTenToPos(diff, (j+1)%s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*j+3, 4*(j+1), -1);
        if (j<7*s-1||j==8*s-1)addTenToPos(diff, (j+1)%(2*s)+s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*j+3, 4*(j+1)+1, 1);
        if (j>=7*s-1&&j<8*s-1)addTenToPos(diff, (j+1)%(2*s)+2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*j+3, 4*(j+1)+1, 1);
        if (j<7*s) addTenToPos(diff, j+s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*j+3, 4*j+3, 1);
        addTenToPos(diff, j%s+8*s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*j+3, 4*j+3, -f1(j,7*s));
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber8(Diff *diff) {
    NSInteger s = PathAlg.alg.s;
    NSInteger m = 4;
    [diff makeZeroMatrix:7*s h: 6*s];

    NSInteger j;
    for (j = 0; j < s; j++) {
        addTenToPosNoZero(diff, j, j, 4*(j+m-1)+3, 4*(j+m)+3, YES, 4*j, 4*j, NO, 1);
        addTenToPosNoZero(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m)+3, NO, 4*j, 4*(j+1), YES, -f1(j,s-1));
        addTenToPos(diff, j+s, j, 4*(j+m)+2, 4*(j+m)+3, 4*j, 4*j+1, -1);
        addTenToPos(diff, j+2*s, j, 4*(j+m+s)+2, 4*(j+m)+3, 4*j, 4*(j+s)+1, 1);
        addTenToPos(diff, j+3*s, j, 4*(j+m+s)+1, 4*(j+m)+3, 4*j, 4*j+2, 1);
        addTenToPos(diff, j+4*s, j, 4*(j+m)+1, 4*(j+m)+3, 4*j, 4*(j+s)+2, -1);
    }
    
    for (j = s; j < 3*s; j++) {
        if(j<2*s-1||j==3*s-1)addTenToPos(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m+1), 4*(j+s)+1, 4*(j+1), 1);
        addTenToPos(diff, j, j, 4*(j+m+s)+2, 4*(j+m+1), 4*(j+s)+1, 4*(j+s)+1, 1);
        addTenToPos(diff, j+2*s, j, 4*(j+m)+1, 4*(j+m+1), 4*(j+s)+1, 4*(j+s)+2, -1);
        addTenToPos(diff, j%s+5*s, j, 4*(j+m+1), 4*(j+m+1), 4*(j+s)+1, 4*j+3, 1);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        if(j<4*s-1||j==5*s-1)addTenToPos(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*(j+s)+2, 4*(j+1), -1);
        addTenToPosNoZero(diff, j, j, 4*(j+m)+1, 4*(j+m+1)+1, YES, 4*(j+s)+2, 4*(j+s)+2, NO, 1);
        addTenToPosNoZero(diff, (j+s+1)%(2*s)+3*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, NO, 4*(j+s)+2, 4*(j+s+1)+2, YES, -1);
        addTenToPos(diff, j%s+5*s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+2, 4*j+3, -1);
    }
    
    for (j = 5*s; j < 7*s; j++) {
        if(j>=6*s-1&&j<7*s-1) addTenToPos(diff, (j+1)%s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*j+3, 4*(j+1), 1);
        addTenToPos(diff, (j+s+1)%(2*s)+s, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*j+3, 4*(j+s+1)+1, 1);
        addTenToPos(diff, (j+1)%(2*s)+3*s, j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+2, 4*j+3, 4*(j+1)+2, 1);
        addTenToPos(diff, j%s+5*s, j, 4*(j+m+1), 4*(j+m+s+1)+2, 4*j+3, 4*j+3, 1);
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber10(Diff *diff) {
    NSInteger s = PathAlg.alg.s;
    NSInteger m = 5;
    [diff makeZeroMatrix:6*s h: 6*s];

    NSInteger j;
    for (j = 0; j < s; j++) {
        addTenToPosNoZero(diff, (j+1)%s, j, 4*(j+m+1), 4*(j+m+1), NO, 4*j, 4*(j+1), YES, -f1(j,s-1));
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addTenToPos(diff, j+(2*j_1+1)*s, j, 4*(j+m+s)+1+j_1, 4*(j+m+1), 4*j, 4*j+1+j_1, -f1(j_1, 1));
        }
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addTenToPosNoZero(diff, j+2*j_1*s, j, 4*(j+m)+j_1, 4*(j+m+1), YES, 4*j, 4*(j+s)+j_1, NO, f1(j_1, 2));
        }
    }
    
    for (j = s; j < 3*s; j++) {
        NSInteger i_2 = j % s;
        addTenToPos(diff, (j+1)%s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+1), f1(i_2, s-1)*f1(j,2*s));
        addTenToPos(diff, j, j, 4*(j+m)+1, 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s)+1, 1);
        addTenToPos(diff, (j+s+1)%(2*s)+s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s+1)+1, -1);
        addTenToPos(diff, j+2*s, j, 4*(j+m)+2, 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s)+2, -1);
        addTenToPos(diff, j%s+5*s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*(j+s)+1, 4*j+3, -f1(j,2*s));
    }
    
    for (j = 3*s; j < 5*s; j++) {
        NSInteger i_2 = j % s;
        addTenToPos(diff, (j+1)%s, j, 4*(j+m+1), 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+1), -f1(i_2,s-1)*f1(j,4*s));
        addTenToPos(diff, (j+s+1)%(2*s)+s, j, 4*(j+m+1)+1, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+s+1)+1, 1);
        addTenToPos(diff, j, j, 4*(j+m)+2, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+s)+2, 1);
        addTenToPos(diff, (j+s+1)%(2*s)+3*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+s+1)+2, -1);
        addTenToPos(diff, j%s+5*s, j, 4*(j+m)+3, 4*(j+m+1)+2, 4*(j+s)+2, 4*j+3, f1(j,4*s));
    }
    
    for (j = 5*s; j < 6*s; j++) {
        addTenToPos(diff, (j+1)%s, j, 4*(j+m+1), 4*(j+m+1)+3, 4*j+3, 4*(j+1), -f1(j,6*s-1));
        addTenToPos(diff, j-4*s+1, j, 4*(j+m+1)+1, 4*(j+m+1)+3, 4*j+3, 4*(j+s+1)+1, 1);
        addTenToPos(diff, (j+1)%(2*s)+s, j, 4*(j+m+s+1)+1, 4*(j+m+1)+3, 4*j+3, 4*(j+1)+1, -1);
        addTenToPos(diff, j-2*s+1, j, 4*(j+m+1)+2, 4*(j+m+1)+3, 4*j+3, 4*(j+s+1)+2, -1);
        addTenToPos(diff, (j+1)%(2*s)+3*s, j, 4*(j+m+s+1)+2, 4*(j+m+1)+3, 4*j+3, 4*(j+1)+2, 1);
        addTenToPosNoZero(diff, j, j, 4*(j+m)+3, 4*(j+m+1)+3, YES, 4*j+3, 4*j+3, NO, 1);
        addTenToPosNoZero(diff, (j+1)%s+5*s, j, 4*(j+m+1)+3, 4*(j+m+1)+3, NO, 4*j+3, 4*(j+1)+3, YES, -f1(j,6*s-1));
    }
}
