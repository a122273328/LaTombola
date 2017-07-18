//
//  ViewController.m
//  刮刮乐
//
//  Created by WZH on 16/7/7.
//  Copyright © 2016年 WZH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatView];
}


- (void)creatView
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    
    
    self.label.text = [NSString stringWithFormat:@"%u万圆整",arc4random()%100];
    
    self.label.numberOfLines = 0;
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:30];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.label.frame];
    self.imageView.image = [UIImage imageNamed:@"123"];
    [self.view addSubview:self.imageView];

    
}

- (IBAction)btnAction:(id)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.label removeFromSuperview];
        [self.imageView removeFromSuperview];
        self.label = nil;
        self.imageView = nil;
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self creatView];
    }];
    
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 触摸任意位置
    UITouch *touch = touches.anyObject;
    // 触摸位置在图片上的坐标
    CGPoint cententPoint = [touch locationInView:self.imageView];
    // 设置清除点的大小
    CGRect  rect = CGRectMake(cententPoint.x, cententPoint.y, 20, 20);
    // 默认是去创建一个透明的视图
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
    // 获取上下文(画板)
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 把imageView的layer映射到上下文中
    [self.imageView.layer renderInContext:ref];
    // 清除划过的区域
    CGContextClearRect(ref, rect);
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束图片的画板, (意味着图片在上下文中消失)
    UIGraphicsEndImageContext();
    
    self.imageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
