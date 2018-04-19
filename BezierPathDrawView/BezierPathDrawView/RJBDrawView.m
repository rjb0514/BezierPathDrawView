//
//  RJBDrawView.m
//  BezierPathDrawView
//
//  Created by ru on 2018/4/14.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import "RJBDrawView.h"


#define RJBX_MARGIN    30   //X轴的间隔
#define RJBY_MARGIN    20   // y轴每一个值的间隔数

@implementation RJBDrawView

//dev分支加个注释
#pragma mark - 绘制饼状图

/** 绘制饼状图
 nameArr:  名称数组
 valueArr: 数值数组
 */
- (void)rjb_drawPieChartWithNameArr:(NSArray *)nameArr valueArr:(NSArray *)valueArr {
    
    //设置圆点 问self的中心
    CGPoint centerP = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    //开始角度
    __block CGFloat startAngle = 0;
    //结束的角度
    __block CGFloat endAngle  = 0;
    //圆形半径
    CGFloat radius = 100;
    
    //求总值
    __block CGFloat sumValue = 0;
    [valueArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        sumValue += [obj floatValue];
    }];
    
    [valueArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        
        //求结束的角度
        endAngle = ([obj floatValue]/sumValue) * M_PI *2 + startAngle;
        
        
        //创建贝塞尔曲线
        UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        [bezier addLineToPoint:centerP];
        [bezier closePath];
        
        
        CAShapeLayer *shape = [CAShapeLayer new];
        shape.path = bezier.CGPath;
        shape.fillColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;
        shape.lineWidth = 1;
        [self.layer addSublayer:shape];
        
        
        
        //创建名称label
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = nameArr[idx];
        nameLabel.textColor = [UIColor blackColor];
        CGFloat x = centerP.x + 120 * cosf(startAngle + (endAngle - startAngle)/2);
        CGFloat y = centerP.y + 120 * sinf(startAngle + (endAngle - startAngle)/2);
        [nameLabel sizeToFit];
        nameLabel.center = CGPointMake(x, y);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        
        
        //下一次的开始角度 为上一次的结束
        startAngle = endAngle;
        
    }];
    
    
    
}

#pragma mark - 绘制柱状图

/** 绘制柱状图
 nameArr:  名称数组
 valueArr: 数值数组
 */
- (void)rjb_drawBarChartWithNameArr:(NSArray *)nameArr valueArr:(NSArray *)valueArr {
    
    //绘制坐标轴
    [self drawAxes:nameArr];
    
    //2.每一个目标值点坐标
    [valueArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat doubleValue = 2*[valueArr[idx] floatValue]; //目标值放大两倍
        CGFloat X = RJBX_MARGIN + RJBX_MARGIN*(idx+1)+5;
        CGFloat Y = CGRectGetHeight(self.frame)-RJBY_MARGIN-doubleValue;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(X-RJBX_MARGIN/2, Y, RJBX_MARGIN-10, doubleValue)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;;
        shapeLayer.borderWidth = 2.0;
        [self.layer addSublayer:shapeLayer];
        
        //3.添加文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X-RJBX_MARGIN/2, Y-20, RJBX_MARGIN-10, 20)];
        label.text = [NSString stringWithFormat:@"%.0lf",(CGRectGetHeight(self.frame)-Y-RJBX_MARGIN)/2];
        label.textColor = [UIColor purpleColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
    }];
    
    
}
#pragma mark - 绘制折线图

/** 绘制折线图
 nameArr:  名称数组
 valueArr: 数值数组
 type:  连接线  是曲线 还是直线
 */
