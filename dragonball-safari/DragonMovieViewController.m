//
//  DragonMovieViewController.m
//  dragonball-safari
//
//  Created by Wang, Ke on 12/29/15.
//  Copyright © 2015 Wang, Ke. All rights reserved.
//

#import "DragonMovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DragonMovieViewController ()

@property (nonatomic, strong) MPMoviePlayerController *movie;

@end

@implementation DragonMovieViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpMoviePlay];
}

-(void)setUpMoviePlay
{
    //找到文件路径
    NSString* path = [[NSBundle mainBundle]pathForResource:@"dragon_appear" ofType:@"MP4"];
    NSURL* url = [NSURL fileURLWithPath:path];
    
    //
    MPMoviePlayerController* movC = [[MPMoviePlayerController alloc]initWithContentURL:url];
    movC.controlStyle = MPMovieControlStyleNone;
    movC.scalingMode = MPMovieScalingModeAspectFill;
    movC.view.frame=self.view.bounds;
    [self.view addSubview:movC.view];
    self.movie = movC;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dragonMovieFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:movC];
    [movC play];
    
    
}

-(void)dragonMovieFinished:(NSNotification *)notify
{
    //视频播放对象
    MPMoviePlayerController* theMovie = [notify object];
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    [theMovie.view removeFromSuperview];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"恭喜恭喜恭喜你" message:@"你已经成功召唤神龙!" delegate:nil cancelButtonTitle:@"噢耶" otherButtonTitles:nil, nil];
    
    [alertView show];
    
    
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

@end
