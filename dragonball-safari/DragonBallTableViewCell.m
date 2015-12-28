//
//  DragonBallCellTableViewCell.m
//  dragonball-safari
//
//  Created by Wang, Ke on 12/27/15.
//  Copyright © 2015 Wang, Ke. All rights reserved.
//

#import "DragonBallTableViewCell.h"
#import "UserDefaultTool.h"

#define kDistanceLabelRightMargin 30
#define kFont [UIFont systemFontOfSize:15]
#define kNearTextColor [UIColor colorWithRed:(250)/255.0 green:(138)/255.0 blue:(108)/255.0 alpha:1.0]

@interface DragonBallTableViewCell ()

@property (nonatomic, assign) int isShocked;

@end

@implementation DragonBallTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.font = [UIFont systemFontOfSize:12];
        
        UILabel* distanceTextLabel = [[UILabel alloc]init];
        distanceTextLabel.font = kFont;
        [self addSubview:distanceTextLabel];
        self.distanceTextLabel = distanceTextLabel;
        [self setDistanceLabelWithText:@"千里之外" andColor:[UIColor grayColor]];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.bounds = CGRectMake(0, 0, 30, 30);
    
    CGFloat distanceLabelH = self.frame.size.height;
    CGFloat distanceLabelW = [self.distanceTextLabel.text sizeWithFont:kFont].width;
    CGFloat distanceLabelX = self.frame.size.width - distanceLabelW - kDistanceLabelRightMargin;
    CGFloat distanceLabelY = 0;
    self.distanceTextLabel.frame = CGRectMake(distanceLabelX, distanceLabelY, distanceLabelW, distanceLabelH);
}

-(void)setRowNum:(long)rowNum
{
    _rowNum = rowNum;
    
    self.textLabel.text = [NSString stringWithFormat:@"%ld星球", _rowNum];
    
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"dragonball_%ld", _rowNum]];
}


-(void)setDistanceLabelWithText:(NSString *)text andColor:(UIColor *)color
{
    self.distanceTextLabel.text = text;
    self.distanceTextLabel.textColor = color;
}

-(void)thereIsANearBeacon
{
    if (!self.isShocked) {
        //通知代理
        if ([self.delegate respondsToSelector:@selector(CellDidCheckCloseToABall)]) {
            [self.delegate CellDidCheckCloseToABall];
        }
        
        self.isShocked = 1;
    }
    
}
@end
