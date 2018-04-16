//
//  DrawViewController.h
//  BezierPathDrawView
//
//  Created by ru on 2018/4/14.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import "BaseViewController.h"


typedef enum : NSUInteger {
    DrawViewTypePieChart,   //饼状图
    DrawViewTypeBarChart,  //柱状图
    DrawViewTypeLineChart,    //折线图
    DrawViewTypeLineChartCurve,    //折线图-曲线
    DrawViewTypeFanChar,    //扇形图
} DrawViewType;

@interface DrawViewController : BaseViewController


/** 绘图类型 */
@property (nonatomic, assign) DrawViewType drawType;

@end
