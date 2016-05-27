//
//  ViewController.m
//  VR_Demo
//
//  Created by 苟应航 on 16/5/27.
//  Copyright © 2016年 gouhang. All rights reserved.
//

#import "ViewController.h"
#import <GVRVideoView.h>
@interface ViewController ()<GVRVideoViewDelegate>

@property (strong, nonatomic) IBOutlet GVRVideoView *VRView;

@end


@implementation ViewController{
    BOOL _isPaused;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    _VRView.delegate=self;
    //  支持全屏按钮
    _VRView.enableFullscreenButton=YES;
    //    使纸板按钮
    _VRView.enableCardboardButton=YES;
    
    _isPaused=NO;
    
    NSString *str=[[NSBundle mainBundle] pathForResource:@"congo" ofType:@"mp4"];
//        [_VRView loadFromUrl:[[NSURL alloc] initFileURLWithPath:str]];
   [_VRView loadFromUrl:[NSURL URLWithString:@"http://111.202.11.133/xdispatch/dl.mojing.cn/xianchang/160524/1464090811_37_3840HD.mp4"]];
}

- (void)widgetViewDidTap:(GVRWidgetView *)widgetView {
    if (_isPaused) {
        [_VRView resume];//继续播放视频
    } else {
        [_VRView pause];//暂停视频
    }
    _isPaused = !_isPaused;
}

- (void)widgetView:(GVRWidgetView *)widgetView didLoadContent:(id)content {
    
    NSLog(@"完成视频加载");
    
}

- (void)widgetView:(GVRWidgetView *)widgetView
didFailToLoadContent:(id)content
  withErrorMessage:(NSString *)errorMessage {
    
    NSLog(@"视频加载错误: %@", errorMessage);
    
}
// * *时调用视频回放的头的位置变化。
- (void)videoView:(GVRVideoView*)videoView didUpdatePosition:(NSTimeInterval)position {
    // Loop the video when it reaches the end.
    if (position == videoView.duration) {
        [_VRView seekTo:0];
        [_VRView resume];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
