//
//  XFPath.m
//  xf-drawing
//
//  Created by 朱晓峰 on 16/8/5.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import "XFPath.h"

@implementation XFPath
-(void)draw{
    CGFloat x=self.start.x < self.end.x ?self.start.x:self.end.x;
    CGFloat y=self.start.y<self.end.y ?self.start.y:self.end.y;
    CGFloat xfwidth=fabs(self.start.x-self.end.x);
    CGFloat height=fabs(self.start.y-self.end.y);
    UIBezierPath *bezier;
    if (self.tag==0) {
        bezier=[UIBezierPath bezierPathWithRect:CGRectMake(x, y, xfwidth, height)];
    }
    else if(self.tag==1){
    bezier=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, xfwidth, height)];
    }
    
    bezier.lineWidth=self.width;
    [self.color setStroke];
    [bezier stroke];
}
@end
