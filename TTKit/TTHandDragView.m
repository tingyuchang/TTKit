//
//  TTHandDragView.m
//  TTMsg
//
//  Created by TingYu Chang on 13/5/24.
//  Copyright (c) 2013年 TingYu Chang. All rights reserved.
//

#import "TTHandDragView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TTHandDragView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [maskView setBackgroundColor:[UIColor blackColor]];
        [maskView setAlpha:0.5];
        [self addSubview:maskView];
        
        addLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [addLabel setBackgroundColor:[UIColor clearColor]];
        [addLabel setText:@"+"];
        [addLabel setTextColor:[UIColor whiteColor]];
        [addLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:addLabel];
        
        
        
        // UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchToZoom:)];
        // [self addGestureRecognizer:pinch];
        
        
    }
    return self;
}

#pragma mark Public Methd

-(void)setSisze:(CGSize)frameSize{
    [UIView animateWithDuration:0.1 animations:nil];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, frameSize.width, frameSize.height)];
    [maskView setFrame:CGRectMake(0, 0, frameSize.width, frameSize.height)];
    [addLabel setFrame:CGRectMake(0, 0, frameSize.width, frameSize.height)];
    [UIView commitAnimations];
}

#pragma UITouch Method

/*
- (void)pinchToZoom:(UIPinchGestureRecognizer *)recognizer{
    
    CGSize zoomSize = CGSizeMake(self.frame.size.width*recognizer.scale, self.frame.size.height*recognizer.scale);
    
    if (zoomSize.width > 290 || zoomSize.width < 70 ) {
        NSLog(@"too small");
    }else{
        [UIView animateWithDuration:0.1 animations:nil];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, zoomSize.width, zoomSize.height)];
        [maskView setFrame:CGRectMake(0, 0, zoomSize.width, zoomSize.height)];
        [addLabel setFrame:CGRectMake(0, 0, zoomSize.width, zoomSize.height)];
        [UIView commitAnimations];

    }
        
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    
    offset = [aTouch locationInView: self];
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
   
    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    self.frame = CGRectMake(location.x-offset.x, location.y-offset.y,
                            self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint location = self.center;
       
    BOOL modify = NO;
    if (location.x < self.frame.size.width/2) {
        location = CGPointMake(self.frame.size.width/2, location.y);
        modify = YES;
    }
    if (location.y < self.frame.size.height/2) {
        location = CGPointMake(location.x, self.frame.size.height/2);
        modify = YES;
    }
    if (location.x > self.superview.frame.size.width-self.frame.size.width/2) {
        location = CGPointMake(self.superview.frame.size.width-self.frame.size.width/2, location.y);
        modify = YES;
    }
    if (location.y > self.superview.frame.size.height-self.frame.size.height/2) {
        location = CGPointMake(location.x, self.superview.frame.size.height-self.frame.size.height/2);
        modify = YES;
    }


    if (modify) {
        [UIView animateWithDuration:0.1 animations:nil];
        [self setCenter:location];
        [UIView commitAnimations];
    }
    
    
    
    
    
    
}

@end
