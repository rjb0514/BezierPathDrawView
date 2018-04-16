//
//  DrawViewController.m
//  BezierPathDrawView
//
//  Created by ru on 2018/4/14.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import "DrawViewController.h"
#import "RJBDrawView.h"

@interface DrawViewController ()

@property (nonatomic, strong) RJBDrawView *drawView;

/** 名字数组 */
@property (nonatomic, strong) NSArray *nameArr;

/** 名字对应值的数组 */
@property (nonatomic, strong) NSArray *valueArr;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.drawView];
    self.drawView.center = self.view.center;
    
    
    switch (self.drawType) {
        case DrawViewTypePieChart:
        {
            //饼状图
            [self.drawView rjb_drawPieChartWithNameArr:self.nameArr valueArr:self.valueArr];
        }
            break;
        case DrawViewTypeBarChart:
        {
            //柱状图
            [self.drawView rjb_drawBarChartWithNameArr:self.nameArr valueArr:self.valueArr];
            
        }
            break;
        case DrawViewTypeLineChart:
        {
            //折线图
            [self.drawView rjb_lineChartWithNameArr:self.nameArr valueArr:self.valueArr type:RJBDrawViewTypeLine];
        }
            break;
        case DrawViewTypeLineChartCurve:
        {
            //折线图-曲线
            [self.drawView rjb_lineChartWithNameArr:self.nameArr valueArr:self.valueArr type:RJBDrawViewTypeCurve];
            
        }
            break;
        case DrawViewTypeFanChar:
        {
            //扇形图
            [self.drawView rjb_lineFanChartWithNameArr:self.nameArr valueArr:self.valueArr];
            
        }
            break;
            
        default:
            break;
    }
    
  
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//      [self.drawView rjb_drawPieChartWithNameArr:self.nameArr valueArr:self.valueArr];
//    [self.drawView rjb_drawBarChartWithNameArr:self.nameArr valueArr:self.valueArr];
//    [self.drawView rjb_lineBarChartWithNameArr:self.nameArr valueArr:self.valueArr];
    [self.drawView rjb_lineFanChartWithNameArr:self.nameArr valueArr:self.valueArr];
}

#pragma mark -  lazy
- (RJBDrawView *)drawView {
    if (!_drawView) {
        _drawView = [[RJBDrawView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
        _drawView.backgroundColor = [UIColor grayColor];
    }
    return _drawView;
}

- (NSArray *)nameArr {
    if (!_nameArr) {
        _nameArr = @[@"数学",@"语文",@"英语",@"政治",@"历史",@"物理"];
    }
    return _nameArr;
}

- (NSArray *)valueArr {
    if (!_valueArr) {
        _valueArr = @[@"20",@"40",@"20",@"50",@"30",@"90"];
    }
    return _valueArr;
}



@end
