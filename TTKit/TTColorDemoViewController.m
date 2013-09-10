//
//  TTColorDemoViewController.m
//  TTKit
//
//  Created by TinTint on 13/9/10.
//  Copyright (c) 2013年 TinTint. All rights reserved.
//

#import "TTColorDemoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TTColor.h"
#import <MBProgressHUD.h>
#import "TTFlowLayout.h"
#import "TTCell.h"

@interface TTColorDemoViewController (){

    NSDictionary *colorDict;

}

@end

@implementation TTColorDemoViewController

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
    
    [self.navigationItem setTitle:@"TTCOLOR"];
    
    [self show];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark Private Method
#pragma mark --

- (void)show{
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) collectionViewLayout:[[TTFlowLayout alloc] init]];
    [collectionView registerClass:[TTCell class] forCellWithReuseIdentifier:@"Cell"];
    [collectionView setBackgroundColor:[UIColor  clearColor]];
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    [self.view addSubview:collectionView];

}
//- (void)changeColorByRand{
//   
//    int randNum = rand()%[colorAry count];
//
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [hud setMode:MBProgressHUDModeText];
//    [hud setLabelText:[colorAry objectAtIndex:randNum]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        sleep(1);
//        CATransition *fadeTransition = [CATransition animation];
//        [fadeTransition setDuration:1.5];
//        [fadeTransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        fadeTransition.type = kCATransitionFade;
//        [fadeTransition setFillMode:kCAFillModeForwards];
//        [fadeTransition setRemovedOnCompletion:YES];
//        [self.view.layer addAnimation:fadeTransition forKey:@"fadeAnimation"];
//        [self.view setBackgroundColor:[TTColor colorFromHexRGB:[colorAry objectAtIndex:randNum]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//            
//        });
//        
//    });
//
//    
//    
//}


#pragma mark -- 
#pragma mark UICollectionView Data Source & Delegate
#pragma mark --

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[colorDict allKeys] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TTCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *key = [[colorDict allKeys] objectAtIndex:[indexPath row]];
    [cell setBackgroundColor:[TTColor colorFromHexRGB:key]];
    [cell.textLabel setText:[colorDict objectForKey:key]];
//    [cell setBackgroundColor:[TTColor colorFromHexRGB:[colorAry objectAtIndex:[indexPath row]]]];
    
    
    
    return cell;
    
    

}


@end
