//
//  SetCardView.h
//  MatchCards
//
//  Created by Ofir Talmor on 18/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : UIView

@property (nonatomic) NSString *shape;
@property (nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
