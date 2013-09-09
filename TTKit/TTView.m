//
//  TTView.m
//
//  Created by TinTint on 13/8/15.
//  Copyright (c) 2013年 TinTint. All rights reserved.
//

#import "TTView.h"
#import "TTColor.h"
#import "TTLabel.h"
#import <QuartzCore/QuartzCore.h>



@implementation TTView

- (id)initWithFrame:(CGRect)frame andLayput:(NSDictionary *)dict
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layoutDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:imageView];
        
        
        monthArray = [[NSArray alloc] initWithObjects:@"JAN", @"FEB", @"MAR", @"APR", @"MAY", @"JUN", @"JUL", @"AUG", @"SEP", @"OCT", @"NOV", @"DEC", nil];
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager startUpdatingLocation];
        
        resizeRatio = frame.size.width/290;
        
        
        [self setup];
    }
    return self;
}

- (void)setup{
    // set frame
    
//    NSDictionary *frameDict = [self.layoutDict objectForKey:@"frame"];
//    
//    [[self layer] setBorderColor:[[TTColor colorFromHexRGB:[frameDict objectForKey:@"color"]] CGColor]];
//    [[self layer] setBorderWidth:[[frameDict objectForKey:@"width"] floatValue]*resizeRatio];
//    if ([frameDict objectForKey:@"cornerRadius"]) {
//        
//        if ([frameDict objectForKey:@"width"]) {
//            [self setBackgroundColor:[TTColor colorFromHexRGB:[frameDict objectForKey:@"color"]]];
//            CGFloat moveWidth = [[frameDict objectForKey:@"width"] floatValue]*resizeRatio;
//            [imageView setFrame:CGRectMake(moveWidth, moveWidth, self.frame.size.width/self.transform.a-2*moveWidth, self.frame.size.height/self.transform.d-2*moveWidth)];
//            
//        }else{
//            [self setBackgroundColor:[UIColor clearColor]];
//        }
//        
//        
//        
//        
//        [[imageView layer] setCornerRadius:[[frameDict objectForKey:@"cornerRadius"] floatValue]*resizeRatio];
//        [[imageView layer] setMasksToBounds:YES];
//    }
    [self setFrame:YES];
    
    // set logo
    
    
    if ([self.layoutDict objectForKey:@"logo"]) {
        NSDictionary *logoDict = [self.layoutDict objectForKey:@"logo"];
        
        UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake([[logoDict objectForKey:@"x"] floatValue]*resizeRatio, [[logoDict objectForKey:@"y"] floatValue]*resizeRatio, [[logoDict objectForKey:@"w"] floatValue]*resizeRatio, [[logoDict objectForKey:@"h"] floatValue]*resizeRatio)];
        
        if ([logoDict objectForKey:@"name"]) {
            [logoImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [logoDict objectForKey:@"name"]]]];
        }else{
            [logoImageView setImage:[UIImage imageNamed:@"logo.png"]];
        
        }
        [self addSubview:logoImageView];
        
        
    }
    
    // set color zone
    
    NSArray *shadowArray = [self.layoutDict objectForKey:@"shadow"];
    for (NSDictionary *dict in shadowArray) {
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake([[dict objectForKey:@"x"] floatValue]*resizeRatio, [[dict objectForKey:@"y"] floatValue]*resizeRatio, [[dict objectForKey:@"w"] floatValue]*resizeRatio, [[dict objectForKey:@"h"] floatValue]*resizeRatio)];
        [shadowView setBackgroundColor:[TTColor colorFromHexRGB:[dict objectForKey:@"color"]]];
        [shadowView setAlpha:[[dict objectForKey:@"alpha"] floatValue]];
        [self addSubview:shadowView];
    }
    
    // set Label
    
    NSDictionary *labelDict = [self.layoutDict objectForKey:@"label"];
    
    for (NSString *key in [labelDict allKeys]) {
        
        NSDictionary *dict = [labelDict objectForKey:key];
        
        TTLabel *label = [[TTLabel alloc] initWithFrame:CGRectMake([[dict objectForKey:@"x"] floatValue]*resizeRatio, [[dict objectForKey:@"y"] floatValue]*resizeRatio, [[dict objectForKey:@"w"] floatValue]*resizeRatio, [[dict objectForKey:@"h"] floatValue]*resizeRatio)];
        [label setFont:[UIFont fontWithName:[dict objectForKey:@"font"] size:[[dict objectForKey:@"fontsize"] floatValue]*resizeRatio]];
        switch ([[dict objectForKey:@"alignment"] intValue]) {
            case 1:
                [label setTextAlignment:NSTextAlignmentLeft];
                break;
            case 2:
                [label setTextAlignment:NSTextAlignmentCenter];
                break;
            case 3:
                [label setTextAlignment:NSTextAlignmentRight];
                break;
            default:
                [label setTextAlignment:NSTextAlignmentCenter];
                break;
        }
        if ([dict objectForKey:@"backgroundColor"]) {
            [label setBackgroundColor:[TTColor colorFromHexRGB:[dict objectForKey:@"backgroundColor"]]];
        }
        
        if ([dict objectForKey:@"color"]) {
            [label setTextColor:[TTColor colorFromHexRGB:[dict objectForKey:@"color"]]];
        }
        [self addSubview:label];
        
        if ([key isEqualToString:@"month"]) {
            NSDate *date = [NSDate date];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM"];
            NSString* str = [formatter stringFromDate:date];
            [label setText:[monthArray objectAtIndex:[str intValue]-1]];
        }
        if ([key isEqualToString:@"day"]) {
            NSDate *date = [NSDate date];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd"];
            NSString* str = [formatter stringFromDate:date];
            [label setText:str];
        }
        if ([key isEqualToString:@"year"]) {
            NSDate *date = [NSDate date];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy"];
            NSString* str = [formatter stringFromDate:date];
            [label setText:str];
            
        }
        if ([key isEqualToString:@"logo"]) {
            [label setText:@"TinTint.Com"];
        }
        if ([key isEqualToString:@"title"]) {
            [label setNumberOfLines:0];
            [label setLineBreakMode:NSLineBreakByWordWrapping];
            [label setText:[dict objectForKey:@"text"]];
            
            [self reSizeLabel:label layoutInfo:dict];
            
                        
            [label setTag:1];
            // add edit gesture
        }
        if ([key isEqualToString:@"location"]) {
            [label setText:[self getLocationString:CLLocationCoordinate2DMake(0, 0)]];

            
        }
        
    }
    
}
- (void)setImage:(UIImage *)image{
//    NSLog(@"imagesize: %f*%f", image.size.width, image.size.height);
    [imageView setImage:image];
}
- (void)setText:(NSString *)text{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[TTLabel class]]) {
            if (subView.tag == 1) {
                [(TTLabel *)subView setText:text];
                
                NSDictionary *labelDict = [self.layoutDict objectForKey:@"label"];
                NSDictionary *dict = [labelDict objectForKey:@"title"];
                
                [self reSizeLabel:(TTLabel *)subView layoutInfo:dict];

            }
            
            
        }
    }

}
- (void)setFont:(NSString *)font{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[TTLabel class]]) {
            if (subView.tag == 1) {
                
                NSDictionary *labelDict = [self.layoutDict objectForKey:@"label"];
                NSDictionary *dict = [labelDict objectForKey:@"title"];
                [(TTLabel *)subView setFont:[UIFont fontWithName:font size:[[dict objectForKey:@"fontsize"] floatValue]*resizeRatio]];
                
                [self reSizeLabel:(TTLabel *)subView layoutInfo:dict];
                
            }
            
            
        }
    }

}
- (void)setRadius:(BOOL)r{
    
     NSDictionary *frameDict = [self.layoutDict objectForKey:@"frame"];
    
    
    if (r) {
        // 有圓角
        if ([frameDict objectForKey:@"width"]) {
            [self setBackgroundColor:[TTColor colorFromHexRGB:[frameDict objectForKey:@"color"]]];
            CGFloat moveWidth = [[frameDict objectForKey:@"width"] floatValue]*resizeRatio;
            [imageView setFrame:CGRectMake(moveWidth, moveWidth, self.frame.size.width/self.transform.a-2*moveWidth, self.frame.size.height/self.transform.d-2*moveWidth)];
            
        }else{
            [self setBackgroundColor:[UIColor clearColor]];
        }

        [[imageView layer] setCornerRadius:[[frameDict objectForKey:@"cornerRadius"] floatValue]*resizeRatio];
        [[imageView layer] setMasksToBounds:YES];

    
    }else{
        // 沒有
        [self setBackgroundColor:[UIColor clearColor]];
        [[imageView layer] setCornerRadius:0];
        [[imageView layer] setMasksToBounds:NO];

    }

}
- (void)setFrame:(BOOL)f{
    NSDictionary *frameDict = [self.layoutDict objectForKey:@"frame"];
    if (f) {
        [[self layer] setBorderColor:[[TTColor colorFromHexRGB:[frameDict objectForKey:@"color"]] CGColor]];
        [[self layer] setBorderWidth:[[frameDict objectForKey:@"width"] floatValue]*resizeRatio];
        
        if ([frameDict objectForKey:@"cornerRadius"]) {
            
            if ([frameDict objectForKey:@"width"]) {
                [self setBackgroundColor:[TTColor colorFromHexRGB:[frameDict objectForKey:@"color"]]];
                CGFloat moveWidth = [[frameDict objectForKey:@"width"] floatValue]*resizeRatio;
                [imageView setFrame:CGRectMake(moveWidth, moveWidth, self.frame.size.width/self.transform.a-2*moveWidth, self.frame.size.height/self.transform.d-2*moveWidth)];
                
            }else{
                [self setBackgroundColor:[UIColor clearColor]];
            }
            
            [[imageView layer] setCornerRadius:[[frameDict objectForKey:@"cornerRadius"] floatValue]*resizeRatio];
            [[imageView layer] setMasksToBounds:YES];
        }

    }else{
        [[self layer] setBorderColor:[[UIColor clearColor] CGColor]];
        [self setBackgroundColor:[UIColor clearColor]];
        [[self layer] setBorderWidth:0];
        
        if ([frameDict objectForKey:@"width"]) {
            [self setBackgroundColor:[TTColor colorFromHexRGB:[frameDict objectForKey:@"color"]]];
            CGFloat moveWidth = [[frameDict objectForKey:@"width"] floatValue]*resizeRatio;
            [imageView setFrame:CGRectMake(0, 0, self.frame.size.width/self.transform.a+2*moveWidth, self.frame.size.height/self.transform.d+2*moveWidth)];
            
        }
        
        [self setRadius:NO];
        
    }
    
    
}
- (void)settextPosition:(int)index{
   
    

    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[TTLabel class]]) {
            if (subView.tag == 1) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[[self.layoutDict objectForKey:@"label"] objectForKey:@"title"]];
                switch (index) {
                    case 1:
                        // 左上
                        [dict setValue:@"1" forKey:@"alignment"];
                        [dict setValue:@"25" forKey:@"h"];
                        [dict setValue:@"250" forKey:@"w"];
                        [dict setValue:@"20" forKey:@"x"];
                        [dict setValue:@"20" forKey:@"y"];
                        break;
                    case 2:
                        // 右上
                        [dict setValue:@"3" forKey:@"alignment"];
                        [dict setValue:@"25" forKey:@"h"];
                        [dict setValue:@"200" forKey:@"w"];
                        [dict setValue:@"75" forKey:@"x"];
                        [dict setValue:@"20" forKey:@"y"];
                        break;
                    case 3:
                        // 左中
                        [dict setValue:@"1" forKey:@"alignment"];
                        [dict setValue:@"25" forKey:@"h"];
                        [dict setValue:@"250" forKey:@"w"];
                        [dict setValue:@"20" forKey:@"x"];
                        [dict setValue:@"120" forKey:@"y"];
                        break;
                    case 4:
                        // 右中
                        [dict setValue:@"3" forKey:@"alignment"];
                        [dict setValue:@"25" forKey:@"h"];
                        [dict setValue:@"200" forKey:@"w"];
                        [dict setValue:@"75" forKey:@"x"];
                        [dict setValue:@"120" forKey:@"y"];
                        break;
                    case 5:
                        // 左下
                        [dict setValue:@"1" forKey:@"alignment"];
                        [dict setValue:@"25" forKey:@"h"];
                        [dict setValue:@"250" forKey:@"w"];
                        [dict setValue:@"20" forKey:@"x"];
                        [dict setValue:@"240" forKey:@"y"];
                        break;
                    case 6:
                        // 右下
                        [dict setValue:@"3" forKey:@"alignment"];
                        [dict setValue:@"25" forKey:@"h"];
                        [dict setValue:@"200" forKey:@"w"];
                        [dict setValue:@"75" forKey:@"x"];
                        [dict setValue:@"240" forKey:@"y"];
                        break;
                    default:
                        break;
                }
                switch ([[dict objectForKey:@"alignment"] intValue]) {
                    case 1:
                        [(TTLabel *)subView setTextAlignment:NSTextAlignmentLeft];
                        break;
                    case 2:
                        [(TTLabel *)subView setTextAlignment:NSTextAlignmentCenter];
                        break;
                    case 3:
                        [(TTLabel *)subView setTextAlignment:NSTextAlignmentRight];
                        break;
                    default:
                        [(TTLabel *)subView setTextAlignment:NSTextAlignmentCenter];
                        break;
                }

                
                
               
                
                
                NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:[self.layoutDict objectForKey:@"label"]];
                
                [tempDict setObject:dict forKey:@"title"];
                
                [self.layoutDict setObject:[[NSDictionary alloc] initWithDictionary:tempDict] forKey:@"label"];
                
                [self reSizeLabel:(TTLabel *)subView layoutInfo:dict];
            }
        }
    }

    

}
- (BOOL)CheckEditText{
     NSDictionary *labelDict = [self.layoutDict objectForKey:@"label"];
    if ([labelDict objectForKey:@"title"]) {
        return YES;
    }else{
        return NO;
    }
    

}
-(NSString *)getText{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[TTLabel class]]) {
            if (subView.tag == 1) {
                return [(TTLabel *)subView text];
                break;
            }
            
            
        }
    }
    return nil;

}
- (void)changeLayout:(NSDictionary *)dict{
    self.layoutDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    NSString *tempStr;
    for (UIView *subView in self.subviews) {
        if (subView != imageView) {
            [subView removeFromSuperview];
        }
        if (subView.tag == 1) {
            tempStr = [(TTLabel *)subView text];
        }
        
    }
    
    [self setup];
    
    [self setText:tempStr];
}

