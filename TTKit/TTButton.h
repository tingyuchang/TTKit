//
//  TTButton.h
//  TTMsg
//
//  Created by TingYu Chang on 13/5/27.
//  Copyright (c) 2013年 TingYu Chang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTLabel.h"

@interface TTButton : UIButton{
    TTLabel *label;
}

-(void)setText:(NSString *)text;

@end