- (void)rjb_lineChartWithNameArr:(NSArray *)nameArr valueArr:(NSArray *)valueArr type:(RJBDrawViewType)type{
    
    [self drawAxes:nameArr];
    
    
    NSMutableArray *pointArr = [NSMutableArray array];
    
    //2.每一个目标值点坐标
    [valueArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat doubleValue = 2*[valueArr[idx] floatValue]; //目标值放大两倍
        CGFloat X = RJBX_MARGIN + RJBX_MARGIN*(idx+1)+5;
        CGFloat Y = CGRectGetHeight(self.frame)-RJBY_MARGIN-doubleValue;
        CGPoint point = CGPointMake(X,Y);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(X - 2.5, Y - 2.5, 5, 5) cornerRadius:2.5];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;;
        shapeLayer.borderWidth = 2.0;
        [self.layer addSublayer:shapeLayer];
        [pointArr addObject:[NSValue valueWithCGPoint:point]];
        
        
        //3.添加文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X-RJBX_MARGIN/2, Y-20, RJBX_MARGIN-10, 20)];
        label.text = [NSString stringWithFormat:@"%.0lf",(CGRectGetHeight(self.frame)-Y-RJBX_MARGIN)/2];
        label.textColor = [UIColor purpleColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
    }];
    
    
    //绘制直线或者曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[pointArr[0] CGPointValue]];
    [pointArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        
        if (type == RJBDrawViewTypeLine) {
            //直线
            CGPoint point = [pointArr[idx] CGPointValue];
            [path addLineToPoint:point];
        }else {
            //曲线
            static CGPoint PrePonit ;
            if (idx == 0) {
                PrePonit = [obj CGPointValue];
            }else{
                CGPoint NowPoint = [obj CGPointValue];
                [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((PrePonit.x+NowPoint.x)/2, PrePonit.y) controlPoint2:CGPointMake((PrePonit.x+NowPoint.x)/2, NowPoint.y)]; //三次曲线
                PrePonit = NowPoint;
            }
        }
      
    }];
    
    
    //for 循环 和 Block 遍历的 局部变量要注意 释放问题
    
//    for (NSInteger idx = 0; idx < pointArr.count; idx++) {
//        //曲线
//         CGPoint PrePonit ;
//        if (idx == 0) {
//            PrePonit = [pointArr[idx] CGPointValue];
//        }else{
//            CGPoint NowPoint = [pointArr[idx] CGPointValue];
//            [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((PrePonit.x+NowPoint.x)/2, PrePonit.y) controlPoint2:CGPointMake((PrePonit.x+NowPoint.x)/2, NowPoint.y)]; //三次曲线
//            //            [path addCurveToPoint:NowPoint controlPoint1:CGPointMake(PrePonit.x+(NowPoint.x - PrePonit.x)/2, PrePonit.y) controlPoint2:CGPointMake(PrePonit.x+(NowPoint.x - PrePonit.x)/2, NowPoint.y)]; //三次曲线
//            PrePonit = NowPoint;
//        }
//    }
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer];
    
}

#pragma mark - 绘制扇形图
/** 绘制扇形图
 nameArr:  名称数组
 valueArr: 数值数组
 */
- (void)rjb_lineFanChartWithNameArr:(NSArray *)nameArr valueArr:(NSArray *)valueArr {
    
    __block CGFloat sumValue = 0;
    [valueArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        sumValue += [obj floatValue];
    }];
    
//    NSArray<UIColor *> *colorArr = @[[UIColor redColor],[UIColor blueColor],[UIColor yellowColor]];
    
    
    NSMutableArray<CAShapeLayer *> *layersArr = [NSMutableArray array];
    
    __block CGFloat start = 0;
    [valueArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CGFloat end = obj.floatValue / sumValue * M_PI * 2 + start;
        
        CGPoint arcCenter = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
        CGFloat radius = self.frame.size.width / 2.0 - 80;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:start endAngle:end clockwise:YES];
        CAShapeLayer *shap = [CAShapeLayer layer];
        shap.lineWidth = 80;
        
//        if (idx < colorArr.count) {
//            shap.strokeColor = colorArr[idx].CGColor;
//        }else {
//            shap.strokeColor = [UIColor purpleColor].CGColor;
//        }
        shap.strokeColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;
        
        shap.fillColor = [UIColor clearColor].CGColor;
        shap.path = path.CGPath;
        shap.strokeEnd = 0;
        [self.layer addSublayer:shap];
        [layersArr addObject:shap];
        
        //创建名称label
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = nameArr[idx];
        nameLabel.textColor = [UIColor blackColor];
        CGFloat x = arcCenter.x + (radius + 20) * cosf(start + (end - start)/2);
        CGFloat y = arcCenter.y + (radius + 20) * sinf(start + (end - start)/2);
        [nameLabel sizeToFit];
        nameLabel.center = CGPointMake(x, y);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        
        
        //这次的结束是下次的开始
        start = end;
        
        
        
    }];
    
    
    //动画
    [layersArr enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        //添加动画
        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        anima.duration = 1.5;
        anima.fromValue = @0;
        anima.toValue = @1;
        anima.removedOnCompletion = NO;
        anima.fillMode = kCAFillModeForwards;
        CFTimeInterval time =  [obj convertTime:CACurrentMediaTime() fromLayer:nil];
        
        anima.beginTime = time + 1.5 * idx;
        
        [obj addAnimation:anima forKey:nil];
        
    }];
    
    
    
    
    
}

