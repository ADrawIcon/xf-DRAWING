//
//  ViewController.m
//  xf-drawing
//
//  Created by 朱晓峰 on 16/8/5.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "ViewController.h"
#import "XFDraw.h"

//ifndef 没有被定义过，则执行下面的代码（防止重定义）
#ifndef W_H_
#define W_H_
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
#endif

#ifndef BARBUTTON_
#define BARBUTTON_
#define BARBUTTON(title, sel) [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:sel]
#endif

#define MAX_STROKE_WIDTH 10     // 最大线条粗细
#define MIN_STROKE_WIDTH 1      // 最小线条粗细
#define UNIT_STROKE_WIDTH 1     // 粗细的增量
#define COLOR_VIEW_MOVE_Y 169   // 选择颜色的视图显示或隐藏需要调整的Y坐标值

@interface ViewController ()
{
    XFDraw *view;
    UIView *colorView;
    BOOL colorVIewOn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    view = [[XFDraw alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//    view=[[XFDraw alloc]init];
    view.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:view];
    
    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, HEIGHT-44, WIDTH, 44)];
    toolbar.backgroundColor=[UIColor darkGrayColor];
    
    UIBarButtonItem *colorItem = BARBUTTON(@"颜色", @selector(chooseColor));
    
    SEL widthSel = @selector(chooseWidth:);
    UIBarButtonItem *minusItem = BARBUTTON(@"➖", widthSel);
    minusItem.tag = 400;
    UIBarButtonItem *addItem = BARBUTTON(@"➕", widthSel);
    addItem.tag = 401;
    
    SEL typeSel = @selector(chooseShapeType:);
    UIBarButtonItem *lineItem = BARBUTTON(@"线条", typeSel);
    lineItem.tag = 300;
    UIBarButtonItem *rectItem = BARBUTTON(@"矩形", typeSel);
    rectItem.tag = 301;
    UIBarButtonItem *ovalItem = BARBUTTON(@"椭圆", typeSel);
    ovalItem.tag = 302;
    
    UIBarButtonItem *undoItem = [[UIBarButtonItem alloc] initWithTitle:@"↩️" style:UIBarButtonItemStylePlain target:view action:@selector(undo)];
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"❌" style:UIBarButtonItemStylePlain target:view action:@selector(clear)];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:view action:@selector(save)];
 
    
    toolbar.items = @[colorItem, minusItem, addItem, lineItem, rectItem, ovalItem, undoItem, clearItem, saveItem];
    
    //隐藏colorView=将colorView的位置设在view之外
    colorView = [[UIView alloc] initWithFrame:CGRectMake(10, HEIGHT, WIDTH - 20, 120)];
    colorView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:colorView];
    
    NSArray *colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor greenColor], [UIColor cyanColor], [UIColor blueColor], [UIColor purpleColor], [UIColor brownColor], [UIColor magentaColor]];
    
    int unitCellWidth = (WIDTH - 20) / 4;
    
    
    [colors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"%ld",idx);
        NSLog(@"%ld",(NSInteger)stop);
        NSLog(@"%@",obj);
        
        UIButton *colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // 将按钮做成2行4列
        colorButton.frame = CGRectMake(10 + unitCellWidth * (idx % 4), 5 + 60 * (idx / 4), 50, 50);
        // 给按钮设置背景色
        colorButton.backgroundColor = colors[idx];
        // 将按钮修剪成圆圈并添加白边
        colorButton.layer.cornerRadius = 25;
        colorButton.layer.borderWidth = 1;
        colorButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [colorButton addTarget:self action:@selector(selectOneColor:) forControlEvents:UIControlEventTouchUpInside];
        [colorView addSubview:colorButton];
    }];
    [self.view addSubview:toolbar];
}
// 选择图形类型的回调方法
- (void) chooseShapeType:(UIBarButtonItem *) sender {
    view.currentType = (int)sender.tag - 300;
}

// 选中某个颜色的回调方法
- (void) selectOneColor:(UIButton *) sender {
    view.currentColor = sender.backgroundColor;
    if (colorVIewOn) {
        [self hideColorView];
    }
}

// 点击选择颜色的回调方法
- (void) chooseColor {
    if (!colorVIewOn) {
        [self showColorView];
    }
    else {
        [self hideColorView];
    }
}

// 显示选择颜色的视图
- (void) showColorView {
    CGRect frame = colorView.frame;
    frame.origin.y -= COLOR_VIEW_MOVE_Y;
    [UIView animateWithDuration:0.75 animations:^{
        colorView.frame = frame;
    }];
    colorVIewOn = YES;
}

// 隐藏选择颜色的视图
- (void) hideColorView {
    CGRect frame = colorView.frame;
    frame.origin.y += COLOR_VIEW_MOVE_Y;
    [UIView animateWithDuration:0.25 animations:^{
        colorView.frame = frame;
    }];
    colorVIewOn = NO;
}

// 点击选择粗细的回调方法
- (void) chooseWidth:(UIBarButtonItem *) sender {
    switch (sender.tag - 400) {
        case 0: //  减小线条粗细
            if (view.currentWidth > MIN_STROKE_WIDTH) {
                view.currentWidth -= UNIT_STROKE_WIDTH;
            }
            break;
        case 1: // 增加线条粗细
            if (view.currentWidth < MAX_STROKE_WIDTH) {
                view.currentWidth += UNIT_STROKE_WIDTH;
            }
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
