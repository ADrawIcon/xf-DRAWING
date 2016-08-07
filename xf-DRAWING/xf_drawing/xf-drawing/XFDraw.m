//
//  XFDraw.m
//  xf-drawing
//
//  Created by 朱晓峰 on 16/8/5.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XFDraw.h"
#import "XFLine.h"
#import "XFOval.h"
#import "XFRect.h"
@implementation XFDraw
{
    NSMutableArray *drawArr;
    XFPath *draw;
}
-(instancetype)init{
    if (self=[super init]) {
        drawArr=[NSMutableArray array];
        [self generateDefaultValue];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        drawArr = [NSMutableArray array];
        [self generateDefaultValue];
    }
    
    return self;
}
-(void)generateDefaultValue{
    _currentColor=[UIColor blackColor];
    _currentWidth=1;
    _currentType=LINE;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    switch (_currentType) {
        case LINE:
            draw =[[XFLine alloc]init];
            break;
        case OVAL:
            draw =[[XFOval alloc]init];
            break;
        case RECT:
            draw =[[XFRect alloc]init];
            break;
            
    }
    if (draw) {
        draw.width=_currentWidth;
        draw.color=_currentColor;
        draw.start=draw.end=[touch locationInView:self];
        [drawArr addObject:draw];
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (draw) {
        UITouch *touch=touches.anyObject;
        draw.end=[touch locationInView:self];
        [self setNeedsDisplay];
    }
}
-(void)undo{
    if (drawArr.count>0) {
        [drawArr removeLastObject];
        [self setNeedsDisplay];
    }
}
-(void)clear{
    if (drawArr.count>0) {
        [drawArr removeAllObjects];
        [self setNeedsDisplay];
    }
}
-(void)save{
    CGSize size=self.bounds.size;
    size.height-=44;
    UIGraphicsBeginImageContext(size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    UIGraphicsEndImageContext();
    
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    for (XFPath *path in drawArr) {
        [path draw];
    }
}















@end