/** 绘制坐标轴 */
- (void)drawAxes:(NSArray *)nameArr {
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    //1.绘制X 轴
    [bezier moveToPoint:CGPointMake(RJBX_MARGIN, CGRectGetHeight(self.frame) - RJBY_MARGIN)];
    [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) - 2 * RJBX_MARGIN, CGRectGetHeight(self.frame) - RJBY_MARGIN)];
    //箭头
    [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) - 2 * RJBX_MARGIN - 5, CGRectGetHeight(self.frame) - RJBY_MARGIN - 5)];
     [bezier moveToPoint:CGPointMake(CGRectGetWidth(self.frame) - 2 * RJBX_MARGIN , CGRectGetHeight(self.frame) - RJBY_MARGIN )];
    [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) - 2 * RJBX_MARGIN - 5, CGRectGetHeight(self.frame) - RJBY_MARGIN + 5)];
    
    //1.绘制Y 轴
    [bezier moveToPoint:CGPointMake(RJBX_MARGIN, CGRectGetHeight(self.frame) - RJBY_MARGIN)];
    [bezier addLineToPoint:CGPointMake(RJBX_MARGIN, RJBY_MARGIN)];
    //箭头
    [bezier addLineToPoint:CGPointMake(RJBX_MARGIN - 5, RJBY_MARGIN + 5)];
    [bezier moveToPoint:CGPointMake(RJBX_MARGIN, RJBY_MARGIN)];
    [bezier addLineToPoint:CGPointMake(RJBX_MARGIN + 5, RJBY_MARGIN + 5)];
    
    
    //添加X轴的 索引
    [nameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CGFloat x = RJBX_MARGIN + RJBX_MARGIN * (idx + 1);
        CGFloat y = CGRectGetHeight(self.frame) - RJBY_MARGIN;
        [bezier moveToPoint:CGPointMake(x, y)];
        [bezier addLineToPoint:CGPointMake(x, y - 3)];
        
    }];
    
    //绘制Y轴 按最大100的绘制
    for(NSInteger i = 0;i < 11;i ++) {
        CGFloat x = RJBX_MARGIN ;
        CGFloat y = CGRectGetHeight(self.frame) - RJBY_MARGIN - RJBY_MARGIN *(i);
        [bezier moveToPoint:CGPointMake(x, y)];
        [bezier addLineToPoint:CGPointMake(x-3, y)];
    }
    
    
    //添加文字索引

    //x轴索引
    [nameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat X = RJBX_MARGIN + 15 + RJBX_MARGIN*idx;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, CGRectGetHeight(self.frame)-RJBY_MARGIN , RJBX_MARGIN, 20)];
        textLabel.text = obj;
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor blueColor];
        [self addSubview:textLabel];

    }];
    
    //y轴索引
    for(NSInteger i = 0;i < 11;i ++) {
        CGFloat X = RJBX_MARGIN - 20;
        CGFloat y = CGRectGetHeight(self.frame) - RJBY_MARGIN - RJBY_MARGIN *i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, y , RJBX_MARGIN, 20)];
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor blueColor];
        textLabel.text = [NSString stringWithFormat:@"%zd",10*i];
        [self addSubview:textLabel];
        textLabel.center = CGPointMake(X, y);
    }
    
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    
    shape.lineWidth = 1;
    shape.strokeColor = [UIColor blackColor].CGColor;
//    shape.fillColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0].CGColor;
    shape.fillColor = [UIColor clearColor].CGColor;
    shape.path = bezier.CGPath;
    
    [self.layer addSublayer:shape];
    
}


@end
