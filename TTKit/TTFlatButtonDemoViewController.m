//
//  TTFlatButtonDemoViewController.m
//  TTKit
//
//  Created by TinTint on 13/9/10.
//  Copyright (c) 2013年 TinTint. All rights reserved.
//

#import "TTFlatButtonDemoViewController.h"
#import "TTFlatButton.h"
#import "TTColor.h"
#import "SIAlertView.h"

@interface TTFlatButtonDemoViewController (){

    NSDictionary *colorDict;
}

@end

@implementation TTFlatButtonDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        colorDict = @{@"1abc9c": @"turquoise", @"2ecc71": @"emerland", @"3498db": @"peter-river", @"9b59b6": @"amethyst", @"34495e": @"wet-asphalt", @"16a085": @"green-sea", @"27ae60": @"nephritis", @"2980b9": @"belize-hole", @"8e44ad": @"wisteria", @"2c3e50": @"midnight-blue", @"f1c40f": @"sun-flower", @"f39c12": @"orange", @"e67e22": @"carrot", @"d35400": @"pumpkin", @"e74c3c": @"alizarin", @"c0392b": @"pomegranate", @"ecf0f1": @"clouds", @"bdc3c7": @"silver", @"95a5a6": @"concrete", @"7f8c8d": @"asbestos"};
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	int column = 0;
    int row = 0;
    
    for (int i = 0; i < [[colorDict allKeys] count]; i++) {
        
        TTFlatButton *flatButton = [TTFlatButton buttonWithType:UIButtonTypeCustom];
        [flatButton setFrame:CGRectMake(0, 0, 100, 40)];
        [flatButton setCenter:CGPointMake(55+105*column, 30+50*row)];
        NSString *key  = [[colorDict allKeys] objectAtIndex:i];
        [flatButton setup:[colorDict objectForKey:key] textColor:nil buttonColor:key];
        [flatButton addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        [flatButton setTag:i];
        [self.view addSubview:flatButton];
        
        
        if (column == 2) {
            column = 0;
            row++;
        }else{
            column++;
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark Private Method
#pragma mark --

- (void)show:(id)sender{
    TTFlatButton *myButton = (TTFlatButton *)sender;
    NSString *key  = [[colorDict allKeys] objectAtIndex:myButton.tag];
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"TTFlatButton" andMessage:[colorDict objectForKey:key]];
    [alertView setBackgroundColor:[TTColor colorFromHexRGB:key]];
    [alertView addButtonWithTitle:@"OK" type:SIAlertViewButtonTypeDefault handler:nil];
    [alertView show];
    
    
    
    
    
    
    

}


@end
