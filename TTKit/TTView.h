//
//  TTView.h
//
//  Created by TinTint on 13/8/15.
//  Copyright (c) 2013年 TinTint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TTView : UIView<CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    UIImageView *imageView;
    NSArray *monthArray;
    CGFloat resizeRatio;
}


@property (strong, nonatomic) NSMutableDictionary *layoutDict;

-(id)initWithFrame:(CGRect)frame andLayput:(NSDictionary *)dict;
-(void)setImage:(UIImage *)image;
-(void)setText:(NSString *)text;
-(void)setFont:(NSString *)font;
-(void)setRadius:(BOOL)r;
-(void)setFrame:(BOOL)f;
-(void)settextPosition:(int)index;
-(BOOL)CheckEditText;
-(NSString *)getText;
-(void)changeLayout:(NSDictionary *)dict;
-(UIImage *)captureImageFromView;

-(BOOL)checkImage;

@end