- (UIImage *)captureImageFromView {
    //設定邊界大小和影像透明度與比例
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //取得影像
    UIImage *captureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return captureImage;
}
- (BOOL)checkImage{
    if (imageView.image) {
        return YES;
    }else{
        return NO;
    }

}

-(NSString *)getLocationString:(CLLocationCoordinate2D)coordinate{
    // location API
    NSString *urlString;
    if (coordinate.latitude != 0 && coordinate.longitude != 0) {
        
        urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?latlng=%f,%f&sensor=true&language=zh-TW", coordinate.latitude, coordinate.longitude];
    }else{
        urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?latlng=%f,%f&sensor=true&language=zh-TW", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
        
    }
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *requestData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error;
    NSDictionary *addressDict = [[NSJSONSerialization JSONObjectWithData:requestData options:0 error:&error] objectForKey:@"results"];
    NSString *country;
    NSString *area;
    
    for (NSDictionary *dict in addressDict) {
        NSArray *addDetailArray =[dict objectForKey:@"address_components"];
        
        for (NSDictionary *addDetailDict in addDetailArray) {
            NSArray *types = [addDetailDict objectForKey:@"types"];
            if ([types containsObject:@"country"]) {
                country = [addDetailDict objectForKey:@"long_name"];
            }
            if ([types containsObject:@"administrative_area_level_2"]) {
                area = [addDetailDict objectForKey:@"long_name"];
            }
            
        }
    }
    
    return [NSString stringWithFormat:@"%@, %@", area, country];
    
}
- (void)reSizeLabel:(TTLabel *)label layoutInfo:(NSDictionary *)dict{

    UIFont *font = [UIFont fontWithName:[dict objectForKey:@"font"] size:[[dict objectForKey:@"fontsize"] floatValue]*resizeRatio];
    //设置一个行高上限
    CGSize size = CGSizeMake([[dict objectForKey:@"w"] floatValue]*resizeRatio, [[dict objectForKey:@"h"] floatValue]*resizeRatio);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelSize = [label.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    switch ([[dict objectForKey:@"alignment"] intValue]) {
        case 1:
            // left
            [label setFrame:CGRectMake([[dict objectForKey:@"x"] floatValue]*resizeRatio, [[dict objectForKey:@"y"] floatValue]*resizeRatio, labelSize.width, labelSize.height)];
            break;
            // center
         case 2:
            [label setFrame:CGRectMake(0, [[dict objectForKey:@"y"] floatValue]*resizeRatio, labelSize.width, labelSize.height)];
            [label setCenter:CGPointMake([[dict objectForKey:@"x"] floatValue]*resizeRatio+([[dict objectForKey:@"w"] floatValue]*resizeRatio)*0.5, label.center.y)];
            break;
         case 3:
            // left
            [label setFrame:CGRectMake([[dict objectForKey:@"x"] floatValue]*resizeRatio+[[dict objectForKey:@"w"] floatValue]*resizeRatio-labelSize.width, [[dict objectForKey:@"y"] floatValue]*resizeRatio, labelSize.width, labelSize.height)];
            break;
        default:
            break;
    }
    
    
    
    
}



@end
