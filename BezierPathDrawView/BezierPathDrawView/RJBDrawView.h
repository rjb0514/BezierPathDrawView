//
//  RJBDrawView.h
//  BezierPathDrawView
//
//  Created by ru on 2018/4/14.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    RJBDrawViewTypeLine,   //直线
    RJBDrawViewTypeCurve,   //曲线
} RJBDrawViewType;

@interface RJBDrawView : UIView


/** 绘制饼状图
 nameArr:  名称数组
 valueArr: 数值数组
 */
- (void)rjb_drawPieChartWithNameArr:(NSArray *)nameArr valueArr:(NSArray *)valueArr;


/** 绘制柱状图
 nameArr:  名称数组
 valueArr: 数值数组
 */
- (void)rjb_drawBarChartWithNameArr:(NSArray *)nameArr valueArr:(NSArray *)valueArr;

/** 绘制折线图
 nameArr:  名称数组
 valueArr: 数值数组
 type:  连接线  是曲线 还是直线
 */
- (void)rjb_lineChartWithNameArr:(NSArray *)nameArr valueArr:(NSArray *)valueArr type:(RJBDrawViewType)type;


/** 绘制扇形图
 nameArr:  名称数组
 valueArr: 数值数组
 */
- (void)rjb_lineFanChartWithNameArr:(NSArray *)nameArr valueArr:(NSArray *)valueArr;

@end
