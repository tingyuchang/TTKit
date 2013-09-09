//
//  TTFlatButton.m
//
//  Created by TinTint on 13/8/16.
//  Copyright (c) 2013年 TinTint. All rights reserved.
//

#import "TTFlatButton.h"
#import "TTColor.h"
#import <QuartzCore/QuartzCore.h>

@implementation TTFlatButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




- (void)setup:(NSString *)buttontext textColor:(NSString *)textColorStr buttonColor:(NSString *)backColorStr{

    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*2, self.frame.size.height*2)];
    
    if (backColorStr) {
        [buttonView setBackgroundColor:[TTColor colorFromHexRGB:backColorStr]];
    }else{
        [buttonView setBackgroundColor:[TTColor colorFromHexRGB:@"16a085"]];
    }

    
    if (buttontext.length > 0) {
        TTLabel *label = [[TTLabel alloc] initWithFrame:buttonView.frame];
        [label setText:buttontext];
        [label setFont:[UIFont fontWithName:@"MicrosoftJhengHeiRegular" size:self.frame.size.height*0.8]];
        //  Papyrus
        [buttonView addSubview:label];
       
        
        
        if (textColorStr) {
            [label setTextColor:[TTColor colorFromHexRGB:textColorStr]];
        }else{
            [label setTextColor:[UIColor whiteColor]];
        }
    }
    
    [self setImage:[self captureImageFromView:buttonView] forState:UIControlStateNormal];
    
    [[self layer] setCornerRadius:self.frame.size.width/20];
    [[self layer] setMasksToBounds:YES];

}


- (UIImage *)captureImageFromView:(UIView *)targetView {
    //設定邊界大小和影像透明度與比例
    UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, NO, 0.0);
    [targetView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //取得影像
    UIImage *captureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return captureImage;
}

@end
