//
//  Created by M on 01.02.16.
//
//

#import <Foundation/Foundation.h>

@class HHElem;

@interface ShiftHHAlg : NSObject

//
// Perform one shift
//
+ (NSInteger)shiftHHElem:(HHElem *)hh
              type:(NSInteger)type
            degree:(NSInteger)degree
             shift:(NSInteger)shift
            result:(HHElem *)hh_shift;

@end
