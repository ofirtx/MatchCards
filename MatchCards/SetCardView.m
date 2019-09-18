//
//  SetCardView.m
//  MatchCards
//
//  Created by Ofir Talmor on 18/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#pragma mark - Properties

- (void)setShape:(NSString *)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShading:(NSUInteger)shading{
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setNumber:(NSUInteger)number{
    _number = number;
    [self setNeedsDisplay];
}

#pragma mark - drawing shapes

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (void)addShadeToPath:(UIBezierPath *)path{
    
}

- (void)drawDiamondAtPoint:(CGPoint)point{
    UIBezierPath* squarePath = [UIBezierPath bezierPathWithRect: CGRectMake(point.x,point.y,self.bounds.size.width / 4 ,self.bounds.size.width / 4)];
    [self addShadeToPath:squarePath];
}

- (void)drawSquiggleAtPoint:(CGPoint)point{
    UIBezierPath* polygonPath = [UIBezierPath bezierPath];
    [polygonPath moveToPoint: CGPointMake(point.x, point.y - self.bounds.size.width / 8)];
    [polygonPath addLineToPoint: CGPointMake(point.x - self.bounds.size.width / 16 , point.y + self.bounds.size.width / 16)];
    [polygonPath addLineToPoint: CGPointMake(point.x + self.bounds.size.width / 16 , point.y + self.bounds.size.width / 16)];
    [polygonPath closePath];
    [self addShadeToPath:polygonPath];
}

- (void)drawOvalAtPoint:(CGPoint)point{
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(point.x,point.y,self.bounds.size.width / 4 ,self.bounds.size.width / 4)];
    [self addShadeToPath:ovalPath];
}

- (void)drawShapes{
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    if([self.shape isEqualToString: @"■"]){
        [self drawDiamondAtPoint:center];
    }
    else if ([self.shape isEqualToString: @"●"]){
        [self drawOvalAtPoint:center];
    }
    else if ([self.shape isEqualToString: @"▲"]){
        [self drawSquiggleAtPoint:center];
    }
}

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [self drawShapes];
}

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
