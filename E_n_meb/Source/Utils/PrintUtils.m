#import "PrintUtils.h"
#import "Utils.h"

//#define KOEFS_ONLY
//#define WITH_LINE_N

void posesFromQ(BimodQ *q, NSMutableArray* poses); // arrays of ints
void printMatrixToFile(Matrix *diff, FILE* f, BimodQ *qFrom, BimodQ *qTo);

void IdxToFile(NSInteger idx, NSInteger j, NSInteger m, FILE* f, BOOL with1);
void jToFile(NSInteger j, FILE* f);

//---------------------------------------------------------------------------------
void printMatrixDeg(Matrix *diff, NSInteger degFrom, NSInteger degTo) {
    FILE_OPEN();
    BimodQ *qFrom = [[BimodQ alloc] initForDeg:degFrom];
    BimodQ *qTo = [[BimodQ alloc] initForDeg:degTo];
    
    printMatrixToFile(diff, f, qFrom, qTo);
    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void printMatrixToFile(Matrix *diff, FILE* f, BimodQ *qFrom, BimodQ *qTo) {
    //int n = PathAlg.n;
    NSInteger s = PathAlg.s;

    NSMutableArray* fromPoses = [[NSMutableArray alloc] init];
    NSMutableArray* toPoses   = [[NSMutableArray alloc] init];
    posesFromQ(qFrom, fromPoses);
    posesFromQ(qTo, toPoses);
    
    NSArray* rows = [diff rows];
    
    fprintf(f, "<table>");
#ifdef WITH_LINE_N
    fprintf(f, "<tr><td class='c_b_1 c_r_1'></td>");
    for (NSInteger j = 0; j < [[rows firstObject] count]; j++) {
        NSInteger cellLeft = 0;
        if (j > 0 && (j % s) == 0)
        {
            cellLeft = 2;
            if (qFrom && ![fromPoses containsObject:[NSNumber numberWithInt:(NSInteger)(j / s)]]) cellLeft = 1;
        }
        fprintf(f, "<td class='c_b_1 c_l_%d'>%d</td>", cellLeft, j);
    }
    fprintf(f, "</tr>");
#endif
    for (NSInteger i = 0; i < [rows count]; i++)
    {
        NSInteger cellTop = 0;
        if (i > 0 && (i % s) == 0) {
            cellTop = 2;
            if (qTo && ![toPoses containsObject:[NSNumber numberWithInt:(int)(i / s)]]) cellTop = 1;
        }

        fprintf(f, "<tr>");
#ifdef WITH_LINE_N
        fprintf(f, "<td class='c_r_1 c_t_%d'>%d</td>", cellTop, i);
#endif
        NSArray* line = [rows objectAtIndex:i];
        for (NSInteger j = 0; j < [line count]; j++) {
            NSInteger cellLeft = 0;
            if (j > 0 && (j % s) == 0) {
                cellLeft = 2;
                if (qFrom && ![fromPoses containsObject:[NSNumber numberWithInt:(int)(j / s)]]) cellLeft = 1;
            }
            fprintf(f, "<td class='c_t_%zd c_l_%zd'", cellTop, cellLeft);
            Comb *c = [line objectAtIndex:j];
#ifdef KOEFS_ONLY
            BOOL ok = NO;
            if ([[c content] count] > 1) {
                fprintf(f, ">ERROR! (sz = %zd)</td>", (NSInteger)[[c content] count]);
                ok = YES;
            }
            if (!ok && ![c isZero]) {
                fprintf(f, " width=20>%s</td>", ([[[[c content] firstObject] firstObject] intValue] > 0) ? "+" : "&minus;");
                ok = YES;
            }
            if (!ok && [c isPotential]) {
                fprintf(f, " width=20>&bull;</td>");
            } else {
                if (!ok) fprintf(f, " width=20>&nbsp;</td>");
            }
#else
            fprintf(f, ">%s</td>", c.htmlStr.UTF8String);
#endif
        }
        fprintf(f, "</tr>\n");
    }
    fprintf(f, "</table><p>");
}

//---------------------------------------------------------------------------------
void printImDeg(const ImMatrix * matr, NSInteger deg) {
    //int n = PathAlg.n;
    NSInteger s = PathAlg.s;

    FILE_OPEN();
    
#ifdef KOEFS_ONLY
    fprintf(f, "<style>td { width: 20px; }</style>\n");
#endif
    
    BimodQ *qFrom = [[BimodQ alloc] initForDeg:deg];
    BimodQ *qTo   = [[BimodQ alloc] initForDeg:deg + 1];
    
    NSMutableArray* fromPoses = [[NSMutableArray alloc] init];
    NSMutableArray* toPoses   = [[NSMutableArray alloc] init];
    
    posesFromQ(qFrom, fromPoses);
    posesFromQ(qTo,   toPoses);

    NSArray* rows = [matr rows];
    fprintf(f, "<table>");
    for (NSInteger i = 0; i < [rows count]; i++)
    {
        NSInteger cellTop = 0;
        if (i > 0 && (i % s) == 0) {
            cellTop = 2;
            if (![toPoses containsObject:[NSNumber numberWithInt:(int)(i / s)]]) cellTop = 1;
        }

        NSArray* line = [rows objectAtIndex:i];
        fprintf(f, "<tr>");
        for (NSInteger j = 0; j < [line count]; j++) {
            NSInteger cellLeft = 0;
            if (j > 0 && (j % s) == 0) {
                cellLeft = 2;
                if (![fromPoses containsObject:[NSNumber numberWithInt:(int)(j / s)]]) cellLeft = 1;
            }

            fprintf(f, "<td class='c_t_%zd c_l_%zd'>", cellTop, cellLeft);
            
            WayPair* pp = [line objectAtIndex:j];
            if ([pp koef] == 0 || [[pp way] isZero]) {
                fprintf(f, "&nbsp;</td>");
                continue;
            }
            if ([pp koef] == -1) {
                fprintf(f, "-");
            } else if ([pp koef] != 1) {
                fprintf(f, "%.0f", [pp koef]);
            }
#ifdef KOEFS_ONLY
            if ([pp koef] == 1) fprintf(f, "+");
#else
            fprintf(f, "%s", pp.way.htmlStr.UTF8String);
#endif
            fprintf(f, "</td>");
        }
        fprintf(f, "</tr>\n");
    }
    fprintf(f, "</table>");
    
    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void printImDegTr(const ImMatrix * matr, NSInteger deg) {
#ifdef KOEFS_ONLY
    fprintf(f, "<style>td { width: 20px; }</style>\n");
#endif
    //int n = PathAlg.n;
    NSInteger s = PathAlg.s;

    FILE_OPEN();
    
    BimodQ *qFrom = [[BimodQ alloc] initForDeg:deg];
    BimodQ *qTo   = [[BimodQ alloc] initForDeg:deg + 1];
    
    NSMutableArray* fromPoses = [[NSMutableArray alloc] init];
    NSMutableArray* toPoses   = [[NSMutableArray alloc] init];
    
    posesFromQ(qFrom, fromPoses);
    posesFromQ(qTo,   toPoses);
    
    NSArray* rows = [matr rows];
    fprintf(f, "<table>");
    for (NSInteger j = 0; j < [[rows lastObject] count]; j++)
    {
        NSInteger cellTop = 0;
        if (j > 0 && (j % s) == 0) {
            cellTop = 2;
            if (![fromPoses containsObject:[NSNumber numberWithInt:(int)(j / s)]]) cellTop = 1;
        }

        fprintf(f, "<tr>");
        for (NSInteger i = 0; i < [rows count]; i++) {
            NSInteger cellLeft = 0;
            if (i > 0 && (i % s) == 0) {
                cellLeft = 2;
                if (![toPoses containsObject:[NSNumber numberWithInt:(int)(i / s)]]) cellLeft = 1;
            }
            
            WayPair* pp = [[rows objectAtIndex:i] objectAtIndex:j];

            fprintf(f, "<td class='c_t_%zd c_l_%zd'>", cellTop, cellLeft);
            if ([pp koef] == 0 || [[pp way] isZero]) {
                fprintf(f, "&nbsp;</td>");
                continue;
            }
            if ([pp koef] == -1) {
                fprintf(f, "-");
            } else if ([pp koef] != 1) {
                fprintf(f, "%.0f", [pp koef]);
            }
#ifdef KOEFS_ONLY
            if ([pp koef] == 1) fprintf(f, "+");
#else
            fprintf(f, "%s", pp.way.htmlStr.UTF8String);
#endif
            fprintf(f, "</td>");
        }
        fprintf(f, "</tr>\n");
    }
    fprintf(f, "</table>");
    
    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void printKoefMatrix(KoefMatrix * matrix) {
    FILE_OPEN();
    
    NSInteger s = PathAlg.s;
    
    NSArray* rows = [matrix rows];
    fprintf(f, "<table border=1>");
    for (NSInteger i = 0; i < [rows count]; i++)
    {
        NSArray* line = [rows objectAtIndex:i];
        
        if (i > 0 && (i % (2*s)) == s) {
            fprintf(f, "<tr height=3 bgcolor=\"green\"><td colspan=%tu height=3></td></tr>\n", (NSInteger)[line count] + 9*s);
        }

        fprintf(f, "<tr>");
        for (NSInteger j = 0; j < [line count]; j++)
        {
            if (i == 0 && j > 0 && (j % (2*s)) == s) {
                fprintf(f, "<td rowspan=%zd width=0 bgcolor=\"green\"></td>", (NSInteger)[rows count]+9*s);
            }
            NumFloat* n = [line objectAtIndex:j];

            if ([n floatValue]) {
                fprintf(f, "<td>%.0f</td>", [n floatValue]);
            } else {
                fprintf(f, "<td>&nbsp;</td>");
            }
        }
        fprintf(f, "</tr>\n");
    }
    fprintf(f, "</table>");
    
    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void printKoefIntMatrix(KoefIntMatrix * matrix, NSInteger deg, NSInteger skipLines) {
    FILE_OPEN();
    
    BimodQ *qFrom = [[BimodQ alloc] initForDeg:deg + 1];
    BimodQ *qTo   = [[BimodQ alloc] initForDeg:deg];
    
    NSMutableArray* fromPoses = [[NSMutableArray alloc] init];
    NSMutableArray* toPoses   = [[NSMutableArray alloc] init];
    
    posesFromQ(qFrom, fromPoses);
    posesFromQ(qTo,   toPoses);
    
    NSInteger s = PathAlg.s;
    
    NSArray* rows = [matrix rows];
    fprintf(f, "<table border=1>");
    for (NSInteger i = 0; i < [rows count]; i++)
    {
        if (i < skipLines) continue;
        NSArray* line = [rows objectAtIndex:i];
        
        NSInteger cellTop = 0;
        if (i > 0 && (i % s) == 0) {
            cellTop = 2;
            if (qTo && ![toPoses containsObject:[NSNumber numberWithInt:(int)(i / s)]]) cellTop = 1;
        }

        fprintf(f, "<tr>");
        for (NSInteger j = 0; j < [line count]; j++)
        {
            NSInteger cellLeft = 0;
            if (j > 0 && (j % s) == 0) {
                cellLeft = 2;
                if (qFrom && ![fromPoses containsObject:[NSNumber numberWithInt:(int)(j / s)]]) cellLeft = 1;
            }
            fprintf(f, "<td class='c_t_%zd c_l_%zd' width=20>", cellTop, cellLeft);

            NumInt* n = line[j];
            
            if (n.intValue) {
                fprintf(f, "%zd</td>", n.intValue);
            } else {
                fprintf(f, "&nbsp;</td>");
            }
        }
        fprintf(f, "</tr>\n");
    }
    fprintf(f, "</table>");
    
    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void posesFromQ(BimodQ *q, NSMutableArray<NSNumber *> *poses) {
    if (q) {
        NSInteger sum = 0;
        for (NumInt *n in q.sizes) {
            sum += [n intValue];
            [poses addObject:[NSNumber numberWithInt:(int)sum]];
        }
    }
}

//---------------------------------------------------------------------------------
void printDiffProgram(const Diff *diff, NSInteger type, NSInteger shift) {
    BOOL byBlocks = YES;// typeIsBlocks(type);

    FILE_OPEN();

    fprintf(f, "<pre>\n// ------------------------------------------------------------------------------------------\n");

    NSInteger s = PathAlg.s;

    NSInteger m = (shift % PathAlg.twistPeriod) / 2;

    NSArray* rows = [diff rows];
    
    NSInteger nBlocks = (byBlocks) ? (NSInteger)[[rows lastObject] count] / s :(NSInteger)[[rows lastObject] count];

    fprintf(f, "void shiftInType%zd_%zd(HHElem* hh_shift, NSInteger degree, NSInteger shift)\n{\n    BEGIN_FUNC();\n    CreateZeroMatrix(hh_shift, %tu*s, %tu*s);\n\n",
        type, shift, (NSInteger)[[rows lastObject] count] / s, (NSInteger)[rows count] / s);
    if (byBlocks) fprintf(f, "    NSInteger j;\n");
    
    BOOL hasLine = NO;
    for (NSInteger b = 0; b < nBlocks;  b++)
    {
        NSInteger j = (byBlocks) ? b * s : b;

        NSMutableArray* nonZeros = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [rows count]; i++)
        {
            if (![[[rows objectAtIndex:i] objectAtIndex:j] isZero]) [nonZeros addObject:[NumInt numWithInt:i]];
        }
        if (![nonZeros count]) {
            continue;
        }

        if (hasLine) fprintf(f, "    \n");
        
        if (byBlocks) {
            switch (b)
            {
                case 0: fprintf(f, "    for (j = 0; j < s; j++)"); break;
                case 1: fprintf(f, "    for (j = s; j < 2*s; j++)"); break;
                default:fprintf(f, "    for (j = %zd*s; j < %zd*s; j++)", b, b+1); break;
            }
            fprintf(f, "\n    {\n");
        } else {
            fprintf(f, (hasLine) ? "    " : "    NSInteger ");
            jToFile(j, f);
        }
        
        for (NumInt* ii in nonZeros) {
            fprintf(f, "%s    addTenToPos(hh_shift, ", (byBlocks) ? "    " : "");
            NSInteger i = [ii intValue];
            if ((i - j) % s == 0) {
                NSInteger d0 = (i - j) / s;
                if (i > j) {
                    if (d0 == 1) {
                        fprintf(f, "j+s");
                    } else {
                        fprintf(f, "j+%zd*s", d0);
                    }
                }
                if (i == j) fprintf(f, "j");
                if (i < j) {
                    if (d0 == -1) {
                        fprintf(f, "j-s");
                    } else {
                        fprintf(f, "j-%zd*s", -d0);
                    }
                }
            } else {
                fprintf(f, "(j+1)%%s");
                NSInteger i0 = i / s;
                if (i0 > 0) {
                    if (i0 == 1) {
                        fprintf(f, "+s");
                    } else {
                        fprintf(f, "+%zd*s", i0);
                    }
                }
            }
            fprintf(f, ", j, ");

            TenzorPair *p = [[[[rows objectAtIndex:i] objectAtIndex:j] content] firstObject];
            Tenzor *t = [p tenzor];
            
            IdxToFile([[[t leftComponent] startsWith] number], j, m, f, NO);
            IdxToFile([[[t leftComponent] endsWith] number], j, m, f, (s == 1 && [[t leftComponent] len] == 4));
            
            IdxToFile([[[t rightComponent] startsWith] number], j, -1, f, NO);
            IdxToFile([[[t rightComponent] endsWith] number], j, -1, f, (s == 1 && [[t rightComponent] len] == 4));
            
            fprintf(f, "%d);\n", ([p koef] > 0) ? 1 : -1);
        }
        if (byBlocks) fprintf(f, "    }\n");
        hasLine = YES;
    }

    fprintf(f, "}\n</pre>\n");

    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void IdxToFile(NSInteger idx, NSInteger j, NSInteger m, FILE* f, BOOL with1) {
    //int n = PathAlg.n;
    NSInteger s = PathAlg.s;

    Vertex *v1 = [[Vertex alloc] initWithI:idx];

    NSInteger b1 = idx % 4;
    char sfx[32];
    if (b1) {
        sprintf(sfx, "+%zd, ", b1);
    } else {
        strcpy(sfx, ", ");
    }

    Vertex *v2 = [[Vertex alloc] initWithI:(m > -1) ? 4*(j+m)+b1 : 4*j+b1];
    if ([v1 isEq: v2]) {
        if (with1) {
            fprintf(f, (m > -1) ? "4*(j+m+1)%s" : "4*(j+1)%s", sfx);
        } else {
            fprintf(f, (m > -1) ? "4*(j+m)%s" : "4*j%s", sfx);
        }
        return;
    }
    
    if (b1 == 0 || b1 == 3) {
        if (s == 2) {
            fprintf(f, (m > -1) ? "4*(j+m+1)%s" : "4*(j+1)%s", sfx);
        } else {
            Vertex *v3 = [[Vertex alloc] initWithI:(m > -1) ? 4*(j+m+1)+b1 : 4*(j+1)+b1];
            fprintf(f, (m > -1) ? "4*(j+m+%d)%s" : "4*(j+%d)%s", ([v1 isEq: v3]) ? 1 : 2, sfx);
        }
        return;
    }
    
    Vertex *vs = [[Vertex alloc] initWithI:(m > -1) ? 4*(j+m+s)+b1 : 4*(j+s)+b1];

    if ([v1 isEq: vs]) {
        fprintf(f, (m > -1) ? "4*(j+m+s)%s" : "4*(j+s)%s", sfx);
        return;
    }

    if (s == 2) {
        fprintf(f, (m > -1) ? "4*(j+m+1)" : "4*(j+1)");
        return;
    }

    Vertex *v3 = [[Vertex alloc] initWithI:(m > -1) ? 4*(j+m+1)+b1 : 4*(j+1)+b1];
    if ([v1 isEq: v3]) {
        fprintf(f, (m > -1) ? "4*(j+m+1)%s" : "4*(j+1)%s", sfx);
        return;
    }

    Vertex *vs3 = [[Vertex alloc] initWithI:(m > -1) ? 4*(j+m+s+1)+b1 : 4*(j+s+1)+b1];
    if ([v1 isEq: vs3]) {
        fprintf(f, (m > -1) ? "4*(j+m+s+1)%s" : "4*(j+s+1)%s", sfx);
        return;
    }

    fprintf(f, (m > -1) ? "4*(j+m+2)%s" : "4*(j+2)%s", sfx);
}

//---------------------------------------------------------------------------------
void jToFile(NSInteger j, FILE* f) {
    NSInteger s = PathAlg.s;

    fprintf(f, "j = ");

    if (j == 0) {
        fprintf(f, "0;\n");
        return;
    }

    NSInteger j0 = j / s;
    if (j0 > 0) {
        if (j0 == 1) {
            fprintf(f, "s");
        } else {
            fprintf(f, "%zd*s", j0);
        }
    }
    
    NSInteger j1 = j % s;
    if (j1 == 0) {
        fprintf(f, ";\n");
    } else {
        fprintf(f, (j0 == 0) ? "%zd;\n" : "+%zd;\n", j1);
    }
}

//---------------------------------------------------------------------------------
void printDiffByS(Diff *diff, NSInteger degFrom, NSInteger degTo) {
    BimodQ *qFrom = [[BimodQ alloc] initForDeg:degFrom];
    BimodQ *qTo   = [[BimodQ alloc] initForDeg:degTo];
    
    NSMutableArray* fromPoses = [[NSMutableArray alloc] init];
    NSMutableArray* toPoses   = [[NSMutableArray alloc] init];
    
    posesFromQ(qFrom, fromPoses);
    posesFromQ(qTo,   toPoses);
    
    NSInteger s = PathAlg.s;

    NSArray* rows = [diff rows];
    
    if (![rows count])
        return;

    FILE_OPEN();

    NSInteger w = (NSInteger)[[rows lastObject] count] / s;
    NSInteger h = (NSInteger)[rows count] / s;

    fprintf(f, "<table>");
    for (NSInteger i = 0; i < h; i++)
    {
        NSInteger cellTop = 0;
        if (i > 0) {
            cellTop = 2;
            if (![toPoses containsObject:[NSNumber numberWithInt:(int)i]]) cellTop = 1;
        }

        fprintf(f, "<tr>");

        for (NSInteger j = 0; j < w; j++) {
            NSInteger cellLeft = 0;
            if (j > 0) {
                cellLeft = 2;
                if (![fromPoses containsObject:[NSNumber numberWithInt:(int)j]]) cellLeft = 1;
            }

            float k = 0;
            if (![[[rows objectAtIndex:i*s] objectAtIndex:j*s] isZero]) k = [[[rows objectAtIndex:i*s] objectAtIndex:j*s] firstKoef];
            if (![[[rows objectAtIndex:i*s+1] objectAtIndex:j*s] isZero]) k = [[[rows objectAtIndex:i*s+1] objectAtIndex:j*s] firstKoef];
            
            char* str = "&nbsp;";
            if (k > 0) str = "+";
            if (k < 0) str = "&minus;";
            if (k < 0) fprintf(f, "&minus;</td>");

            fprintf(f, "<td class='c_t_%zd c_l_%zd' width=20>%s</td>", cellTop, cellLeft, str);
            
        }
        fprintf(f, "</tr>\n");
    }
    fprintf(f, "</table><p>");

    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void printDiff1RowBlocks(Diff *diff, NSInteger degFrom, NSInteger degTo) {
    BimodQ *qFrom = [[BimodQ alloc] initForDeg:degFrom];
    NSMutableArray* fromPoses = [[NSMutableArray alloc] init];
    posesFromQ(qFrom, fromPoses);
    
    NSInteger s = PathAlg.s;

    NSArray* rows = [diff rows];
    if (![rows count])
        return;

    FILE_OPEN();

    NSInteger w = (NSInteger)[[rows lastObject] count] / s;
    
    fprintf(f, "<table><tr>");
    
    for (NSInteger j = 0; j < w; j++) {
        NSInteger cellLeft = 0;
        if (j > 0)
        {
            cellLeft = 2;
            if (![fromPoses containsObject:[NSNumber numberWithInt:(int)j]]) cellLeft = 1;
        }
        
        float k = 0;
        for (NSInteger i = 0; i < [rows count]; i++) {
            if (![[[rows objectAtIndex:i] objectAtIndex:j*s] isZero]) {
                k = [[[rows objectAtIndex:i] objectAtIndex:j*s] firstKoef];
                break;
            }
        }
        
        char* str = "&nbsp;";
        if (k > 0) str = "+";
        if (k < 0) str = "&minus;";
        if (k < 0) fprintf(f, "&minus;</td>");

        fprintf(f, "<td class='c_l_%zd' width=20>%s</td>", cellLeft, str);
    }
    fprintf(f, "</tr></table><p>");

    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void printDiff1Row(const Diff *diff, NSInteger degFrom, NSInteger degTo) {
    BimodQ *qFrom = [[BimodQ alloc] initForDeg:degFrom];
    NSMutableArray* fromPoses = [[NSMutableArray alloc] init];
    posesFromQ(qFrom, fromPoses);
    
    NSInteger s = PathAlg.s;

    NSArray* rows = [diff rows];
    if (![rows count])
        return;

    FILE_OPEN();

    NSInteger w = (NSInteger)[[rows lastObject] count];
    
    fprintf(f, "<table><tr>");
    
    for (NSInteger j = 0; j < w; j++) {
        NSInteger cellLeft = 0;
        if (j > 0 && (j % s) == 0)
        {
            cellLeft = 2;
            if (![fromPoses containsObject:[NSNumber numberWithInt:(int)(j / s)]]) cellLeft = 1;
        }

        NSInteger cnt = 0;
        for (NSInteger i = 0; i < [rows count]; i++) {
            if (![[[rows objectAtIndex:i] objectAtIndex:j] isZero]) cnt++;
        }
        
        if (cnt) {
            fprintf(f, "<td class='c_l_%zd' width=20>%zd</td>", cellLeft, cnt);
        } else {
            fprintf(f, "<td class='c_l_%zd' width=20>&nbsp;</td>", cellLeft);
        }
    }
    fprintf(f, "</tr></table><p>");

    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void printDiffProgram2(const Diff *diff, NSInteger deg) {
    FILE_OPEN();

    fprintf(f, "<pre>\n// ------------------------------------------------------------------------------------------\n");

    NSInteger s = PathAlg.s;
    NSInteger m = (deg % PathAlg.twistPeriod) / 2;

    NSArray* rows = [diff rows];
    
    NSInteger nBlocks = (NSInteger)[[rows lastObject] count] / s;

    fprintf(f, "void createDiffWithNumber%tu(Diff *diff)\n{\n    NSInteger s = PathAlg.s;\n    NSInteger m = %zd;\n    CreateZeroMatrix(diff, %zd*s, %zd*s);\n\n",
        deg, m, (NSInteger)[[rows lastObject] count] / s, (NSInteger)[rows count] / s);
    fprintf(f, "    NSInteger j;\n");
    
    BOOL hasLine = NO;
    for (NSInteger b = 0; b < nBlocks;  b++)
    {
        NSInteger j = b * s;

        NSMutableArray* nonZeros = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [rows count]; i++) {
            if (![rows[i][j] isZero]) [nonZeros addObject:[NumInt numWithInt:i]];
        }
        if (![nonZeros count])
            continue;
        
        if (hasLine) fprintf(f, "    \n");
        
        switch (b) {
            case 0: fprintf(f, "    for (j = 0; j < s; j++)"); break;
            case 1: fprintf(f, "    for (j = s; j < 2*s; j++)"); break;
            default:fprintf(f, "    for (j = %zd*s; j < %zd*s; j++)", b, b+1); break;
        }
        fprintf(f, "\n    {\n");

        for (NumInt* ii in nonZeros) {
            fprintf(f, "        addTenToPos(diff, ");
            NSInteger i = [ii intValue];
            if ((i - j) % s == 0) {
                NSInteger d0 = (i - j) / s;
                if (i > j) {
                    if (d0 == 1) {
                        fprintf(f, "j+s");
                    } else {
                        fprintf(f, "j+%zd*s", d0);
                    }
                }
                if (i == j) fprintf(f, "j");
                if (i < j) {
                    if (d0 == -1) {
                        fprintf(f, "j-s");
                    } else {
                        fprintf(f, "j-%zd*s", -d0);
                    }
                }
            } else {
                fprintf(f, "(j+1)%%s");
                NSInteger i0 = i / s;
                if (i0 > 0) {
                    if (i0 == 1) {
                        fprintf(f, "+s");
                    } else {
                        fprintf(f, "+%zd*s", i0);
                    }
                }
            }
            fprintf(f, ", j, ");

            TenzorPair *p = [[[[rows objectAtIndex:i] objectAtIndex:j] content] firstObject];
            Tenzor *t = [p tenzor];
            
            IdxToFile([[[t leftComponent] startsWith] number], j, m, f, NO);
            IdxToFile([[[t leftComponent] endsWith] number], j, m, f, (s == 1 && [[t leftComponent] len] == 4));
            
            IdxToFile([[[t rightComponent] startsWith] number], j, -1, f, NO);
            IdxToFile([[[t rightComponent] endsWith] number], j, -1, f, (s == 1 && [[t rightComponent] len] == 4));
            
            fprintf(f, "%d);\n", ([p koef] > 0) ? 1 : -1);
        }
        fprintf(f, "    }\n");
        hasLine = YES;
    }

    fprintf(f, "}\n</pre>\n");

    FILE_CLOSE();
}

//---------------------------------------------------------------------------------
void printMatrix(Matrix *m) {
    NSInteger s = PathAlg.s;

    NSArray* rows = [m rows];

    FILE_OPEN();
    fprintf(f, "<table>");
#ifdef WITH_LINE_N
    fprintf(f, "<tr><td class='c_b_1 c_r_1'></td>");
    for (NSInteger j = 0; j < [[rows firstObject] count]; j++) {
        NSInteger cellLeft = 0;
        if (j > 0 && (j % s) == 0)
        {
            cellLeft = 1;
        }
        fprintf(f, "<td class='c_b_1 c_l_%d'>%d</td>", cellLeft, j);
    }
    fprintf(f, "</tr>");
#endif
    for (NSInteger i = 0; i < [rows count]; i++)
    {
        NSInteger cellTop = 0;
        if (i > 0 && (i % s) == 0) {
            cellTop = 1;
        }

        fprintf(f, "<tr>");
#ifdef WITH_LINE_N
        fprintf(f, "<td class='c_r_1 c_t_%d'>%d</td>", cellTop, i);
#endif
        NSArray* line = [rows objectAtIndex:i];
        for (NSInteger j = 0; j < [line count]; j++) {
            NSInteger cellLeft = 0;
            if (j > 0 && (j % s) == 0) {
                cellLeft = 1;
            }
            fprintf(f, "<td class='c_t_%zd c_l_%zd'", cellTop, cellLeft);
            Comb *c = [line objectAtIndex:j];
#ifdef KOEFS_ONLY
            BOOL ok = NO;
            if ([[c content] count] > 1) {
                fprintf(f, ">ERROR! (sz = %d)</td>", (NSInteger)[[c content] count]);
                ok = YES;
            }
            if (!ok && ![c isZero]) {
                fprintf(f, " width=20>%s</td>", ([[[[c content] firstObject] firstObject] intValue] > 0) ? "+" : "&minus;");
                ok = YES;
            }
            if (!ok && [c isPotential]) {
                fprintf(f, " width=20>&bull;</td>");
            } else {
                if (!ok) fprintf(f, " width=20>&nbsp;</td>");
            }
#else
            fprintf(f, ">%s</td>", c.htmlStr.UTF8String);
#endif
        }
        fprintf(f, "</tr>\n");
    }
    fprintf(f, "</table><p>");
    FILE_CLOSE();
}

