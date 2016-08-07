//
//  XFDraw.h
//  xf-drawing
//
//  Created by 朱晓峰 on 16/8/5.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    LINE,
    RECT,
    OVAL
}DRAWTYPE;
@interface XFDraw : UIView
@property(nonatomic,strong)UIColor *currentColor;
@property(nonatomic,assign )DRAWTYPE currentType;
@property(nonatomic,assign)CGFloat currentWidth;

-(void)undo;
-(void)clear;
-(void)save;

@end
