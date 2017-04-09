#import "CreateDiffOdd.h"
#import "Utils.h"

void createDiffWithNumber1(Diff *diff);
void createDiffWithNumber3(Diff *diff);
void createDiffWithNumber5(Diff *diff);
void createDiffWithNumber7(Diff *diff);
void createDiffWithNumber9(Diff *diff);

//----------------------------------------------------------------------------
// creates d_{2m+1} (0 <= m <= 4)
//----------------------------------------------------------------------------
void createOddDiffWithNumber(Diff *diff, NSInteger m) {
    switch (m) {
        case 0: createDiffWithNumber1(diff); break;
        case 1: createDiffWithNumber3(diff); break;
        case 2: createDiffWithNumber5(diff); break;
        case 3: createDiffWithNumber7(diff); break;
        case 4: createDiffWithNumber9(diff); break;
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber1(Diff *diff) {
    NSInteger s = PathAlg.s;
    NSInteger m = 0;
    [diff makeZeroMatrix:6*s h:7*s];
    
    NSInteger j;
    for (j = 0; j < s; j++) {
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addTenToPos(diff, j+2*j_1*s, j, 4*(j+m)+1+j_1, 4*(j+m)+3, 4*j, 4*j+j_1, 1);
        }
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addTenToPos(diff, j+(2*j_1+1)*s, j, 4*(j+m+s)+1+j_1, 4*(j+m)+3, 4*j, 4*(j+s)+j_1, -1);
        }
    }
    
    for (j = s; j < 3*s; j++) {
        addTenToPos(diff, (j<2*s)?j-s+1:(j+s+1)%(2*s), j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+1), 1);
        addTenToPosNoZero(diff, j+s, j, 4*(j+m+s)+2, 4*(j+m+s+1)+2, YES, 4*(j+s)+1, 4*(j+s)+1, NO, 1);
        addTenToPosNoZero(diff, (j<2*s)?j+s+1:(j+s+1)%(2*s)+2*s, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, NO, 4*(j+s)+1, 4*(j+s+1)+1, YES, 1);
        addTenToPos(diff, j+3*s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+s)+2, 1);
        addTenToPos(diff, j%s+6*s, j, 4*(j+m+1), 4*(j+m+s+1)+2, 4*(j+s)+1, 4*j+3, 1);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        addTenToPos(diff, (j<4*s) ? (j+1)%(2*s):j-4*s+1, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*(j+s)+2, 4*(j+1), 1);
        addTenToPos(diff, j+s, j, 4*(j+m)+3, 4*(j+m+1)+1, 4*(j+s)+2, 4*(j+s)+2, 1);
        addTenToPos(diff, j%s+6*s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+2, 4*j+3, 1);
    }
    
    for (j = 5*s; j < 6*s; j++) {
        NSInteger i_2 = j % s;
        addTenToPos(diff, (j+1)%s, j, 4*(j+m+(1-f(i_2,s-1))*s+1)+1, 4*(j+m+2), 4*j+3, 4*(j+1), 1);
        addTenToPos(diff, (j+1)%s+2*s, j, 4*(j+m+(1-f(i_2,s-1))*s+1)+2, 4*(j+m+2), 4*j+3, 4*(j+(1-f(i_2,s-1))*s+1)+1, 1);
        addTenToPos(diff, (j+1)%s+4*s, j, 4*(j+m+1)+3, 4*(j+m+2), 4*j+3, 4*(j+(1-f(i_2,s-1))*s+1)+2, 1);
        addTenToPosNoZero(diff, j+s, j, 4*(j+m+1), 4*(j+m+2), YES, 4*j+3, 4*j+3, NO, 1);
        addTenToPosNoZero(diff, (j+1)%s+6*s, j, 4*(j+m+2), 4*(j+m+2), NO, 4*j+3, 4*(j+1)+3, YES, 1);
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber3(Diff *diff) {
    NSInteger s = PathAlg.s;
    NSInteger m = 1;
    [diff makeZeroMatrix:9*s h: 8*s];
    
    NSInteger j;
    for (j = 0; j < 2*s; j++) {
        NSInteger j_2 = j / s;
        addTenToPos(diff, j%s, j, 4*(j+m+j_2*s)+2, 4*(j+m)+3+j_2, 4*j, 4*j, 1);
        addTenToPos(diff, j+s+3*j_2*s, j, 4*(j+m+s)+2+2*j_2, 4*(j+m)+3+j_2, 4*j, 4*j+2*j_2, -1);
        addTenToPos(diff, j+(2+j_2)*s, j, 4*(j+m)+3+j_2, 4*(j+m)+3+j_2, 4*j, 4*(j+j_2*s)+1+j_2, 1);
        addTenToPos(diff, (j+s)%(2*s)+2*s, j, 4*(j+m)+3, 4*(j+m)+3+j_2, 4*j, 4*(j+s)+1, 1);
    }
    
    for (j = 2*s; j < 4*s; j++) {
        addTenToPos(diff, j, j, 4*(j+m)+3, 4*(j+m+s+1)+1, 4*j+1, 4*j+1, 1);
        addTenToPos(diff, j+2*s, j, 4*(j+m+1), 4*(j+m+s+1)+1, 4*j+1, 4*j+2, 1);
        addTenToPos(diff, (j+s)%(2*s)+6*s, j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+1, 4*j+1, 4*j+3, 1);
    }
    
    for (j = 4*s; j < 6*s; j++) {
        NSInteger j_2 = j / s;
        if (j>=5*s) addTenToPos(diff, (j+1)%(2*s), j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+1), -f1(j,6*s-1));
        addTenToPos(diff, j%s+4*s, j, 4*(j+m+1), 4*(j+m+1)+j_2-3, 4*(j+(j_2-4)*s)+2, 4*(j+(j_2-4)*s)+2, 1);
        addTenToPos(diff, j+2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+j_2-3, 4*(j+(j_2-4)*s)+2, 4*j+3, 1);
    }
    
    for (j = 6*s; j < 8*s; j++) {
        NSInteger j_2 = j / s;
        if (j>=7*s)addTenToPos(diff, j-7*s+1, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*j+2, 4*(j+1), f1(j,8*s-1));
        addTenToPos(diff, j%s+5*s, j, 4*(j+m+1), 4*(j+m+s+1)+1+j_2-6, 4*(j+(7-j_2)*s)+2, 4*(j+(7-j_2)*s)+2, 1);
        addTenToPos(diff, (j+s)%(2*s)+6*s, j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+1+j_2-6, 4*(j+(7-j_2)*s)+2, 4*j+3, 1);
    }
    
    for (j = 8*s; j < 9*s; j++) {
        addTenToPos(diff, (j+1)%s, j, 4*(j+m+f(j,9*s-1)*s+1)+2, 4*(j+m+1)+3, 4*j+3, 4*(j+1), f1(j,9*s-1));
        addTenToPos(diff, (j+1)%s+2*s, j, 4*(j+m+1)+3, 4*(j+m+1)+3, 4*j+3, 4*(j+f(j,9*s-1)*s+1)+1, f1(j,9*s-1));
        addTenToPos(diff, j-2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+3, 4*j+3, 4*j+3, 1);
        addTenToPos(diff, j-s, j, 4*(j+m+s+1)+1, 4*(j+m+1)+3, 4*j+3, 4*j+3, -1);
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber5(Diff *diff) {
    NSInteger s = PathAlg.s;
    NSInteger m = 2;
    [diff makeZeroMatrix:9*s h: 8*s];
    
    NSInteger j;
    for (j = 0; j < s; j++) {
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addTenToPos(diff, j+2*j_1*s, j, 4*(j+m)+1+j_1+2*f(j_1,1), 4*(j+m+1), 4*j, 4*j+j_1, f1(j_1,2));
        }
        for (NSInteger j_1 = 0; j_1 <= 2; j_1++) {
            addTenToPos(diff, j+(2*j_1+1)*s, j, 4*(j+m+s)+1+j_1+2*f(j_1,1), 4*(j+m+1), 4*j, 4*(j+s)+j_1, f1(j_1,2));
        }
    }
    
    for (j = s; j < 3*s; j++) {
        NSInteger j_2 = j / s;
        addTenToPos(diff, (j+s+1)%(2*s), j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+j_2, 4*(j+s*(2-j_2))+1, 4*(j+1), -f1(j,2*s));
        addTenToPos(diff, j%s+2*s, j, 4*(j+m+1), 4*(j+m+s+1)+j_2, 4*(j+s*(2-j_2))+1, 4*(j+s*(2-j_2))+1, 1);
        if(j>=2*s)addTenToPos(diff, j+2*s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*j+1, 4*j+2, -1);
        if(j>=2*s)addTenToPos(diff, j+5*s, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*j+1, 4*j+3, -1);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        NSInteger j_2 = j / s;
        addTenToPos(diff, (j+1)%(2*s), j, 4*(j+m+1)+1, 4*(j+m+1)+j_2-2, 4*(j+s*(j_2-3))+1, 4*(j+1), -f1(j,4*s));
        addTenToPos(diff, j%s+3*s, j, 4*(j+m+1), 4*(j+m+1)+j_2-2, 4*(j+s*(j_2-3))+1, 4*(j+s*(j_2-3))+1, 1);
        if(j>=4*s)addTenToPos(diff, j+s, j, 4*(j+m)+3, 4*(j+m+1)+2, 4*(j+s)+1, 4*(j+s)+2, -1);
        if(j>=4*s)addTenToPos(diff, j+2*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*(j+s)+1, 4*j+3, 1);
    }
    
    for (j = 5*s; j < 7*s; j++) {
        addTenToPos(diff, j-s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*(j+s)+2, 4*(j+s)+2, 1);
        addTenToPos(diff, j+s, j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*(j+s)+2, 4*j+3, f1(j,6*s));
    }
    
    for (j = 7*s; j < 8*s; j++) {
        addTenToPos(diff, j-7*s+1, j, 4*(j+m+s+1)+1, 4*(j+m+1)+3, 4*j+3, 4*(j+1), 1);
        addTenToPos(diff, (j+1)%(2*s), j, 4*(j+m+1)+1, 4*(j+m+1)+3, 4*j+3, 4*(j+1), 1);
        addTenToPos(diff, j-3*s+1, j, 4*(j+m+1)+3, 4*(j+m+1)+3, 4*j+3, 4*(j+s+1)+2, -1);
        addTenToPos(diff, (j+1)%(2*s)+4*s, j, 4*(j+m+1)+3, 4*(j+m+1)+3, 4*j+3, 4*(j+1)+2, -1);
        addTenToPos(diff, j-s, j, 4*(j+m+s+1)+2, 4*(j+m+1)+3, 4*j+3, 4*j+3, 1);
        addTenToPos(diff, j, j, 4*(j+m+1)+2, 4*(j+m+1)+3, 4*j+3, 4*j+3, -1);
    }
    
    for (j = 8*s; j < 9*s; j++) {
        addTenToPos(diff, (j+s+1)%(2*s)+2*s, j, 4*(j+m+2), 4*(j+m+2), 4*j+3, 4*(j+s+1)+1, -1);
        addTenToPos(diff, j-2*s, j, 4*(j+m+1)+2, 4*(j+m+2), 4*j+3, 4*j+3, 1);
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber7(Diff *diff) {
    NSInteger s = PathAlg.s;
    NSInteger m = 3;
    [diff makeZeroMatrix:6*s h: 8*s];
    
    NSInteger j;
    for (j = 0; j < s; j++) {
        addTenToPos(diff, j, j, 4*(j+m)+2, 4*(j+m)+3, 4*j, 4*j, 1);
        addTenToPos(diff, j+s, j, 4*(j+m+s)+2, 4*(j+m)+3, 4*j, 4*j, -1);
        addTenToPos(diff, j+2*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j, 4*j+1, 1);
        addTenToPos(diff, j+3*s, j, 4*(j+m)+3, 4*(j+m)+3, 4*j, 4*(j+s)+1, -1);
    }
    
    for (j = s; j < 3*s; j++) {
        addTenToPos(diff, (j+s+1)%(2*s), j, 4*(j+m+s+1)+2, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+1), -1);
        addTenToPos(diff, j+s, j, 4*(j+m)+3, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+s)+1, 1);
        addTenToPos(diff, j+3*s, j, 4*(j+m+1), 4*(j+m+s+1)+2, 4*(j+s)+1, 4*(j+s)+2, 1);
        addTenToPos(diff, j+5*s, j, 4*(j+m+s+1)+1, 4*(j+m+s+1)+2, 4*(j+s)+1, 4*j+3, -1);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        addTenToPos(diff, j+s, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+2, 4*(j+s)+2, 1);
        addTenToPos(diff, j%(2*s)+6*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*(j+s)+2, 4*j+3, 1);
    }
    
    for (j = 5*s; j < 6*s; j++) {
        addTenToPos(diff, (j+1)%s+s, j, 4*(j+m+1+s*f(j,6*s-1))+2, 4*(j+m+2), 4*j+3, 4*(j+1), 1);
        addTenToPos(diff, (j+1)%s+2*s, j, 4*(j+m+1)+3, 4*(j+m+2), 4*j+3, 4*(j+1+(1+f(j,6*s-1))*s)+1, -1);
        addTenToPos(diff, (j+1)%s+4*s, j, 4*(j+m+2), 4*(j+m+2), 4*j+3, 4*(j+1+(1+f(j,6*s-1))*s)+2, -1);
        addTenToPos(diff, (j+1)%s+5*s, j, 4*(j+m+2), 4*(j+m+2), 4*j+3, 4*(j+1+s*f(j,6*s-1))+2, -1);
        addTenToPos(diff, j+s, j, 4*(j+m+s+1)+1, 4*(j+m+2), 4*j+3, 4*j+3, 1);
        addTenToPos(diff, j+2*s, j, 4*(j+m+1)+1, 4*(j+m+2), 4*j+3, 4*j+3, 1);
    }
}

//----------------------------------------------------------------------------
void createDiffWithNumber9(Diff *diff) {
    NSInteger s = PathAlg.s;
    NSInteger m = 4;
    [diff makeZeroMatrix:6*s h: 7*s];

    NSInteger j;
    for (j = 0; j < s; j++) {
        addTenToPos(diff, j, j, 4*(j+m)+3, 4*(j+m+1), 4*j, 4*j, 1);
        addTenToPos(diff, j+s, j, 4*(j+m+1), 4*(j+m+1), 4*j, 4*j+1, 1);
        addTenToPos(diff, j+2*s, j, 4*(j+m+1), 4*(j+m+1), 4*j, 4*(j+s)+1, -1);
    }
    
    for (j = s; j < 3*s; j++) {
        addTenToPos(diff, j, j, 4*(j+m+1), 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s)+1, 1);
        addTenToPos(diff, j+2*s, j, 4*(j+m+1)+1, 4*(j+m+1)+1, 4*(j+s)+1, 4*(j+s)+2, 1);
    }
    
    for (j = 3*s; j < 5*s; j++) {
        addTenToPos(diff, j, j, 4*(j+m+1)+1, 4*(j+m+1)+2, 4*(j+s)+2, 4*(j+s)+2, 1);
        addTenToPos(diff, j%(2*s)+5*s, j, 4*(j+m+1)+2, 4*(j+m+1)+2, 4*(j+s)+2, 4*j+3, 1);
    }
    
    for (j = 5*s; j < 6*s; j++) {
        addTenToPos(diff, (j+1)%s, j, 4*(j+m+1)+3, 4*(j+m+1)+3, 4*j+3, 4*(j+1), f1(j,6*s-1));
        addTenToPos(diff, j, j, 4*(j+m+s+1)+2, 4*(j+m+1)+3, 4*j+3, 4*j+3, 1);
        addTenToPos(diff, j+s, j, 4*(j+m+1)+2, 4*(j+m+1)+3, 4*j+3, 4*j+3, -1);
    }
}
