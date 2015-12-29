//
//  SafariViewController.m
//  dragonball-safari
//
//  Created by Wang, Ke on 12/24/15.
//  Copyright © 2015 Wang, Ke. All rights reserved.
//

#import "SafariViewController.h"
#import "DragonBallTableViewCell.h"
#import "PulsingHaloLayer.h"
#import "BRTBeaconSDK.h"
#import "UserDefaultTool.h"
#import <AudioToolbox/AudioToolbox.h>
#import "DragonMovieViewController.h"

#define DEFAULT_UUID @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"

SystemSoundID sound;

@interface SafariViewController () <UITableViewDelegate, UITableViewDataSource, SafariViewCellDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *mobileImage;
@property (weak, nonatomic) IBOutlet UILabel *ballNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLaber;
@property (weak, nonatomic) IBOutlet UITableView *dragonBallTableView;
@property (weak, nonatomic) PulsingHaloLayer *haloLayer;

@property (nonatomic, assign) unsigned long nowRow;
@property (nonatomic, strong) NSArray *beacons;
@property (nonatomic, strong) BRTBeacon *topViewBeacon;

@end

@implementation SafariViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup HaloLayer
    [self addHalo];
    
    // Init table view
    self.dragonBallTableView.dataSource = self;
    self.dragonBallTableView.delegate = self;
    
    // Start monitoring and ranging
    [self startToFindBeacons];
    [self setUpAudioPlay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)addHalo{
    self.haloLayer = [PulsingHaloLayer layer];
    [self.topView.layer insertSublayer:self.haloLayer below:self.mobileImage.layer];
    
    self.haloLayer.position = self.mobileImage.center;
}

# pragma mark - Set table content
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* Cellidentifier = [NSString stringWithFormat:@"CellIdentifier%ld", indexPath.row+1];
    
    DragonBallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    if (cell == nil) {
        cell = [[DragonBallTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidentifier];
    }
    
    //设置Cell数据
    cell.delegate = self;
    cell.rowNum = indexPath.row + 1;
    
    cell.beacon = nil;
    
    if (self.beacons.count > 0) {
        //有beacon
        for(BRTBeacon *beacon in self.beacons)
        {
            if ([beacon.minor longValue] == cell.rowNum) {
                cell.beacon = beacon;
            }
        }
        
    }
    //返回cell
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    self.nowRow = indexPath.row;
    self.ballNumberLabel.text = [NSString stringWithFormat:@"%ld星球",indexPath.row + 1];
}

//以下为developer测试用重置数据代码
- (IBAction)mobileImageClick:(id)sender {
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"重置会导致所有你使用此应用的数据永久删除,你真的要重置吗？" delegate:self cancelButtonTitle:@"不重置" destructiveButtonTitle:@"继续重置" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex!=[actionSheet cancelButtonIndex]) {
        //重置数据
        [UserDefaultTool resetUserDefaultData];
    }
}

# pragma mark - 开始监测Beacon
- (void)startToFindBeacons{
    [BRTBeaconSDK startRangingWithUuids:@[[[NSUUID alloc] initWithUUIDString:DEFAULT_UUID]] onCompletion:^(NSArray *beacons, BRTBeaconRegion *region, NSError *error){
        if (!error) {
            [self reloadData:beacons];
        }
    }];
}

- (void)reloadData:(NSArray *)beacons{
    self.beacons = beacons;
    [self.dragonBallTableView reloadData];
    [self setTopViewData];
    [self checkFoundBall];
}

// 监控选择龙珠的距离
-(void)setTopViewData
{
    self.topViewBeacon = nil;
    
    if (self.beacons.count > 0) {
        for (BRTBeacon * beacon in self.beacons) {
            if ([beacon.minor longValue] == self.nowRow + 1) {
                self.topViewBeacon = beacon;
            }
        }
        
    }
    [self setTopViewDistance];
}

- (void)setTopViewDistance{
    if (self.topViewBeacon == nil) {
        self.distanceLaber.text = @"?  ?  ?";
    }else
    {
        self.distanceLaber.text = ([self.topViewBeacon.distance floatValue] > 10) ? @">10m" : [NSString stringWithFormat:@"%.1f m",[self.topViewBeacon.distance floatValue]];
    }
}

// 找到龙珠
-(void)checkFoundBall
{
    for (BRTBeacon* beacon in self.beacons) {
        if ([beacon.distance floatValue] < 0.3) {
            NSMutableArray* array = [UserDefaultTool nowFoundBallsMutableArray];
            
            if ([[array objectAtIndex:[beacon.minor intValue] - 1] isEqual:@(0)]) {
                [array setObject:@(1) atIndexedSubscript:[beacon.minor intValue] - 1];
                [UserDefaultTool setUserDefaultDataWithArray:array];
                [self AfterFindABallCallBack:[beacon.minor intValue]];
            }
        }
    }
}

-(void)AfterFindABallCallBack:(int)minor
{
    if ([UserDefaultTool nowFoundBallsCount] == 7) {
        //召唤神龙
        [self callTheDragon];
    }else{
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"恭喜你" message:[NSString stringWithFormat:@"找到%d星球啦",minor] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
        [self callTheDragon];
    }
}

-(void)setUpAudioPlay
{
    //初始化SoundId
    NSString* path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/sms-received3.caf"];
    if (path) {
        
        NSURL* url = [NSURL fileURLWithPath:path];
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &sound);
        if (error!=kAudioServicesNoError) {
            sound = 0;
        }
    }
}

- (void)CellDidCheckCloseToABall{
    /**播放音频**/
    AudioServicesPlaySystemSound(sound);
}

-(void)callTheDragon
{
    DragonMovieViewController* dC = [[DragonMovieViewController alloc]init];
    [self presentViewController:dC animated:YES completion:nil];
}

@end
