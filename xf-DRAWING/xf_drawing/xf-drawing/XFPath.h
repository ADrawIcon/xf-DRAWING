//
//  XFPath.h
//  xf-drawing
//
//  Created by 朱晓峰 on 16/8/5.
//  Copyright © 2016年 朱晓峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//typedef enum {
//    LINE,
//    RECT,
//    OVAL
//}TYPE;

@protocol XFPathdelegate <NSObject>

@optional
//画图
-(void)draw;

@end

@interface XFPath : NSObject<XFPathdelegate>

@property(nonatomic,assign)CGPoint start;

@property(nonatomic,assign)CGPoint end;

@property(nonatomic,strong)UIColor * color;

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)NSInteger tag;




@end
