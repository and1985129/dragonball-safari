//
//  UserDefaultTool.m
//  dragonball-safari
//
//  Created by Wang, Ke on 12/27/15.
//  Copyright © 2015 Wang, Ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDefaultTool.h"

@implementation UserDefaultTool

+(void)initUserDefaultData
{
    if ([[NSUserDefaults standardUserDefaults]arrayForKey:@"found_balls"] == nil) {
        NSArray* zeroArray = [NSArray arrayWithObjects:@(0),@(0),@(0),@(0),@(0),@(0),@(0), nil];
        [[NSUserDefaults standardUserDefaults]setObject:zeroArray forKey:@"found_balls"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(void)resetUserDefaultData
{
    NSArray* zeroArray = [NSArray arrayWithObjects:@(0),@(0),@(0),@(0),@(0),@(0),@(0), nil];
    [[NSUserDefaults standardUserDefaults]setObject:zeroArray forKey:@"found_balls"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"重置成功" message:@"所有数据已经回到初始状态" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alertView show];
}

+(void)setUserDefaultDataWithArray:(NSArray *)array
{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"found_balls"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(int)nowFoundBallsCount
{
    NSArray* array = [[NSUserDefaults standardUserDefaults]arrayForKey:@"found_balls"];
    int found_count = 0;
    for (NSNumber* isFound in array) {
        if ([isFound isEqual:@(1)]) {
            found_count ++;
        }
    }
    
    return found_count;
}

+(NSArray *)nowFoundBallsArray
{
    
    return [[NSUserDefaults standardUserDefaults]arrayForKey:@"found_balls"];
}


+(NSMutableArray *)nowFoundBallsMutableArray
{
    return [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"found_balls"]];
    
}

@end
