//
//  CALayer+YWCPauseAimate.m
//  MYQQmusic
//
//  Created by 袁武昌 on 16/7/9.
//  Copyright © 2016年 com.yuan900133. All rights reserved.
//

#import "CALayer+YWCPauseAimate.h"

@implementation CALayer (YWCPauseAimate)



- (void)pauseAnimate
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)resumeAnimate
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    
    CFTimeInterval timeSincePase = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePase;
}
@end
