//
//  PickerViewController.m
//  dragonball-safari
//
//  Created by Wang, Ke on 12/24/15.
//  Copyright © 2015 Wang, Ke. All rights reserved.
//

#import "PickerViewController.h"
#import "UserDefaultTool.h"

@interface PickerViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *dragonFragImage1;
@property (weak, nonatomic) IBOutlet UIImageView *dragonFragImage2;
@property (weak, nonatomic) IBOutlet UIImageView *dragonFragImage3;
@property (weak, nonatomic) IBOutlet UIImageView *dragonFragImage4;
@property (weak, nonatomic) IBOutlet UIImageView *dragonFragImage5;
@property (weak, nonatomic) IBOutlet UIImageView *dragonFragImage6;
@property (weak, nonatomic) IBOutlet UIImageView *dragonFragImage7;

@property (nonatomic, retain) NSArray *dragonFragImages;

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpCurrentDragonFragment];
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

- (void)setUpCurrentDragonFragment{
    self.dragonFragImages = @[_dragonFragImage1,
                              _dragonFragImage2,
                              _dragonFragImage3,
                              _dragonFragImage4,
                              _dragonFragImage5,
                              _dragonFragImage6,
                              _dragonFragImage7
                              ];
    NSArray* array = [UserDefaultTool nowFoundBallsArray];
    for (int i = 0 ; i < array.count; i++) {
        NSNumber* isFound = [array objectAtIndex:i];
        UIImageView* dragonView = self.dragonFragImages[i];
        if ([isFound isEqual:@(1)]) {
            dragonView.hidden = NO;
        }
    }
}
@end
