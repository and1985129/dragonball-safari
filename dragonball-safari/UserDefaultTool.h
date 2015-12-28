//
//  UserDefaultTool.h
//  dragonball-safari
//
//  Created by Wang, Ke on 12/27/15.
//  Copyright © 2015 Wang, Ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultTool : NSObject

+(void)initUserDefaultData;
+(void)resetUserDefaultData;
+(int)nowFoundBallsCount;
+(void)setUserDefaultDataWithArray:(NSArray *)array;
+(NSMutableArray *)nowFoundBallsMutableArray;
+(NSArray *)nowFoundBallsArray;

@end
