//
//  TTButton.m
//  TTMsg
//
//  Created by TingYu Chang on 13/5/27.
//  Copyright (c) 2013年 TingYu Chang. All rights reserved.
//

#import "TTButton.h"


@implementation TTButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setText:(NSString *)text{
    if (label) {
        [label setText:text];
    }else{
        label = [[TTLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [label setText:text];
        [label setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:15.0f]];
        [self addSubview:label];
    }
   
}

@end
