//
//  HSCircularProgressIndicator.m
//  HSCircularProgressIndicator
//
//  Created by huashan on 16/7/26.
//  Copyright © 2016年 LiHuashan. All rights reserved.
//

#import "HSCircularProgressIndicator.h"

#define ANIMATION_DURATION 1.0

@interface HSCircularProgressIndicator ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation HSCircularProgressIndicator

#pragma mark - 懒加载
- (CAShapeLayer *)shapeLayer {
    
    if (!_shapeLayer) {
        
        _shapeLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_shapeLayer];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [UIColor blueColor].CGColor;
        _shapeLayer.lineWidth = 5.0;
        _shapeLayer.strokeEnd = 0.0;
        _shapeLayer.path = [self circlePathWithRadius:25.0];
    }
    
    return _shapeLayer;
}

#pragma mark - 创建_shapeLayer对象的路径
- (CGPathRef)circlePathWithRadius:(CGFloat)radius {
    
    return [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES].CGPath;
}

#pragma mark - setter方法：展示图片的实时下载进度
- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    
    if (progress > 1.0) {
        
        self.shapeLayer.strokeEnd = 1.0;
    
    }else if (progress < 0.0) {
        
        self.shapeLayer.strokeEnd = 0.0;
    
    }else {
        
        self.shapeLayer.strokeEnd = progress;
    }
}

#pragma mark - reveal动画
- (void)revealAnimation {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.shapeLayer removeAllAnimations];
    [_shapeLayer removeFromSuperlayer];
    self.superview.layer.mask = _shapeLayer;
    _shapeLayer.strokeEnd = 1.0;
    
    CGFloat selfHalfWidth = self.frame.size.width * 0.5;
    CGFloat selfHalfHeight = self.frame.size.height * 0.5;
    CGFloat circumscribedCircleRadius = sqrt(selfHalfWidth * selfHalfWidth + selfHalfHeight * selfHalfHeight);
    CABasicAnimation *pathBasicAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathBasicAnimation.toValue = (__bridge id _Nullable)([self circlePathWithRadius:circumscribedCircleRadius]);
    
    CGFloat finalLineWidth = 2 * circumscribedCircleRadius;
    CABasicAnimation *lineWidthBasicAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthBasicAnimation.toValue = @(finalLineWidth);
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.animations = @[pathBasicAnimation, lineWidthBasicAnimation];
    animationGroup.duration = ANIMATION_DURATION;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    [_shapeLayer addAnimation:animationGroup forKey:@"myAnimationGroup"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
        
    [self.shapeLayer removeAllAnimations];
    self.superview.layer.mask = nil;
}

#pragma mark - 重置
- (void)reset {
    
    if (!self.shapeLayer.superlayer) {
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        _shapeLayer.strokeEnd = 0.0;
        [CATransaction commit];
        
        [self.layer addSublayer:_shapeLayer];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
