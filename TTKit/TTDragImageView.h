//
//  TTDragImageView.h
//
//  Created by TingYu Chang on 13/5/27.
//  Copyright (c) 2013年 TingYu Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTDragImageView : UIImageView{
    CGPoint offset;
    CGAffineTransform currentTransform;
    
}
-(void)setEditable:(BOOL)edit;
-(void)setRotatable:(BOOL)r;
-(void)setScalable:(BOOL)s;

@end
