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
    
    
  
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//      [self.drawView rjb_drawPieChartWithNameArr:self.nameArr valueArr:self.valueArr];
    [self.drawView rjb_drawBarChartWithNameArr:self.nameArr valueArr:self.valueArr];
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
