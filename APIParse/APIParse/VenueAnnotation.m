//
//  VenueAnnotation.m
//  APIParse
//
//  Created by MasterRyuX on 5/25/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import "VenueAnnotation.h"

@implementation VenueAnnotation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

            // Initialization code
            self.image = [UIImage imageNamed:@"coffeesmall.png"];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
