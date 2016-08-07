//
//  XFLine.m
//  xf-drawing
//
//  Created by 朱晓峰 on 16/8/5.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XFLine.h"

@implementation XFLine
-(void)draw{

    UIBezierPath *bezier=[[UIBezierPath alloc]init];
    
    bezier.lineWidth=self.width;
    [bezier moveToPoint:self.start];
    [bezier addLineToPoint:self.end];
    [bezier stroke];
}
@end
