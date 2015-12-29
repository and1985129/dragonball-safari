//
//  DragonBallCellTableViewCell.h
//  dragonball-safari
//
//  Created by Wang, Ke on 12/27/15.
//  Copyright © 2015 Wang, Ke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BRTBeacon;

@protocol SafariViewCellDelegate <NSObject>
@optional
-(void)CellDidCheckCloseToABall;
@end

@interface DragonBallTableViewCell : UITableViewCell

@property (nonatomic,weak) UILabel* distanceTextLabel;
@property (nonatomic, assign) long rowNum;
@property (nonatomic,weak) id<SafariViewCellDelegate> delegate;

@property (nonatomic, strong) BRTBeacon *beacon;

@end
