//
//  TTViewController.m
//  TTKit
//
//  Created by TinTint on 13/9/9.
//  Copyright (c) 2013年 TinTint. All rights reserved.
//

#import "TTViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TTColor.h"

@interface TTViewController ()

@end

@implementation TTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *changeColorBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [changeColorBtn setFrame:CGRectMake(0, 0, 100, 30)];
    [changeColorBtn setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [changeColorBtn setTitle:@"Change" forState:UIControlStateNormal];
    [changeColorBtn addTarget:self action:@selector(changeColorByRand) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:changeColorBtn];
                                          
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --
#pragma mark Private Method
#pragma mark --


- (void)changeColorByRand{
    NSArray *colorAry = @[@"1abc9c", @"2ecc71", @"3498db", @"9b59b6", @"34495e", @"16a085", @"27ae60", @"2980b9", @"8e44ad", @"2c3e50", @"f1c40f", @"f39c12", @"e67e22", @"d35400", @"e74c3c", @"c0392b", @"ecf0f1", @"bdc3c7", @"95a5a6", @"7f8c8d"];
    int randNum = rand()%[colorAry count];
    
    CATransition *fadeTransition = [CATransition animation];
    [fadeTransition setDuration:0.3];
    [fadeTransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    fadeTransition.type = kCATransitionFade;
    [fadeTransition setFillMode:kCAFillModeForwards];
    [fadeTransition setRemovedOnCompletion:YES];
    [self.view.layer addAnimation:fadeTransition forKey:@"fadeAnimation"];
    [self.view setBackgroundColor:[TTColor colorFromHexRGB:[colorAry objectAtIndex:randNum]]];
    
    
    

}


@end
