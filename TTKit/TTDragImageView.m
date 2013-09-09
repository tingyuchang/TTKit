//
//  TTDragImageView.m
//
//  Created by TingYu Chang on 13/5/27.
//  Copyright (c) 2013年 TingYu Chang. All rights reserved.
//

#import "TTDragImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "SIAlertView.h"

@implementation TTDragImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UISwipeGestureRecognizer *swipeToDelete = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deleteMyself:)];
        [swipeToDelete setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:swipeToDelete];
    
        currentTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        
        
        
        
        

        /*
        UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePiece:)];
        [self addGestureRecognizer:rotationGesture];
        */
        /*
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
        [self addGestureRecognizer:pinchGesture];
        */
    }
    return self;
}


#pragma mark Public Method

-(void)setRotatable:(BOOL)r{
    if (r) {
        UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePiece:)];
        [self addGestureRecognizer:rotationGesture];
    }
}
-(void)setScalable:(BOOL)s{
    if (s) {
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
        [self addGestureRecognizer:pinchGesture];
    }
}

#pragma mark UITouch Method


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.superview bringSubviewToFront:self];
    
    currentTransform = self.transform;
    self.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    UITouch *aTouch = [touches anyObject];
    
    offset = [aTouch locationInView: self];
    self.transform = currentTransform;
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    self.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    [self setCenter:CGPointMake(location.x-offset.x+self.frame.size.width/2, location.y-offset.y+self.frame.size.height/2)];
    self.transform = currentTransform;
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.transform = currentTransform;
}
/* 防止超過邊界
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
*/
- (void)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer {
    // [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    self.transform = currentTransform;
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        self.transform = CGAffineTransformRotate(self.transform, [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0]; 
    }
    
    currentTransform = self.transform;
}
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer {
    // [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    self.transform= currentTransform;
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
    }
    
    currentTransform = self.transform;
}
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint locationInView = [gestureRecognizer locationInView:self];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:self.superview];
        
        self.layer.anchorPoint = CGPointMake(locationInView.x / self.bounds.size.width, locationInView.y / self.bounds.size.height);
        self.center = locationInSuperview;
    }
}


- (void)deleteMyself:(id)sender{
    
    
    
//    CATransition *tr = [CATransition  animation];
//    tr.duration = 0.3;
//    tr.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    tr.fillMode = kCAFillModeForwards;
//    [tr setFillMode:@"extended"];
//    [tr setRemovedOnCompletion:NO];
//   
//    [self.layer addAnimation:tr forKey:@"pageCurlAnimation"];
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"刪除物件" andMessage:nil];
    [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
    [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView addButtonWithTitle:@"確定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView){
        [self removeFromSuperview];
    }];
    [alertView show];
    
}


- (void)setEditable:(BOOL)edit{
    [self setUserInteractionEnabled:edit];
    
    if (edit) {
        [[self layer] setBorderColor:[[UIColor whiteColor] CGColor]];
        [[self layer] setBorderWidth:1.0f];
        // [self setBackgroundColor:[UIColor blackColor]];
        // [self setAlpha:0.7f];
    } else {
        [[self layer] setBorderColor:[[UIColor clearColor] CGColor]];
        [[self layer] setBorderWidth:0];
        // [self setBackgroundColor:[UIColor clearColor]];
        // [self setAlpha:1.0f];
    }
    
}

@end
