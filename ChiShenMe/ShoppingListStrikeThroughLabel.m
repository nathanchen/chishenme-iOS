//
//  ShoppingListStrikeThroughLabel.m
//  ChiShenMe
//
//  Created by Nate on 28/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListStrikeThroughLabel.h"

const float STRIKETHROUGH_THICKNESS = 2.0F;

@implementation ShoppingListStrikeThroughLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _strikethroughLayer = [CALayer layer];
        _strikethroughLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        _strikethroughLayer.hidden = YES;
        [self.layer addSublayer:_strikethroughLayer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)resizeStrikeThrough
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributes
                                              context:nil];
    _strikethroughLayer.frame = CGRectMake(0, self.bounds.size.height / 2, rect.size.width, STRIKETHROUGH_THICKNESS);
    
}

- (void)setStrikethrough:(BOOL)strikethrough
{
    _strikethrough = strikethrough;
    _strikethroughLayer.hidden = !strikethrough;
}

@end
