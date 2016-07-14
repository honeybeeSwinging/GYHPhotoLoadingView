//
//  CircleLoadingViewController.m
//  GYHPhotoLoadingView
//
//  Created by 范英强 on 16/7/13.
//  Copyright © 2016年 gyh. All rights reserved.
//

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#import "CircleLoadingViewController.h"
#import "GYHCircleLoadingView.h"
#import "UIImageView+WebCache.h"

@interface CircleLoadingViewController ()
@property (strong, nonatomic) IBOutlet UIImageView      *imgV;
@property (strong, nonatomic) GYHCircleLoadingView      *circleLoadingV;
@end

@implementation CircleLoadingViewController


- (GYHCircleLoadingView *)circleLoadingV
{
    if (!_circleLoadingV) {
        _circleLoadingV = [[GYHCircleLoadingView alloc]initWithViewFrame:CGRectMake((SCREEN_WIDTH - 40)/2,(SCREEN_HEIGHT - 40)/2, 40, 40)];
        [self.view addSubview:_circleLoadingV];
    }
    return _circleLoadingV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    [self.circleLoadingV startAnimating];
    
    __weak __typeof__(self) block_self = self;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/gaoyuhang/DayDayNews/master/photo/newsfresh.png"] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = fabs(receivedSize/((CGFloat)expectedSize));
        block_self.circleLoadingV.progress = progress;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"此处应该弹框提示,并且隐藏progressV");
        }
        [block_self.circleLoadingV stopAnimating];
    }];
}

@end