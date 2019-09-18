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

#define STROKE_WIDTH 0.02;
#define STRIPES_DISTANCE_FACTOR 0.03
#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (void)addShadeToPath:(UIBezierPath *)path{
    if(self.shading == 2) {
        [self addSolidShadingToPath:path];
    }
    else if(self.shading == 1){
        [self addStripedShadingToPath:path];
    }
    else if(self.shading == 0){
        [self addClearShadingToPath:path];
    }
}

- (void)addSolidShadingToPath:(UIBezierPath *)path{
    [[self getColor] setFill];
    [path fill];
}

- (void)addStripedShadingToPath:(UIBezierPath *)path{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [path addClip];
    UIBezierPath *shading = [UIBezierPath bezierPath];
    CGPoint p1 = self.bounds.origin;
    CGPoint p2 = CGPointMake(p1.x, p1.y + self.bounds.size.height);
    while (p1.x < self.bounds.size.width){
        [shading moveToPoint:p1];
        [shading addLineToPoint:p2];
        p1.x = p1.x + self.bounds.size.width * STRIPES_DISTANCE_FACTOR;
        p2.x = p2.x + self.bounds.size.width * STRIPES_DISTANCE_FACTOR;
    }
    shading.lineWidth = self.bounds.size.width / 2 * STROKE_WIDTH;
    [[self getColor] setStroke];
    [shading stroke];
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)addClearShadingToPath:(UIBezierPath *)path{
    [UIColor.clearColor setFill];
    [path fill];
}

- (void)drawDiamondAtPoint:(CGPoint)point{
    UIBezierPath* diamondPath = [UIBezierPath bezierPath];
    [diamondPath moveToPoint:CGPointMake(point.x - self.bounds.size.width / 4, point.y)];
    [diamondPath addLineToPoint:CGPointMake(point.x, point.y - self.bounds.size.width / 8)];
    [diamondPath addLineToPoint:CGPointMake(point.x + self.bounds.size.width / 4, point.y)];
    [diamondPath addLineToPoint:CGPointMake(point.x, point.y + self.bounds.size.width / 8)];
    [diamondPath closePath];
    [self addShadeToPath:diamondPath];
    [[self getColor] setStroke];
    [diamondPath stroke];
}

#define SQUIGGLE_WIDTH 0.3
#define SQUIGGLE_HEIGHT 0.1
#define SQUIGGLE_FACTOR 0.8
#define SYMBOL_LINE_WIDTH 0.0

- (void)drawSquiggleAtPoint:(CGPoint)point {
    CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
    CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
    CGFloat dsqx = dx * SQUIGGLE_FACTOR;
    CGFloat dsqy = dy * SQUIGGLE_FACTOR;
    UIBezierPath *squigglePath = [[UIBezierPath alloc] init]; // TODO rotate by 90 degrees somehow
    [squigglePath moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
    [squigglePath addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
                 controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
    [squigglePath addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
            controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
            controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
    [squigglePath addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
                 controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
    [squigglePath addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
            controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
            controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
    [self addShadeToPath:squigglePath];
    [[self getColor] setStroke];
    [squigglePath stroke];
}

- (void)drawOvalAtPoint:(CGPoint)point{
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(point.x - self.bounds.size.width / 8, point.y - self.bounds.size.width / 8, self.bounds.size.width / 4, self.bounds.size.width / 4)];
    [self addShadeToPath:ovalPath];
    [[self getColor] setStroke];
    [ovalPath stroke];
}

- (void)drawShapeAtPoint:(CGPoint)point{
    if([self.shape isEqualToString: @"■"]){
        [self drawDiamondAtPoint:point];
    }
    else if ([self.shape isEqualToString: @"●"]){
        [self drawOvalAtPoint:point];
    }
    else if ([self.shape isEqualToString: @"▲"]){
        [self drawSquiggleAtPoint:point];
    }
}

- (void)drawSingleShape{
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self drawShapeAtPoint:center];
}

- (void)draw2Shapes{
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self drawShapeAtPoint:CGPointMake(center.x, center.y  - self.bounds.size.width / 6)];
    [self drawShapeAtPoint:CGPointMake(center.x, center.y  + self.bounds.size.width / 6)];
}

- (void)draw3Shapes{
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self drawShapeAtPoint:center];
    [self drawShapeAtPoint:CGPointMake(center.x, center.y  - self.bounds.size.width / 3)];
    [self drawShapeAtPoint:CGPointMake(center.x, center.y  + self.bounds.size.width / 3)];
}

- (void)drawShapes{
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    if(self.number == 0){
        [self drawSingleShape];
    }
    else if (self.number == 1){
        [self draw2Shapes];
    }
    else if (self.number == 2){
        [self draw3Shapes];
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

- (UIColor *)getColor{
    if ([self.color isEqualToString:@"red"])  return UIColor.redColor;
    if([self.color isEqualToString:@"green"]) return UIColor.greenColor;
    if([self.color isEqualToString:@"blue"]) return UIColor.purpleColor;
    return UIColor.blackColor;
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
