//
//  HSCircularProgressIndicator.h
//  HSCircularProgressIndicator
//
//  Created by huashan on 16/7/26.
//  Copyright © 2016年 LiHuashan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSCircularProgressIndicator : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)revealAnimation;

- (void)reset;

@end
