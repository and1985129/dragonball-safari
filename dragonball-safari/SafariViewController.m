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

@interface SafariViewController () <UITableViewDelegate, UITableViewDataSource, SafariViewCellDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *mobileImage;
@property (weak, nonatomic) IBOutlet UILabel *ballNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLaber;
@property (weak, nonatomic) IBOutlet UITableView *dragonBallTableView;
@property (weak, nonatomic) PulsingHaloLayer *haloLayer;

@property (nonatomic, assign) unsigned long nowRow;

@end

@implementation SafariViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup HaloLayer
    [self addHalo];
    
    // Init table view
    self.dragonBallTableView.dataSource = self;
    self.dragonBallTableView.delegate = self;
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
    NSString* Cellidentifier = [NSString stringWithFormat:@"CellIdentifier%d", indexPath.row+1];
    
    DragonBallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    if (cell == nil) {
        cell = [[DragonBallTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidentifier];
    }
    
    //设置Cell数据
    cell.delegate = self;
    cell.rowNum = indexPath.row + 1;
    
    //返回cell
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    self.nowRow = indexPath.row;
    self.ballNumberLabel.text = [NSString stringWithFormat:@"%d星球",indexPath.row + 1];
}

//以下为developer测试用重置数据代码
- (IBAction)mobileImageClick:(id)sender {
}

@end
