//
//  RJBDrawView.h
//  BezierPathDrawView
//
//  Created by ru on 2018/4/14.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import <UIKit/UIKit.h>

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
 */
- (void)rjb_lineBarChartWithNameArr:(NSArray *)nameArr valueArr:(NSArray *)valueArr;

@end
