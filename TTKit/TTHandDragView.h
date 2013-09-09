//
//  TTHandDragView.h
//  TTMsg
//
//  Created by TingYu Chang on 13/5/24.
//  Copyright (c) 2013年 TingYu Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTHandDragView : UIView{
    CGPoint offset;
    UIView *maskView;
    UILabel *addLabel;
}

-(void)setSisze:(CGSize)frameSize;


@end
