//
//  TileView.m
//  IPhoneTest
//
//  Created by Lovells on 13-8-27.
//  Copyright (c) 2013年 Luwei. All rights reserved.
//

#import "TileView.h"

#define kLabelWidth     30.f
#define kLabelHeight    30.f

static int counter = 0;

@interface TileView ()

@end

@implementation TileView

- (id)initWithTarget:(id)target action:(SEL)action
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0.605 green:0.000 blue:0.007 alpha:1.000];
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:panGestureRecognizer];
        
        [self createLabelAndAddToSelf];
    }
    return self;
}

- (void)createLabelAndAddToSelf
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 90, kLabelWidth, kLabelHeight)];
    label.text = [NSString stringWithFormat:@"%i", ++counter];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor whiteColor] set];
    
    // 填充白色圆角矩形
    CGFloat rwk = 0.5f;
    CGFloat rhk = 0.34f;
    CGRect drawRect = CGRectMake(rect.size.width * (1 - rwk) / 2, rect.size.height * (1 - rhk) / 2,
                                 rect.size.width * rwk, rect.size.height * rhk);
    [[UIBezierPath bezierPathWithRoundedRect:drawRect cornerRadius:5] fill];
    
    // 填充白色三角形
    CGFloat twk = 0.3 * rwk;
    CGFloat thk = 0.2 * rhk;
    CGAffineTransform transform = CGAffineTransformMakeTranslation(rect.size.width * 0.5,
                                                                   drawRect.origin.y + drawRect.size.height);
    CGMutablePathRef trianglePath = CGPathCreateMutable();
    CGPathMoveToPoint(trianglePath, &transform, 0, 0);
    CGPathAddLineToPoint(trianglePath, &transform, rect.size.width * twk, 0);
    CGPathAddLineToPoint(trianglePath, &transform, rect.size.width * twk * 1.2, rect.size.height * thk);
    CGPathCloseSubpath(trianglePath);
    
    CGContextRef context =  UIGraphicsGetCurrentContext();
    CGContextAddPath(context, trianglePath);
    CGContextFillPath(context);
    
    // 画两个背景色的小圆点
    [self.backgroundColor set];
    CGFloat midy = drawRect.origin.y + drawRect.size.height / 2;
    [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, midy - 5 - 4, 4, 4)] fill];
    [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, midy + 5, 4, 4)] fill];
    
    CGContextSetLineWidth(context, 2.f);
    
    // 画背景色的直线
    CGContextMoveToPoint(context, 57, midy);
    CGContextAddLineToPoint(context, 65, midy);
    CGContextStrokePath(context);
    
    // 画背景色的弧
    //    CGContextMoveToPoint(context, 65, midy - 15);
    //    CGContextAddLineToPoint(context, 75, midy);
    //    CGContextAddLineToPoint(context, 65, midy + 15);
    CGContextMoveToPoint(context, 69, midy - 13);
    CGContextAddArcToPoint(context, 79, midy, 69, midy + 13, 20);
    CGContextStrokePath(context);
}

@end
