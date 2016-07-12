//
//  CALayer+YWCPauseAimate.h
//  MYQQmusic
//
//  Created by 袁武昌 on 16/7/9.
//  Copyright © 2016年 com.yuan900133. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (YWCPauseAimate)

// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;
@end
