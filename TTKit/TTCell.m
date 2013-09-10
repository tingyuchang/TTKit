//
//  TTCell.m
//  TTKit
//
//  Created by TinTint on 13/9/10.
//  Copyright (c) 2013年 TinTint. All rights reserved.
//

#import "TTCell.h"

@implementation TTCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //tagLabel
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 25)];
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
        [self.textLabel setTextColor:[UIColor whiteColor]];
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        [self.textLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [self.textLabel setCenter:CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2)];
        [self.contentView addSubview:self.textLabel];
        
        
    }
    return self;
}

@end
